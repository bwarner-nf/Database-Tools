/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\.
  │ TITLE: Check Constraint DDL                                                                 │
  │   AdventureWorks_0006.config.ListSegmentationThreshold.CHK_config_ListSegmentationThreshold_ValidDateRange_New
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

USE AdventureWorks_0006
GO

IF EXISTS 
  (
    SELECT 1
    FROM sys.check_constraints 
    WHERE 
          [object_id]       = OBJECT_ID(N'config.CHK_config_ListSegmentationThreshold_ValidDateRange_New')
      AND parent_object_id  = OBJECT_ID(N'config.ListSegmentationThreshold')
  )
  ALTER TABLE 
    config.ListSegmentationThreshold 
  DROP CONSTRAINT 
    CHK_config_ListSegmentationThreshold_ValidDateRange_New
GO

ALTER TABLE
  config.ListSegmentationThreshold
ADD CONSTRAINT 
  CHK_config_ListSegmentationThreshold_ValidDateRange_New
CHECK 
  (
     config.udf_CheckRowValidDateRange_ListSegmentationThreshold(   ValidFrom
                                                                  , MailingOrgID
                                                                  , SIC_Division
                                                                  , IsPrevLicensed  ) = 1
  )






