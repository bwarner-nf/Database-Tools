/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: View DDL                                                                             │
  │   Analytics_WS.logging.vw_RunLogReview
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │


  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ───────────────────────────────────────────────────────────────┤
      2019.01.09 bwarner         Initial Draft

  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ UNIT TESTING SCRIPTS:                                                                       │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
      SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED



WHERE
  ComponentDesc LIKE '%TableLoader%'
ORDER BY
    Executed ASC

\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE Analytics_WS
GO

IF EXISTS (SELECT *
           FROM sys.objects
           WHERE object_id = OBJECT_ID(N'logging.vw_RunLogReview')
                 AND type IN (N'V'))
    DROP VIEW 
      logging.vw_RunLogReview
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW
  logging.vw_RunLogReview
AS 
WITH 
    RunLogHierarchy       
      (
          RunLogID
        , RunComponentID
        , Executed
        , Completed
        , ReturnCode
        , DidSucceed
        , IndentPad
        , Lineage
        , LayerLevel
        , DidComplete
        , Comments
      )  AS 
    (
      SELECT
          RunLogID        = rl.RunLogID
        , RunComponentID  = rl.RunComponentID
        , Executed        = rl.Executed
        , Completed       = rl.Completed
        , ReturnCode      = rl.ReturnCode
        , DidSucceed      = rl.DidSucceed
        , DidComplete     = rl.DidComplete
        , Comments        = rl.Comments
        , IndentPad       = CAST('' AS VARCHAR(128))
        , Lineage         = CAST(rc.RunComponentName AS VARCHAR(MAX))
        , LayerLevel      = 0
      FROM
        logging.RunLog rl
        JOIN
        logging.RunComponent rc
          ON rl.RunComponentID = rc.RunComponentID
      WHERE 
        rl.ParentRunLogID IS NULL

      UNION ALL 

      SELECT
          RunLogID        = kid.RunLogID
        , RunComponentID  = kid.RunComponentID
        , Executed        = kid.Executed
        , Completed       = kid.Completed
        , ReturnCode      = kid.ReturnCode
        , DidSucceed      = kid.DidSucceed
        , ReturnCode      = kid.ReturnCode
        , DidSucceed      = kid.DidSucceed
        , DidComplete     = kid.DidComplete
        , Comments        = kid.Comments
        , IndentPad       = CAST(pappy.IndentPad + '    ' AS VARCHAR(128)) 
        , Lineage         = CAST(pappy.Lineage + '\' + rc_kid.RunComponentName AS VARCHAR(MAX))
        , LayerLevel      = pappy.LayerLevel + 1
      FROM
        logging.RunLog kid
        JOIN
        logging.RunComponent rc_kid
          ON kid.RunComponentID = rc_kid.RunComponentID
        JOIN 
        RunLogHierarchy pappy
          ON kid.ParentRunLogID = pappy.RunLogID
    )

, FinalDisplayRunLog AS 
    (
      SELECT 
          ComponentLineage  = rlh.Lineage
        , ComponentDesc     = rlh.IndentPad + rc.RunComponentName
        , rlh.Executed
        , rlh.Completed
        , Durration         = CASE 
                                WHEN rlh.DidSucceed = 0 AND rlh.DidComplete = 0 AND rlh.Completed IS NULL 
                                  THEN 'Not captured' 
                                WHEN rlh.Completed IS NOT NULL 
                                  THEN logging.udf_DurrationStr(rlh.Executed,rlh.Completed) 
                                WHEN rlh.DidComplete = 0 AND rlh.Completed IS NOT NULL 
                                  THEN logging.udf_DurrationStr(rlh.Executed,GETDATE()) + '<Running>' 
                                ELSE 'UNCERTAIN'
                              END
        , rlh.DidSucceed
        , rlh.ReturnCode
        , rlh.DidSucceed
        , rlh.DidComplete
        , rlh.IndentPad
        , rlh.Comments
      FROM 
        RunLogHierarchy rlh
        JOIN
        logging.RunComponent rc
          ON rlh.RunComponentID = rc.RunComponentID 
    )
SELECT
    ComponentLineage
  , ComponentDesc
  , Executed
  , Durration
  , DidSucceed
  , DidComplete
  , Comments
FROM 
  FinalDisplayRunLog


GO

