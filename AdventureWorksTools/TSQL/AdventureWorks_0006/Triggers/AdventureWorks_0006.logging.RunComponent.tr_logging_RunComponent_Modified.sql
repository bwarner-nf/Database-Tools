/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\.
  │ TITLE: Index DDL AdventureWorks_0006.logging.RunComponent.tr_dbo_RunComponent_Modified
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
           WHERE object_id = OBJECT_ID(N'logging.tr_logging_RunComponent_Modified'))
  DROP TRIGGER 
    logging.tr_logging_RunComponent_Modified
GO

SET ANSI_PADDING ON
GO

CREATE TRIGGER 
  logging.tr_logging_RunComponent_Modified
ON 
  logging.RunComponent
 
FOR -- INSTEAD OF
  UPDATE -- INSERT DELETE
AS
  UPDATE
    logging.RunComponent 
  SET
      ModifiedDate  = GETDATE()
    , ModifiedBy    = SUSER_SNAME()
  WHERE
    RunComponentID IN (SELECT RunComponentID FROM INSERTED)



