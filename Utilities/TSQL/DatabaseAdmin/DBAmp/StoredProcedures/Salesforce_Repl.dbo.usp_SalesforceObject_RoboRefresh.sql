/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Stored Procedure DDL                                                                 │
  │   Salesforce_Repl.dbo.usp_SalesforceObject_RoboRefresh
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
      
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ────────────────────────────────────────────────────────────── │
      2019.01.16 bwarner         Initial Draft
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ UNIT TESTING SCRIPTS:                                                                       │

      EXEC dbo.usp_SalesforceObject_RoboRefresh @Param01 = 'Phu-Barr'

  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ RUN COMPONENT CONFIG TEMPLATES                                                              │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤

DECLARE 
    @RunComponentID_parent  SMALLINT 
  , @RunComponentID_child   SMALLINT 

EXEC logging.usp_RunComponent_Add
    @RunComponentName     = 'usp_SalesforceObject_RoboRefresh' 
  , @RunComponentDesc     = 'Robust Refresh process for DBAmp-Replicated Salesforce Objects; Defines an escalation path for adjusting methots and options'
  , @ParentRunComponentID = NULL
  , @SequentialPosition   = NULL
  , @RunComponentID       = @RunComponentID_parent OUTPUT

EXEC logging.usp_RunComponent_Add
    @RunComponentName     = 'SF_Refresh: STD' 
  , @RunComponentDesc     = 'Runs a standard SF_Refresh call'
  , @ParentRunComponentID = @RunComponentID_parent
  , @SequentialPosition   = 1
  , @RunComponentID       = @RunComponentID_child OUTPUT


EXEC logging.usp_RunComponent_Add
    @RunComponentName     = 'SF_Refresh: STD' 
  , @RunComponentDesc     = 'Runs a standard SF_Refresh call'
  , @ParentRunComponentID = @RunComponentID_parent
  , @SequentialPosition   = 1
  , @RunComponentID       = @RunComponentID_child OUTPUT



EXEC logging.usp_RunComponent_Add
    @RunComponentName     = '__A_CHILD_COMPOENENT___' 
  , @RunComponentDesc     = '__IT_DOES_THIS__'
  , @ParentRunComponentID = @RunComponentID_parent
  , @SequentialPosition   = 2
  , @RunComponentID       = @RunComponentID_child OUTPUT

EXEC logging.usp_RunComponent_Add
    @RunComponentName     = '__A_GRANDCHILD_COMPOENENT___' 
  , @RunComponentDesc     = '__IT_DOES_THIS__'
  , @ParentRunComponentID = @RunComponentID_child
  , @SequentialPosition   = NULL
  , @RunComponentID       = @RunComponentID_child2 OUTPUT

\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE Salesforce_Repl
GO

IF EXISTS 
  (
    SELECT 
      * 
    FROM 
      sys.objects 
    WHERE 
          [object_id] = OBJECT_ID(N'dbo.usp_SalesforceObject_RoboRefresh') 
      AND [type] IN(N'P', N'PC')
  )
	DROP PROCEDURE 
    dbo.usp_SalesforceObject_RoboRefresh
GO

CREATE PROCEDURE 
  dbo.usp_SalesforceObject_RoboRefresh
    (
        @LineageRunLogID  BIGINT  = NULL
      , @Verbose          BIT     = 0
    )
AS
BEGIN
  /*┌────────────────────────────────────────────────────────────────────┐*\.
    │ Variable Declarations & Logging Initialization                     │ 
  \*└────────────────────────────────────────────────────────────────────┘*/  
  DECLARE 
      @EventMessage         NVARCHAR(MAX)
    , @ProcName             SYSNAME       = OBJECT_NAME(@@PROCID)
    , @RunLogID_sproc       BIGINT
    , @RunLogID_step        BIGINT
    , @RowsAffected         BIGINT
    , @MsgID                INT 
    , @ErrSeverity          INT 
    , @ErrState             INT 
    , @Line                 INT

  EXEC logging.usp_RunLog_LogBegin 
      @RunComponentName = @ProcName
    , @ParentRunLogID   = @LineageRunLogID     
    , @RunLogID         = @RunLogID_sproc OUTPUT

  EXEC logging.usp_EventMessage_Log @EventMessage='__MSG_TXT__', @ProcName=@ProcName

  /*┌────────────────────────────────────────────────────────────────────┐*\.
    │ Master Try-Catch                                                   │ 
  \*└────────────────────────────────────────────────────────────────────┘*/  
  BEGIN TRY
    
    /*┌────────────────────────────────────────────────────────────────────┐*\.
      │ BEGIN: __RUN_COMPONENT_NAME__
    \*└────────────────────────────────────────────────────────────────────┘*/
    SET @RunLogID_step = NULL
    EXEC logging.usp_RunLog_LogBegin 
        @ParentRunLogID   = @RunLogID_sproc
      , @RunComponentName = '__RUN_COMPONENT_NAME__'
      , @RunLogID         = @RunLogID_step OUTPUT

    EXEC logging.usp_RunAttribute_Set 
        @RunLogID       = RunLogID_step
      , @AttributeName  = '__RUN_ATTRIB___'
      , @AttributeValue = '__RUN_ATTRIB_VALUE__' 

    SET @RowsAffected = @@ROWCOUNT
    EXEC logging.usp_RowsAffected_Log 
        @RunLogID       = @RunLogID_step
      , @OperationType  = 'insert'
      , @RowsAffected   = @RowsAffected
      , @ObjectName     = 'Lead_Staging_Update'
      
    EXEC logging.usp_RunLog_LogEnd 
        @RunLogID   =  @RunLogID_step
      , @ReturnCode = NULL
      , @DidSucceed = 1

  END TRY
  BEGIN CATCH
    SELECT
        @EventMessage   = ERROR_MESSAGE()
      , @MsgID          = ERROR_NUMBER()
      , @ErrSeverity    = ERROR_SEVERITY()
      , @ErrState       = ERROR_STATE()
      , @ProcName       = ERROR_PROCEDURE()
      , @Line           = ERROR_LINE()

    EXEC logging.usp_EventMessage_Log 
        @EventMessage   = @EventMessage
      , @MsgID          = @MsgID
      , @ErrSeverity    = @ErrSeverity
      , @ErrState       = @ErrState
      , @ProcName       = @ProcName
      , @Line           = @Line

    IF @RunLogID_step IS NOT NULL
      EXEC logging.usp_RunLog_LogEnd 
          @RunLogID   = @RunLogID_step
        , @ReturnCode = -1
        , @DidSucceed = 0

    EXEC logging.usp_RunLog_LogEnd 
        @RunLogID   = @RunLogID_sproc
      , @ReturnCode = -1
      , @DidSucceed = 0

    IF @Verbose = 1
      EXEC logging.usp_GetLogsForRun @RunLogID_sproc
  END CATCH 

  /*┌───────────────────────────────────────────┐*\.
    │  Log Precedure Completion                 │
  \*└───────────────────────────────────────────┘*/
  EXEC logging.usp_RunLog_LogEnd 
      @RunLogID   = @RunLogID_sproc
    , @ReturnCode = NULL
    , @DidSucceed = 1

  IF @Verbose = 1
    EXEC logging.usp_GetLogsForRun @RunLogID_sproc    
END
GO


/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\.
  │                                                                                             │
\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/

/*┌────────────────────────────────────────────────────────────────────┐*\.
  │                                                                    │
\*└────────────────────────────────────────────────────────────────────┘*/

/*┌───────────────────────────────────────────┐*\.
  │                                           │
\*└───────────────────────────────────────────┘*/
