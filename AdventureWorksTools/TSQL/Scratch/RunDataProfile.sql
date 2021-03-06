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

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
GO



    SELECT 
        TableName = 'InfoUsaMatched_Archive'
      , *
    FROM 
        dbo.vw_InfoUsaMatched_Archive_DataProfile
    ORDER BY 
      OrdinalPos ASC




    SELECT 
        TableName = 'InfoUsaUnmatched_Archive'
      , *
    FROM 
        dbo.vw_InfoUsaUnmatched_Archive_DataProfile
    ORDER BY 
      OrdinalPos ASC


    SELECT 
        TableName = 'InfoUsaTopThirty_Archive'
      , *
    FROM 
        dbo.vw_InfoUsaTopThirty_Archive_DataProfile
    ORDER BY 
      OrdinalPos ASC


    SELECT 
        TableName = 'LicensedDnbBusinesses_Archive'
      , *
    FROM 
        dbo.vw_LicensedDnbBusinesses_Archive_DataProfile
    ORDER BY 
      OrdinalPos ASC


    SELECT 
        TableName = 'OverallDnbBusinesses_Archive'
      , *
    FROM 
        dbo.vw_OverallDnbBusinesses_Archive_DataProfile



