/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   AdventureWorks_0006.dbo.MailCampaign
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
\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE AdventureWorks_0006
GO

IF EXISTS (SELECT *
           FROM sys.objects
           WHERE object_id = OBJECT_ID(N'dbo.MailCampaign')
                 AND type IN (N'U'))
    DROP TABLE 
      dbo.MailCampaign
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'dbo.MailCampaign')
                     AND type IN (N'U'))
  BEGIN
    CREATE TABLE
      dbo.MailCampaign
        (
            MailCampaignID        INT           NOT NULL
                                  IDENTITY(1,1)
                                  CONSTRAINT 
                                    PK_dbo_MailCampaign
                                  PRIMARY KEY CLUSTERED
          , SalesForceID          NCHAR(18)     NULL
          , StartDate             DATETIME      NULL
          , EndDate               DATETIME      NULL
          , MailCampaignName      NVARCHAR(80)  NOT NULL
          , MailingOrgID          TINYINT       NOT NULL
                                  CONSTRAINT
                                    FK_dbo_MailCampaign_MailingOrg
                                  FOREIGN KEY REFERENCES
                                    dbo.MailingOrg(MailingOrgID)
          , MailCycleDurrationID  TINYINT NOT NULL
                                    CONSTRAINT
                                    FK_dbo_MailCampaign_MailCycleDurrationID
                                  FOREIGN KEY REFERENCES
                                    dbo.MailCycleDurration(MailCycleDurrationID)
          , CycleStartDate        DATE NOT NULL
          , IsFinal               BIT NOT NULL
                                  CONSTRAINT
                                    DF_MailCampaign_IsFinal
                                  DEFAULT (0)
          , IsCancled             BIT NOT NULL
                                  CONSTRAINT
                                    DF_MailCampaign_IsCancled
                                  DEFAULT (0)
          , CreatedDate           DATETIME      NOT NULL
                                  CONSTRAINT
                                    DF_MailCampaign_CreatedDate
                                  DEFAULT 
                                    GETDATE()
          , CreatedBy             SYSNAME       NOT NULL
                                  CONSTRAINT
                                    DF_MailCampaign_CreatedBy
                                  DEFAULT 
                                    SUSER_NAME()
          , ModifiedDate          DATETIME      NOT NULL
                                  CONSTRAINT
                                    DF_MailCampaign_ModifiedDate
                                  DEFAULT 
                                    GETDATE()
          , ModifiedBy            SYSNAME       NOT NULL
                                  CONSTRAINT
                                    DF_MailCampaign_ModifiedBy
                                  DEFAULT 
                                    SUSER_NAME()
          , CONSTRAINT
              UN_MailCampaign_MailCampaignName
            UNIQUE
              (
                  MailCampaignName
                , MailingOrgID
              )
        )
  END
GO






