/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Stored Procedure DDL                                                                 │
  │   AdventureWorks_0006.logging.usp_EventMessage_Log
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
      Logs an event message to logging.EventMessage, also using RAISERROR w/ NOWAIT option to
      print message immediatly to the message stream
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ────────────────────────────────────────────────────────────── │
      2018.12.12 bwarner         Initial Draft
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ NOTES:                                                                                      │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤

      BOL RAISEERROR Severity: 
      ========================

      https://docs.microsoft.com/en-us/sql/relational-databases/errors-events/database-engine-error-severities?view=sql-server-2017

      severity
      Is the user-defined severity level associated with this message. When using msg_id 
      to raise a user-defined message created using sp_addmessage, the severity specified 
      on RAISERROR overrides the severity specified in sp_addmessage.

      Severity levels from 0 through 18 can be specified by any user. Severity levels from 
      19 through 25 can only be specified by members of the sysadmin fixed server role or 
      users with ALTER TRACE permissions. For severity levels from 19 through 25, the WITH LOG 
      option is required. Severity levels less than 0 are interpreted as 0. Severity levels 
      greater than 25 are interpreted as 25.

      On Message ID:
      ==============

      msg_id
      ──────
      Is a user-defined error message number stored in the sys.messages catalog view 
      using sp_addmessage. Error numbers for user-defined error messages should be greater than 
      50000. When msg_id is not specified, RAISERROR raises an error message with an error 
      number of 50000.

      see also system table sys.messages

\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE AdventureWorks_0006
GO

IF EXISTS 
  (
    SELECT 
      * 
    FROM 
      sys.objects 
    WHERE 
          [object_id] = OBJECT_ID(N'logging.usp_EventMessage_Log') 
      AND [type] IN(N'P', N'PC')
  )
	DROP PROCEDURE 
    logging.usp_EventMessage_Log
GO

CREATE PROCEDURE 
  logging.usp_EventMessage_Log
    (
        @EventMessage   NVARCHAR(MAX)
      , @MsgID          INT           = 50000
      , @ErrSeverity    INT           = 0
      , @ErrState       INT           = 0
      , @ProcName       SYSNAME       = NULL
      , @Line           INT           = NULL
      , @Verbose        BIT           = 0
    )
AS
BEGIN

  SET NOCOUNT ON

  DECLARE 
      @DisplayMsg             NVARCHAR(MAX)   = CONVERT(VARCHAR(50), GETDATE(), 21) + ' ' 
    , @ScanProgressCharIndex  BIGINT          = 1
    , @RaiserrorMaxLen        INT             = 2047
    , @BufferScanChunkLen     INT             = 2047
    , @DisplayStrLen          BIGINT
    , @DisplayBuffer          NVARCHAR(2047)

  IF @Verbose = 1
    SET @DisplayMsg += '{' + ISNULL(LTRIM(STR(@MsgID)),'0') + ',' +  ISNULL(LTRIM(STR(@ErrSeverity)),'0') + ',' + ISNULL(LTRIM(STR(@ErrState)),'0') + '} '
        
  SET @DisplayMsg +=  REPLACE(@EventMessage,'%','%%') 

  IF @ProcName IS NOT NULL
    SET @DisplayMsg += ' SPROC: ' + @ProcName
 
  IF @Line IS NOT NULL
    SET @DisplayMsg += '[LN:' + LTRIM(STR(@Line)) + ']'

  INSERT
    logging.EventMessage
      (
          EventMessage
        , ErrSeverity
        , ErrState
        , ProcName
        , Line
      )
  VALUES
    (
        ISNULL(@EventMessage ,'<CORRUPTED>')
      , ISNULL(@ErrSeverity,0)
      , ISNULL(@ErrState,0)
      , ISNULL(@ProcName,'?')
      , ISNULL(@Line,-1)
    )

/*┌────────────────────────────────────────────────────────────────────┐*\.
  │ RAISERROR can only display 2044 characters; if our event message   │
  │ is longer than that, chunk through the message and throw out a     │
  │ RAISERROR /w NOWAIT for each chunk. In case the error severity is  │
  │ halting, make sure we override the actual severity with 0 until    │
  │ we have reached the very last message chunk.                       │
\*└────────────────────────────────────────────────────────────────────┘*/

  SET @DisplayStrLen = LEN(@DisplayMsg)
  IF @DisplayStrLen > @RaiserrorMaxLen
    BEGIN
      -- Loop till the whole message text has been processed
      WHILE @ScanProgressCharIndex < @DisplayStrLen
        BEGIN
         
          -- Bump the scan buffer: Scan the next chunk, Increment the progress index
          SET @DisplayBuffer = SUBSTRING(@DisplayMsg,@ScanProgressCharIndex,@BufferScanChunkLen)
          SET @ScanProgressCharIndex += @BufferScanChunkLen

          --Is this the last message chunk?
          IF @ScanProgressCharIndex >= @DisplayStrLen
            RAISERROR(@DisplayBuffer, @ErrSeverity, @ErrState) WITH NOWAIT
          ELSE
            RAISERROR(@DisplayBuffer, 0, 0) WITH NOWAIT
        END
    END
  ELSE  
    RAISERROR(@DisplayMsg, @ErrSeverity, @ErrState) WITH NOWAIT

END
GO

/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\.
  │ UNIT TESTING SCRIPTS:                                                                       │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤

      SELECT * FROM logging.EventMessage

      -- Try-Catch scenario from within a stored procedure
      IF EXISTS 
        (
          SELECT 
            * 
          FROM 
            sys.objects 
          WHERE 
                [object_id] = OBJECT_ID(N'logging.usp_testLogging') 
            AND [type] IN(N'P', N'PC')
        )
        DROP PROCEDURE 
          logging.usp_testLogging
      GO


      CREATE PROCEDURE 
        logging.usp_testLogging
      AS
      BEGIN

        SET NOCOUNT ON

        BEGIN TRY
          RAISERROR('dummy error try-catch',12,0)
        END TRY
        BEGIN CATCH

          DECLARE
              @EventMessage   NVARCHAR(MAX) = ERROR_MESSAGE()
            , @MsgID          INT           = ERROR_NUMBER()
            , @ErrSeverity    INT           = ERROR_SEVERITY()
            , @ErrState       INT           = ERROR_STATE()
            , @ProcName       SYSNAME       = ERROR_PROCEDURE()
            , @Line           INT           = ERROR_LINE()
            , @SchemaName     SYSNAME       = OBJECT_SCHEMA_NAME(@@PROCID)
            , @ObjectName     SYSNAME       = OBJECT_NAME(@@PROCID)
            , @RowsAffected   BIGINT        = NULL --@@ROWCOUNT 

          EXEC logging.usp_EventMessage_Log 
              @EventMessage   = @EventMessage
            , @MsgID          = @MsgID
            , @ErrSeverity    = @ErrSeverity
            , @ErrState       = @ErrState
            , @ProcName       = @ProcName
            , @Line           = @Line
            , @SchemaName     = @SchemaName
            , @ObjectName     = @ObjectName
            , @RowsAffected   = @RowsAffected

          --THROW

        END CATCH

      END
      GO


      EXEC logging.usp_testLogging

      SELECT * FROM logging.EventMessage

\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/




