/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\.
  │ TITLE: Index DDL AdventureWorks_0006.dbo.DataProvider.tr_dbo_DataProvider_Modified
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
      
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ────────────────────────────────────────────────────────────── │
      2018.12.18 bwarner         Initial Draft
\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE AdventureWorks_0006
GO

IF EXISTS (SELECT 1
           FROM sys.triggers
           WHERE object_id = OBJECT_ID(N'dbo.tr_dbo_DataProvider_Modified'))
  DROP TRIGGER 
    dbo.tr_dbo_DataProvider_Modified
GO

SET ANSI_PADDING ON
GO

CREATE TRIGGER 
  dbo.tr_dbo_DataProvider_Modified
ON 
  dbo.DataProvider
 
FOR
  UPDATE
AS
  UPDATE
    dbo.DataProvider 
  SET
      ModifiedDate  = GETDATE()
    , ModifiedBy    = SUSER_SNAME()
  WHERE
    DataProviderID IN (SELECT DataProviderID FROM INSERTED)



