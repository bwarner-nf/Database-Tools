-- SQL Server Syntax  
-- Trigger on an INSERT, UPDATE, or DELETE statement to a table or view (DML Trigger)  

/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\.
  │ TITLE: Index DDL AdventureWorks_0006.dbo.DataFeed.tr_dbo_DataFeed_Modified
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
           WHERE [name] = OBJECT_ID(N'dbo.tr_dbo_DataFeed_Modified'))
  DROP TRIGGER 
    dbo.tr_dbo_DataFeed_Modified
GO





SET ANSI_PADDING ON
GO

IF  NOT EXISTS (SELECT 1
                FROM sys.triggers
                WHERE [name] = OBJECT_ID(N'dbo.tr_dbo_DataFeed_Modified'))
    AND EXISTS (SELECT 1
                FROM sys.tables -- change to views if view trigger
                WHERE [object_id] = OBJECT_ID(N'dbo.DataFeed') )
  CREATE TRIGGER 
    dbo.tr_dbo_DataFeed_Modified
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
      __TABLE_PK_COL__ IN (SELECT __TABLE_PK_COL__ FROM INSERTED)





