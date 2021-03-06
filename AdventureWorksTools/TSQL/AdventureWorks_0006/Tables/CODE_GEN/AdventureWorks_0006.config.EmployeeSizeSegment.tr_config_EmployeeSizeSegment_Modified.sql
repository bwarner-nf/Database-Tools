
/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\.
  │ TITLE: Index DDL AdventureWorks_0006.config.EmployeeSizeSegment.tr_config_EmployeeSizeSegment_Modified
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
      
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ────────────────────────────────────────────────────────────── │
      2019.01.02 bwarner         Initial Draft
\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE AdventureWorks_0006
GO

IF EXISTS (SELECT 1
           FROM sys.triggers
           WHERE object_id = OBJECT_ID(N'dbo.tr_config_EmployeeSizeSegment_Modified'))
  DROP TRIGGER 
    dbo.tr_config_EmployeeSizeSegment_Modified
GO

SET ANSI_PADDING ON
GO

CREATE TRIGGER 
  dbo.tr_config_EmployeeSizeSegment_Modified
ON 
  config.EmployeeSizeSegment
 
FOR -- INSTEAD OF
  UPDATE -- INSERT DELETE
AS

UPDATE
  config.EmployeeSizeSegment 
SET
    ModifiedDate  = GETDATE()
  , ModifiedBy    = SUSER_SNAME()
WHERE
  EmployeeSizeSegmentID IN (SELECT EmployeeSizeSegmentID FROM INSERTED)





