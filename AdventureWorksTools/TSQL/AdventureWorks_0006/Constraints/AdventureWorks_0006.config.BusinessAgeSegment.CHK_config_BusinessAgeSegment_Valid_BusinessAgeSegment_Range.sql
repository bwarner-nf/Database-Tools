/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\.
  │ TITLE: Check Constraint DDL                                                                 │
  │   AdventureWorks_0006.config.BusinessAgeSegment.CHK_config_BusinessAgeSegment_Valid_BusinessAgeSegment_Range
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
     Check that the valid date from does not intersect with another date range for this
     mailing org


     CheckRowValid_BusinessAgeSegment_Range
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
          [object_id]       = OBJECT_ID(N'config.CHK_config_BusinessAgeSegment_Valid_BusinessAgeSegment_Range')
      AND parent_object_id  = OBJECT_ID(N'config.BusinessAgeSegment')
  )
  ALTER TABLE 
    config.BusinessAgeSegment 
  DROP CONSTRAINT 
    CHK_config_BusinessAgeSegment_Valid_BusinessAgeSegment_Range
GO

ALTER TABLE
  config.BusinessAgeSegment
ADD CONSTRAINT 
  CHK_config_BusinessAgeSegment_Valid_BusinessAgeSegment_Range
CHECK 
  (
     config.udf_CheckRowValid_BusinessAgeSegment_Range(   MailingOrgID
                                                        , MinAge
                                                        , MaxAge
                                                        , BusinessAgeSegmentID  ) = 1
  )




