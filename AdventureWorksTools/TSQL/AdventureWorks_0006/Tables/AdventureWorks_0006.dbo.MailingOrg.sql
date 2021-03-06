/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   AdventureWorks_0006.dbo.MailingOrg
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
  │                                                                                             │
  │                                                                                             │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ───────────────────────────────────────────────────────────────┤
      2018.11.08 bwarner         Initial Draft
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤

      INSERT
        dbo.MailingOrg
          (
              MailingOrgName
          )
      VALUES
        (
            'National Funding'
        )

      INSERT
        dbo.MailingOrg
          (
              MailingOrgName
          )
      VALUES
        (
            'QuickBridge'
        )
     
\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE AdventureWorks_0006
GO

IF EXISTS (SELECT *
           FROM sys.objects
           WHERE object_id = OBJECT_ID(N'dbo.MailingOrg')
                 AND type IN (N'U'))
    DROP TABLE 
      dbo.MailingOrg
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'dbo.MailingOrg')
                     AND type IN (N'U'))
  BEGIN
    CREATE TABLE
      dbo.MailingOrg
        (
            MailingOrgID    TINYINT        NOT NULL
                            IDENTITY(1,1)
                            CONSTRAINT 
                              PK_dbo_MailingOrg
                            PRIMARY KEY CLUSTERED
          , MailingOrgName  VARCHAR(128)   NOT NULL
                            CONSTRAINT
                              UN_dbo_MailingOrgName
                            UNIQUE
          , MailingOrgDesc  VARCHAR(512)   NULL
        )
  END
GO






