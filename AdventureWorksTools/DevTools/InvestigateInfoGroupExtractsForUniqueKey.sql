/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE:                                                                                      │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │

  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ────────────────────────────────────────────────────────────── │
      YYYY.MM.DD _AUTHOR_        Initial Draft
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ UNIT TESTING SCRIPTS:                                                                       │

\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/

SELECT
    RecordCnt = COUNT(*)
  , DistinctOrigFilingID = COUNT(DISTINCT [ORIGINAL FILING ID])
  , DistinctSrcFilingID = COUNT(DISTINCT [SOURCE FILING ID])

FROM    
  imp.MenuUniverseExtract_T0_IFG_Unmatched
WHERE
  [ORIGINAL FILING ID] IS NOT NULL

DELETE 
  imp.MenuUniverseExtract_T0_IFG_Unmatched
WHERE
  [ORIGINAL FILING ID] IS NULL



SELECT * 
FROM imp.MenuUniverseExtract_T1_IFG_Matched
WHERE [ORIGINAL FILING ID] IS NULL OR [SOURCE FILING ID] IS NULL



SELECT
    RecordCnt = COUNT(*)
  , DistinctOrigFilingID = COUNT(DISTINCT [ORIGINAL FILING ID])
  , DistinctSrcFilingID = COUNT(DISTINCT [SOURCE FILING ID])

FROM    
  imp.MenuUniverseExtract_T1_IFG_Matched





;WITH
    dupe_srcFileID as 
      (
        SELECT
            [SOURCE FILING ID]
          , RcrdCnt = COUNT(*)
        FROM    
          imp.MenuUniverseExtract_T1_IFG_Matched
        GROUP BY
          [SOURCE FILING ID]
        HAVING
          COUNT(*) > 1
      )
SELECT
    um.*
  , dupe.RcrdCnt
FROM    
  imp.MenuUniverseExtract_T1_IFG_Matched um
  JOIN
  dupe_srcFileID dupe
    ON um.[SOURCE FILING ID] = dupe.[SOURCE FILING ID]
ORDER BY
  [SOURCE FILING ID]



;WITH
    dupe_srcFileID as 
      (
        SELECT
            [ORIGINAL FILING ID]
          , RcrdCnt = COUNT(*)
        FROM    
          imp.MenuUniverseExtract_T1_IFG_Matched
        GROUP BY
          [ORIGINAL FILING ID]
        HAVING
          COUNT(*) > 1
      )
SELECT
    um.*
  , dupe.RcrdCnt
FROM    
  imp.MenuUniverseExtract_T1_IFG_Matched um
  JOIN
  dupe_srcFileID dupe
    ON um.[ORIGINAL FILING ID] = dupe.[ORIGINAL FILING ID]
ORDER BY
  [ORIGINAL FILING ID]


  


;WITH
    dupe_srcFileID as 
      (
        SELECT
            [SOURCE FILING ID]
          , RcrdCnt = COUNT(*)
        FROM    
          imp.MenuUniverseExtract_T0_IFG_Unmatched
        GROUP BY
          [SOURCE FILING ID]
        HAVING
          COUNT(*) > 1
      )
SELECT
    um.*
  , dupe.RcrdCnt
FROM    
  imp.MenuUniverseExtract_T0_IFG_Unmatched um
  JOIN
  dupe_srcFileID dupe
    ON um.[SOURCE FILING ID] = dupe.[SOURCE FILING ID]
ORDER BY
  [SOURCE FILING ID]



;WITH
    dupe_srcFileID as 
      (
        SELECT
            [ORIGINAL FILING ID]
          , RcrdCnt = COUNT(*)
        FROM    
          imp.MenuUniverseExtract_T1_IFG_Matched
        GROUP BY
          [ORIGINAL FILING ID]
        HAVING
          COUNT(*) > 1
      )
SELECT
    um.*
  , dupe.RcrdCnt
FROM    
  imp.MenuUniverseExtract_T0_IFG_Unmatched um
  JOIN
  dupe_srcFileID dupe
    ON um.[ORIGINAL FILING ID] = dupe.[ORIGINAL FILING ID]
ORDER BY
  [ORIGINAL FILING ID]








SELECT
    RecordCnt = COUNT(*)
  , DistinctOrigFilingID = COUNT(DISTINCT [ORIGINAL FILING ID])
  , DistinctSrcFilingID = COUNT(DISTINCT [SOURCE FILING ID])

FROM    
  imp.MenuUniverseExtract_T1_IFG_Matched





MenuUniverseExtract_T1_IFG_Matched





