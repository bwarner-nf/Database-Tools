/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Stored Procedure DDL                                                                 │
  │   DirectMail.logging.usp_RunComponent_Add
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
      Adds a run component to be logged against in the RunLog table; validates for duplicates
      and non-existant parnet
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ────────────────────────────────────────────────────────────── │
      2018.12.17 bwarner         Initial Draft
\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE DirectMail
GO

IF EXISTS 
  (
    SELECT 
      * 
    FROM 
      sys.objects 
    WHERE 
          [object_id] = OBJECT_ID(N'logging.usp_RunComponent_Add') 
      AND [type] IN(N'P', N'PC')
  )
	DROP PROCEDURE 
    logging.usp_RunComponent_Add
GO

CREATE PROCEDURE 
  logging.usp_RunComponent_Add
    (
        @RunComponentName     SYSNAME 
      , @RunComponentDesc     VARCHAR(512)  = NULL
      , @ParentRunComponentID SMALLINT      = NULL
      , @SequentialPosition   TINYINT       = NULL
      , @RunComponentID       SMALLINT      OUTPUT
    )
AS
BEGIN

  DECLARE
      @ThisProcName   SYSNAME       = OBJECT_NAME(@@PROCID)
    , @Msg            VARCHAR(MAX)

  IF @RunComponentName IS NULL OR LEN(@RunComponentName) < 3
    BEGIN
      SET @Msg = N'Invalid run component name: "' + ISNULL(@RunComponentName,'NULL') + N'". component name must be non-null and at least 3 characters long'
      EXEC logging.usp_EventMessage_Log
          @ProcName = @ThisProcName
        , @EventMessage = @Msg
        , @ErrSeverity = 16
    END

  SELECT
    @RunComponentID = RunComponentID
  FROM
    logging.RunComponent
  WHERE
    RunComponentName = @RunComponentName

  IF EXISTS(SELECT 1 FROM logging.RunComponent WHERE RunComponentName = @RunComponentName)
    BEGIN
      SET @Msg = N'Run components must be unique: The run component "' + @RunComponentName + N'" already exists'
      EXEC logging.usp_EventMessage_Log
          @ProcName = @ThisProcName
        , @EventMessage = @Msg
        , @ErrSeverity = 16
      RETURN
    END

  IF @ParentRunComponentID IS NOT NULL AND NOT EXISTS( SELECT 1 FROM logging.RunComponent WHERE RunComponentID = @ParentRunComponentID) 
    BEGIN
      SET @Msg = N'Invalid Parent RunComponentID. Could not find parent RunComponentID : ' + LTRIM(STR(@ParentRunComponentID)) + N' in logging.RunComponent.'
      EXEC logging.usp_EventMessage_Log
          @ProcName = @ThisProcName
        , @EventMessage = @Msg
        , @ErrSeverity = 11
      RETURN
    END

  INSERT
    logging.RunComponent
      (
          RunComponentName
        , RunComponentDesc
        , SequentialPosition
        , ParentRunComponentID
      )
    VALUES
      (
          @RunComponentName
        , @RunComponentDesc
        , @SequentialPosition
        , @ParentRunComponentID
      )

  SET @RunComponentID = SCOPE_IDENTITY()

END
GO


/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ UNIT TESTING SCRIPTS:                                                                       │

    -- Test One
    BEGIN TRANSACTION
    DECLARE @RunComponentID SMALLINT 

    EXEC logging.usp_RunComponent_Add
        @RunComponentName     = 'Dum Test' 
      , @RunComponentDesc     VARCHAR(512)  = NULL
      , @ParentRunComponentID SMALLINT      = NULL
      , @SequentialPosition   TINYINT       = NULL
      , @RunComponentID       SMALLINT      OUTPUT

    ROLLBACK TRANSACTION


    -- Test Parent-Child
    BEGIN TRANSACTION

    SELECT * FROM logging.RunComponent

    DECLARE 
        @RunComponentID_parent  SMALLINT 
      , @RunComponentID_child   SMALLINT

    EXEC logging.usp_RunComponent_Add
        @RunComponentName     = 'Dummy Parnet' 
      , @RunComponentDesc     = 'testing usp_RunComponent_Add'
      , @ParentRunComponentID = NULL
      , @SequentialPosition   = NULL
      , @RunComponentID       = @RunComponentID_parent OUTPUT

    EXEC logging.usp_RunComponent_Add
        @RunComponentName     = 'Dummy Child 1' 
      , @RunComponentDesc     = 'testing usp_RunComponent_Add'
      , @ParentRunComponentID = @RunComponentID_parent
      , @SequentialPosition   = 1
      , @RunComponentID       = @RunComponentID_child OUTPUT



    EXEC logging.usp_RunComponent_Add
        @RunComponentName     = 'Dummy Child 2' 
      , @RunComponentDesc     = 'testing usp_RunComponent_Add'
      , @ParentRunComponentID = @RunComponentID_parent
      , @SequentialPosition   = 2
      , @RunComponentID       = @RunComponentID_child OUTPUT

    SELECT * FROM logging.RunComponent

    ROLLBACK TRANSACTION


    -- Test Duplicate Child
    BEGIN TRANSACTION

    SELECT * FROM logging.RunComponent

    DECLARE 
        @RunComponentID_parent  SMALLINT 
      , @RunComponentID_child   SMALLINT

    EXEC logging.usp_RunComponent_Add
        @RunComponentName     = 'Dummy Parnet' 
      , @RunComponentDesc     = 'testing usp_RunComponent_Add'
      , @ParentRunComponentID = NULL
      , @SequentialPosition   = NULL
      , @RunComponentID       = @RunComponentID_parent OUTPUT

    EXEC logging.usp_RunComponent_Add
        @RunComponentName     = 'Dummy Child 1' 
      , @RunComponentDesc     = 'testing usp_RunComponent_Add'
      , @ParentRunComponentID = @RunComponentID_parent
      , @SequentialPosition   = 1
      , @RunComponentID       = @RunComponentID_child OUTPUT



    EXEC logging.usp_RunComponent_Add
        @RunComponentName     = 'Dummy Child 1' 
      , @RunComponentDesc     = 'testing usp_RunComponent_Add'
      , @ParentRunComponentID = @RunComponentID_parent
      , @SequentialPosition   = 2
      , @RunComponentID       = @RunComponentID_child OUTPUT

    SELECT * FROM logging.RunComponent

    ROLLBACK TRANSACTION

\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/