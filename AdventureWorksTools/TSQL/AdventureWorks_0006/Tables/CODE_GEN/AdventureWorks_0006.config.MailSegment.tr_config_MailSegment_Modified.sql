
/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\.
  │ TITLE: Index DDL AdventureWorks_0006.config.MailSegment.tr_config_MailSegment_Modified
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
           WHERE object_id = OBJECT_ID(N'dbo.tr_config_MailSegment_Modified'))
  DROP TRIGGER 
    dbo.tr_config_MailSegment_Modified
GO

SET ANSI_PADDING ON
GO

CREATE TRIGGER 
  dbo.tr_config_MailSegment_Modified
ON 
  config.MailSegment
 
FOR -- INSTEAD OF
  UPDATE -- INSERT DELETE
AS

UPDATE
  config.MailSegment 
SET
    ModifiedDate  = GETDATE()
  , ModifiedBy    = SUSER_SNAME()
WHERE
  MailSegmentID IN (SELECT MailSegmentID FROM INSERTED)





