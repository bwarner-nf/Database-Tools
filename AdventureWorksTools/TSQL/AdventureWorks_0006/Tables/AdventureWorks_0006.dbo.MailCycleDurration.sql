/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   AdventureWorks_0006.dbo.MailCycleDurration
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
  │                                                                                             │
  │                                                                                             │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ───────────────────────────────────────────────────────────────┤
      2018.12.26 bwarner         Initial Draft
\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE AdventureWorks_0006
GO

IF EXISTS (SELECT *
           FROM sys.objects
           WHERE object_id = OBJECT_ID(N'dbo.MailCycleDurration')
                 AND type IN (N'U'))
    DROP TABLE 
      dbo.MailCycleDurration
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'dbo.MailCycleDurration')
                     AND type IN (N'U'))
  BEGIN
    CREATE TABLE
      dbo.MailCycleDurration
        (
            MailCycleDurrationID    TINYINT        NOT NULL
                                    IDENTITY(1,1)
                                    CONSTRAINT 
                                      PK_dbo_MailCycleDurration
                                    PRIMARY KEY CLUSTERED
          , MailCycleDurrationName  VARCHAR(128)   NOT NULL
                                    CONSTRAINT
                                      UN_MailCycleDurration_MailCycleDurrationName
                                    UNIQUE
        )
  END
GO




/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤

INSERT
  dbo.MailCycleDurration
    (MailCycleDurrationName)
VALUES
    ('Weekly')
  , ('Bi-Weekly')
  , ('Monthly')
  , ('Bi-Monthly')
  , ('Quarterly')
  , ('Semi-Anually')
  , ('Annually')


SET IDENTITY_INSERT dbo.MailCycleDurration ON

INSERT
  dbo.MailCycleDurration
    (MailCycleDurrationID, MailCycleDurrationName)
VALUES
    (254, 'UNKNOWN')
  , (253, 'OTHER')

SET IDENTITY_INSERT dbo.MailCycleDurration OFF

SELECT * FROM dbo.MailCycleDurration

SELECT 
  '  , (' + LTRIM(STR(TinyIntVal)) + ', ''' +  SpecialValueMasterName + ''')'
FROM 
  ref.SpecialValueMaster

\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/







