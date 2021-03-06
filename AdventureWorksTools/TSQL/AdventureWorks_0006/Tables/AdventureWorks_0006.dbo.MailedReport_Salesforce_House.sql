/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   AdventureWorks_0006.dbo.MailedReport_Salesforce_House
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
  │   Report table that holds data pulled from the salesforce replication for house             │
  │   mail                                                                                      │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ───────────────────────────────────────────────────────────────┤
      2018.12.27 bwarner         Initial Draft
\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE AdventureWorks_0006
GO

IF EXISTS (SELECT *
           FROM sys.objects
           WHERE object_id = OBJECT_ID(N'dbo.MailedReport_Salesforce_House')
                 AND type IN (N'U'))
    DROP TABLE 
      dbo.MailedReport_Salesforce_House
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'dbo.MailedReport_Salesforce_House')
                     AND type IN (N'U'))
  BEGIN
   CREATE TABLE 
    dbo.MailedReport_Salesforce_House
      (
          MailWeek          DATETIME      NOT NULL

        , MailingOrgID          TINYINT       NOT NULL
                                CONSTRAINT
                                  FK_dbo_MailingSegmentation_MailingOrg
                                FOREIGN KEY REFERENCES
                                  dbo.MailingOrg(MailingOrgID)
                                ON DELETE CASCADE
        , CampaignId        NCHAR(18)     NOT NULL
        , CampaignMemberId  NCHAR(18)     NOT NULL
        , LeadId            NCHAR(18)     NULL
        , ContactId         NCHAR(18)     NULL
        , AccountId         NCHAR(18)     NULL
        , AccountNo         NVARCHAR(16)  NULL
        , CONSTRAINT
            PK_MailedReport_Salesforce_House
          PRIMARY KEY CLUSTERED
            (
                MailWeek          ASC
              , CampaignId        ASC
              , CampaignMemberId  ASC 
            )
      )
  END
GO






