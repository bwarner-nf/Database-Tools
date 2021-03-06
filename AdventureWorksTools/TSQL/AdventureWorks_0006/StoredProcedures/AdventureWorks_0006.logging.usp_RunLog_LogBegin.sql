/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Stored Procedure DDL                                                                 │
  │   AdventureWorks_0006.logging.usp_RunLog_LogBegin
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
          [object_id] = OBJECT_ID(N'logging.usp_RunLog_LogBegin') 
      AND [type] IN(N'P', N'PC')
  )
	DROP PROCEDURE 
    logging.usp_RunLog_LogBegin
GO

CREATE PROCEDURE 
  logging.usp_RunLog_LogBegin
    (
        @ParentRunLogID   BIGINT = NULL
      , @RunComponentName SYSNAME 
      , @RunLogID         BIGINT OUTPUT
    )
AS
BEGIN
 
  DECLARE
      @RunComponentID SMALLINT
    , @ThisProcName   SYSNAME       = OBJECT_NAME(@@PROCID)
    , @Msg            NVARCHAR(MAX)

  SELECT
    @RunComponentID = RunComponentID
  FROM
    logging.RunComponent
  WHERE
    RunComponentName = @RunComponentName

  IF @RunComponentID IS NULL
    BEGIN
      SET @Msg = N'Could not find run component: ' + ISNULL(@RunComponentName,'NULL') + N'; Correct the component name or create a new record in logging.RunComponent to support logging against this component'
      EXEC logging.usp_EventMessage_Log
          @ProcName = @ThisProcName
        , @EventMessage = @Msg
        , @ErrSeverity = 11 
    END

  IF @ParentRunLogID IS NOT NULL AND NOT EXISTS( SELECT 1 FROM logging.RunLog WHERE RunLogID = @ParentRunLogID) 
    BEGIN
      SET @Msg = N'Invalid ParentRunLogID. Could not find parent RunLogID : ' + LTRIM(STR(@ParentRunLogID)) + N' in logging.RunLog.'
      EXEC logging.usp_EventMessage_Log
          @ProcName = @ThisProcName
        , @EventMessage = @Msg
        , @ErrSeverity = 11
    END

  INSERT
    logging.RunLog
      (
          ParentRunLogID
        , RunComponentID
      )
    VALUES
      (
          @ParentRunLogID
        , @RunComponentID
      )
    
  SET @RunLogID = SCOPE_IDENTITY()
  SET @Msg = '

┌─────────────────────────────────────────────────────────────────────────────────────────────┐
│ COMPONENT STARTED =>=>=> '+@RunComponentName

  IF @ParentRunLogID IS NOT NULL
    SET @Msg += '
├─────────────────────────────────────────────────────────────────────────────────────────────┤
│ CALLED BY: '+ ( SELECT rc.RunComponentName 
                  FROM logging.RunLog rl JOIN logging.RunComponent rc 
                    ON rl.RunComponentID = rc.RunComponentID 
                    AND rl.RunLogID = @RunLogID)


  SET @Msg += '
└─────────────────────────────────────────────────────────────────────────────────────────────┘

'


  EXEC logging.usp_EventMessage_Log @EventMessage=@Msg,@ProcName=@ThisProcName

END
GO





