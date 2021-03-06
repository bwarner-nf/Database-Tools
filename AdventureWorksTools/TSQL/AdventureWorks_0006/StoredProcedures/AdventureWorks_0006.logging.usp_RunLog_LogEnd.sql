/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Stored Procedure DDL                                                                 │
  │   AdventureWorks_0006.logging.usp_RunLog_LogEnd
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
      
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ────────────────────────────────────────────────────────────── │
      2018.12.17 bwarner         Initial Draft
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ UNIT TESTING SCRIPTS:                                                                       │

      DECLARE 
          @RunLogID BIGINT

      EXEC logging.usp_RunLog_LogBegin 
          @ParentRunLogID   = NULL
        , @RunComponentName = '__RUN_COMPONENT_NAME__'
        , @RunLogID         = @RunLogID OUTPUT

        -- DO STUFF

      EXEC logging.usp_RunLog_LogEnd 
          @RunLogID   =  @RunLogID
        , @ReturnCode = NULL
        , @DidSucceed   = 1

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
          [object_id] = OBJECT_ID(N'logging.usp_RunLog_LogEnd') 
      AND [type] IN(N'P', N'PC')
  )
	DROP PROCEDURE 
    logging.usp_RunLog_LogEnd
GO

CREATE PROCEDURE 
  logging.usp_RunLog_LogEnd
    (
        @RunLogID     BIGINT
      , @ReturnCode   INT           = NULL
      , @DidSucceed   BIT           = NULL
      , @DidComplete  BIT           = 1
      , @Comments     VARCHAR(512)  = NULL
    )
AS
BEGIN

  DECLARE
      @ThisProcName     SYSNAME       = OBJECT_NAME(@@PROCID)
    , @Msg              VARCHAR(MAX)
    , @Executed         DATETIME2
    , @Completed        DATETIME2
    , @RunComponentName SYSNAME
    , @RunComponentID   SMALLINT

  DECLARE
    @UpdateOutputCatcher TABLE
      (
          Executed        DATETIME2
        , Completed       DATETIME2
        , RunComponentID  SMALLINT
      )

  IF NOT EXISTS(SELECT 1 FROM logging.RunLog WHERE RunLogID = @RunLogID) 
    BEGIN
      SET @Msg = N'Invalid RunLogID. Could not find RunLogID : ' + LTRIM(STR(@RunLogID)) + N' in logging.RunLog.'
      EXEC logging.usp_EventMessage_Log
          @ProcName     = @ThisProcName
        , @EventMessage = @Msg
        , @ErrSeverity  = 11
    END

  UPDATE
    logging.RunLog
  SET
      Completed   = GETDATE()
    , ReturnCode  = @ReturnCode
    , DidSucceed  = @DidSucceed
    , DidComplete = @DidComplete
    , [Comments]  = @Comments 
  OUTPUT
      DELETED.Executed
    , INSERTED.Completed
    , DELETED.RunComponentID
  INTO
    @UpdateOutputCatcher
  WHERE
    RunLogID = @RunLogID

  SELECT TOP (1)
      @Executed         = uc.Executed
    , @Completed        = uc.Completed
    , @RunComponentName = rc.RunComponentName 
  FROM
    @UpdateOutputCatcher uc
    JOIN
    logging.RunComponent rc
      ON uc.RunComponentID = rc.RunComponentID

  SET @Msg  = '"' + @RunComponentName + '" Completed ' 
            + CASE WHEN @DidSucceed = 1 THEN '[SUCCEEDED]' ELSE '[FAILED]' END
            + ISNULL('('+LTRIM(STR(@ReturnCode))+')','')
            + '; Durration: ' + ISNULL(logging.udf_DurrationStr(@Executed,@Completed),'<Unresolved>')
            + '; RunLogID: ' + LTRIM(STR(@RunLogID))

  EXEC logging.usp_EventMessage_Log
      @ProcName = @ThisProcName
    , @EventMessage = @Msg
END
GO





