/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\.
  │ TITLE: Check Constraint DDL                                                                 │
  │   AdventureWorks_0006.config.MailSegment.CHK_config_MailSegment_ValidDateRange_New
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
          [object_id]       = OBJECT_ID(N'config.CHK_config_MailSegment_ValidDateRange_New')
      AND parent_object_id  = OBJECT_ID(N'config.MailSegment')
  )
  ALTER TABLE 
    config.MailSegment 
  DROP CONSTRAINT 
    CHK_config_MailSegment_ValidDateRange_New
GO

ALTER TABLE
  config.MailSegment
ADD CONSTRAINT 
  CHK_config_MailSegment_ValidDateRange_New
CHECK 
  (
     config.udf_CheckRowValidDateRange_MailSegment(   ValidFrom
                                                    , MailingOrgID
                                                    , MailSegmentName ) = 1
  )







