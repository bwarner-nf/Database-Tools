/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Stored Procedure DDL                                                                 │
  │   AdventureWorks_0006.logging.usp_RowsAffected_Log
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
      
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ────────────────────────────────────────────────────────────── │
      2018.12.18 bwarner         Initial Draft
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ UNIT TESTING SCRIPTS:                                                                       │

      BEGIN TRANSACTION

        DECLARE @RunLogID BIGINT
        SELECT @RunLogID = MIN(RunLogID) FROM logging.RunLog

        EXEC logging.usp_RowsAffected_Log 
            @RunLogID       = @RunLogID
          , @OperationType  = 'insert'
          , @RowsAffected   = 159753
          , @SchemaName     = 'logging'
          , @ObjectName     = 'RowsAffected'

        SELECT TOP 10 * FROM logging.RowsAffected ORDER BY RowsAffectedID DESC

      ROLLBACK TRANSACTION



ALTER TABLE logging.RowsAffected
ADD
      Executed DATETIME2 NULL
    , Comment NVARCHAR(512) NULL


    NVARCHAR(512) NULL
  └─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE AdventureWorks_0006
GO

IF EXISTS 
  (
    SELECT 
      * 
    FROM 
      sys.objects 
    WHERE 
          [object_id] = OBJECT_ID(N'logging.usp_RowsAffected_Log') 
      AND [type] IN(N'P', N'PC')
  )
	DROP PROCEDURE 
    logging.usp_RowsAffected_Log
GO

CREATE PROCEDURE 
  logging.usp_RowsAffected_Log
    (
        @RunLogID       BIGINT
      , @OperationType  VARCHAR(128)
      , @RowsAffected   BIGINT
      , @ServerInstance NVARCHAR(16)  = NULL
      , @DatabaseName   SYSNAME       = NULL
      , @SchemaName     SYSNAME       = 'dbo'
      , @ObjectName     SYSNAME
      , @Comment        NVARCHAR(512) = NULL
      , @NoMsgLog       BIT           = 0
      , @IsTotal        BIT           = 0
    )
AS
BEGIN
  DECLARE
      @OperationTypeID  SMALLINT
    , @ThisProcName     SYSNAME       = OBJECT_NAME(@@PROCID)
    , @Msg              VARCHAR(MAX)
    , @ObjStr           NVARCHAR(256) 
    , @RunComponentName SYSNAME

  SET NOCOUNT ON

  SELECT
      @SchemaName     = REPLACE(REPLACE(@SchemaName,'[',''),']','')
    , @ObjectName     = REPLACE(REPLACE(@ObjectName,'[',''),']','')
    , @DatabaseName   = REPLACE(REPLACE(@DatabaseName,'[',''),']','')
    , @ServerInstance = REPLACE(REPLACE(@ServerInstance,'[',''),']','')

  IF @DatabaseName IS NULL
    SET @DatabaseName = DB_NAME()

  IF @ServerInstance IS NULL
    SET @DatabaseName = @@SERVERNAME

  /*┌────────────────────────────────────────────────────────────────────┐*.
      Validate that the object specified by @SchemaName

  SET @ObjStr = '[' + @SchemaName + '].[' + @ObjectName + ']'

  IF NOT EXISTS(SELECT 1 FROM sys.objects WHERE [object_id] = OBJECT_ID(@ObjStr))
    BEGIN
      SET @Msg = N'Invalid object. Could not find object: ' + ISNULL(@ObjStr,'NULL') + N'. You can only log rows affected against a valid database object'
      EXEC logging.usp_EventMessage_Log
          @ProcName     = @ThisProcName
        , @EventMessage = @Msg
        , @ErrSeverity  = 11
      RETURN -1
    END
    └────────────────────────────────────────────────────────────────────┘*/

  SELECT
    @OperationTypeID = OperationTypeID
  FROM
    logging.OperationType
  WHERE
    OperationType = @OperationType

  IF @OperationTypeID IS NULL
    BEGIN
      SET @Msg = N'Could not find operation type: ' + ISNULL(@OperationType,'NULL') + N'; Correct the operation type or create a new record in logging.OperationType to support logging against this operation'
      EXEC logging.usp_EventMessage_Log
          @ProcName     = @ThisProcName
        , @EventMessage = @Msg
        , @ErrSeverity  = 11
      RETURN -1
    END

  IF NOT EXISTS(SELECT 1 FROM logging.RunLog WHERE RunLogID = @RunLogID) 
    BEGIN
      SET @Msg = N'Invalid RunLogID. Could not find RunLogID : ' + LTRIM(STR(@RunLogID)) + N' in logging.RunLog.'
      EXEC logging.usp_EventMessage_Log
          @ProcName     = @ThisProcName
        , @EventMessage = @Msg
        , @ErrSeverity  = 11
      RETURN -1
    END

  INSERT
    logging.RowsAffected
      (
          RunLogID
        , ServerInstance
        , DatabaseName
        , SchemaName
        , ObjectName
        , OperationTypeID
        , RowsAffected
        , IsTotal
        , Comment
      )
    VALUES
      (
          @RunLogID
        , @ServerInstance
        , @DatabaseName
        , @SchemaName
        , @ObjectName
        , @OperationTypeID
        , @RowsAffected
        , @IsTotal
        , @Comment
      )
    
  IF @NoMsgLog = 0
    BEGIN
      SELECT 
        @RunComponentName = rc.RunComponentName
      FROM 
        logging.RunLog rl
        JOIN
        logging.RunComponent rc
          ON rl.RunComponentID = rc.RunComponentID
          AND rl.RunLogID = @RunLogID

      SET @Msg  = '"' + @RunComponentName  
                + '" ' + @OperationType + 'ed ' + REPLACE(CONVERT(VARCHAR, CAST(@RowsAffected AS MONEY), 1),'.00','')
                + ' rows => ' 
                + ISNULL(@ServerInstance + '.','') + ISNULL(@DatabaseName + '.','') + ISNULL(@SchemaName + '.','') + ISNULL(@ObjectName + '.','')

      IF @IsTotal = 1
        SET @Msg += ' (TOTAL)'

      EXEC logging.usp_EventMessage_Log @EventMessage = @Msg
    END

END


GO





