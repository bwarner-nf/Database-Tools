/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   AdventureWorks_0006.dbo.MailSuppressionsByDUNS
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
  │                                                                                             │
  │                                                                                             │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ───────────────────────────────────────────────────────────────┤
      2018.11.12 bwarner         Initial Draft
\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE AdventureWorks_0006
GO

IF EXISTS (SELECT *
           FROM sys.objects
           WHERE object_id = OBJECT_ID(N'dbo.MailSuppressionsByDUNS')
                 AND type IN (N'U'))
    DROP TABLE 
      dbo.MailSuppressionsByDUNS
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'dbo.MailSuppressionsByDUNS')
                     AND type IN (N'U'))
  BEGIN
    CREATE TABLE
      dbo.MailSuppressionsByDUNS
        (
            DUNS                      INT       NOT NULL
                                      CONSTRAINT
                                        PK_MailSuppressionsByDUNS
                                      PRIMARY KEY CLUSTERED
          , MailSuppressionSourceID   TINYINT   NOT NULL
                                      CONSTRAINT
                                        FK_MailSuppressionsByDUNS_MailSuppressionSource
                                      FOREIGN KEY REFERENCES 
                                        dbo.MailSuppressionSource(MailSuppressionSourceID)
          , SalesForceID              NCHAR(18) NULL
          --, InfoID                    INT NULL
          , CreatedDate               DATETIME        NOT NULL
                                      CONSTRAINT
                                        DF_MailSuppressionsByDUNS_CreatedDate
                                      DEFAULT 
                                        GETDATE()
          , CreatedBy                 SYSNAME         NOT NULL
                                      CONSTRAINT
                                        DF_MailSuppressionsByDUNS_CreatedBy
                                      DEFAULT 
                                        SUSER_NAME()
          --, ModifiedDate              DATETIME        NOT NULL
          --                            CONSTRAINT
          --                              DF_MailSuppressionsByDUNS_ModifiedDate
          --                            DEFAULT 
          --                              GETDATE()
          --, ModifiedBy                SYSNAME         NOT NULL
          --                            CONSTRAINT
          --                              DF_MailSuppressionsByDUNS_ModifiedBy
          --                            DEFAULT 
          --                              SUSER_NAME()
        )
  END
GO






