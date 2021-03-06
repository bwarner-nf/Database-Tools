/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\.
  │ TITLE: Check Constraint DDL                                                                 │
  │   AdventureWorks_0006.config.EmployeeSizeSegment.CHK_config_EmployeeSizeSegment_Valid_EmployeeSizeSegment_Range
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
     Check that the valid date from does not intersect with another date range for this
     mailing org


     CheckRowValid_EmployeeSizeSegment_Range
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
          [object_id]       = OBJECT_ID(N'config.CHK_config_EmployeeSizeSegment_Valid_EmployeeSizeSegment_Range')
      AND parent_object_id  = OBJECT_ID(N'config.EmployeeSizeSegment')
  )
  ALTER TABLE 
    config.EmployeeSizeSegment 
  DROP CONSTRAINT 
    CHK_config_EmployeeSizeSegment_Valid_EmployeeSizeSegment_Range
GO

ALTER TABLE
  config.EmployeeSizeSegment
ADD CONSTRAINT 
  CHK_config_EmployeeSizeSegment_Valid_EmployeeSizeSegment_Range
CHECK 
  (
     config.udf_CheckRowValid_EmployeeSizeSegment_Range(  MailingOrgID
                                                        , MinEmpSize
                                                        , MaxEmpSize  
                                                        , EmployeeSizeSegmentID  ) = 1
  )





