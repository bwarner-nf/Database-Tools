/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\.
  │ TITLE: Check Constraint DDL                                                                 │
  │   AdventureWorks_0006.dbo.DataFeed.CHK_dbo_DataFeed_ValidDateRange_New
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
     Check that the valid date from does not intersect with another date range for this
     mailing org
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ────────────────────────────────────────────────────────────── │
      2018.12.21 bwarner         Initial Draft
\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/

USE
AdventureWorks_0006
GO

IF EXISTS 
  (
    SELECT 1
    FROM sys.check_constraints 
    WHERE 
          [object_id]       = OBJECT_ID(N'dbo.CHK_dbo_DataFeed_ValidDateRange_New')
      AND parent_object_id  = OBJECT_ID(N'dbo.DataFeed')
  )
  ALTER TABLE 
    dbo.DataFeed 
  DROP CONSTRAINT 
    CHK_dbo_DataFeed_ValidDateRange_New
GO

ALTER TABLE
  dbo.DataFeed
ADD CONSTRAINT 
  CHK_dbo_DataFeed_ValidDateRange_New
CHECK 
  (
     dbo.udf_CheckRowValidDateRange_DataFeed(    ValidFrom
                                               , MailingOrgID
                                               , DataFeedName  ) = 1
  )





