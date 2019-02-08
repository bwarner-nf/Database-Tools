-- SQL Server Syntax  
-- Trigger on an INSERT, UPDATE, or DELETE statement to a table or view (DML Trigger)  

/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\.
  │ TITLE: Index DDL AdventureWorks_0006.dbo.DataFeed.tr_DataFeed_Modified
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
           WHERE object_id = OBJECT_ID(N'dbo.tr_DataFeed_Modified'))
  DROP TRIGGER 
    dbo.tr_DataFeed_Modified
GO

SET ANSI_PADDING ON
GO

CREATE TRIGGER 
  dbo.tr_DataFeed_Modified
ON 
  dbo.DataFeed
 
FOR -- INSTEAD OF
  UPDATE -- INSERT DELETE
AS

UPDATE
  dbo.DataFeed 
SET
    ModifiedDate  = GETDATE()
  , ModifiedBy    = SUSER_SNAME()
WHERE
  DataFeedID IN (SELECT DataFeedID FROM INSERTED)



