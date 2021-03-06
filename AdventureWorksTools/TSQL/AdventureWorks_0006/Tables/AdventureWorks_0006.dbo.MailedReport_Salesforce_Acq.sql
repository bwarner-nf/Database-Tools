/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   AdventureWorks_0006.dbo.MailedReport_Salesforce_Acq
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
  │                                                                                             │
  │                                                                                             │
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
           WHERE object_id = OBJECT_ID(N'dbo.MailedReport_Salesforce_Acq')
                 AND type IN (N'U'))
    DROP TABLE 
      dbo.MailedReport_Salesforce_Acq
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'dbo.MailedReport_Salesforce_Acq')
                     AND type IN (N'U'))
  BEGIN
   CREATE TABLE 
    dbo.MailedReport_Salesforce_Acq
      (
          CampaignID                  NCHAR(18) NOT NULL
        , CampaignMemberID            NCHAR(18) NOT NULL
        , LeadID                      NCHAR(18) NOT NULL
        , AccountID                   NCHAR(18) NULL
        , AccountNo                   NVARCHAR(16) NULL
        , FirstRespondedDate          DATETIME NULL
        , MostRecentStartDate         DATETIME NULL
        , TimesMailed                 BIGINT NULL
        , TimesCount                  INT NULL
        , TimesCountYear              INT NULL
        , TimesMailedYear             BIGINT NULL
        , DUNS                        NVARCHAR(32) NULL
        , SIC                         NVARCHAR(16) NULL
        --, SICName__c                  NVARCHAR(100) NULL
        --, [State]                     NVARCHAR(80) NULL
        , GeoStateID                  TINYINT NULL

        , MSA                         NVARCHAR(8) NULL
        , YearStarted                 NVARCHAR(4) NULL
        , NumberOfEmployees           INT NULL
        , PaydexScore                 NVARCHAR(16) NULL
        , PaydexBand                  DECIMAL(18, 0) NULL
        , UCC_Indicator               NVARCHAR(8) NULL
        , SalesVolume                 DECIMAL(18, 0) NULL
        , ResponseScore               DECIMAL(18, 0) NULL
        , LeadListReference           NVARCHAR(63) NULL
        , ActivationDate              DATETIME NULL
        , InitialLeadSource           NVARCHAR(255) NULL
        , InitialResponseChannel      NVARCHAR(255) NULL
        , City                        NVARCHAR(40) NULL
        , PostalCode                  NVARCHAR(20) NULL
        , FundScore                   DECIMAL(18, 0) NULL
        , WeekNo                      NVARCHAR(1) NULL

        , MailingOrgID          TINYINT       NOT NULL
                                CONSTRAINT
                                  FK_dbo_MailingSegmentation_MailingOrg
                                FOREIGN KEY REFERENCES
                                  dbo.MailingOrg(MailingOrgID)
                                ON DELETE CASCADE
        --, MailingID             INT           NOT NULL         
        --                        CONSTRAINT
        --                          FK_dbo_MailingSegmentation_MailingID
        --                        FOREIGN KEY REFERENCES
        --                          dbo.Mailing(MailingID)
        --                        ON DELETE CASCADE

        , EmployeeSizeSegmentID SMALLINT      NOT NULL
                                CONSTRAINT
                                  FK_dbo_MailingSegmentation_EmployeeSizeSegmentID
                                FOREIGN KEY REFERENCES
                                  config.EmployeeSizeSegment(EmployeeSizeSegmentID)
        , BusinessAgeSegmentID  SMALLINT      NOT NULL
                                CONSTRAINT
                                  FK_dbo_MailingSegmentation_BusinessAgeSegmentID
                                FOREIGN KEY REFERENCES
                                  config.BusinessAgeSegment(BusinessAgeSegmentID)
        , GeoRegionID           TINYINT       NOT NULL
                                CONSTRAINT
                                  FK_dbo_MailingSegmentation_GeoRegionID
                                FOREIGN KEY REFERENCES
                                  ref.GeoRegion(GeoRegionID)
                                ON DELETE CASCADE
        --, Segments             VARCHAR(255) NULL
        , HasPaydex             TINYINT       NOT NULL


        , Year_Started_Segment        VARCHAR(9) NOT NULL
        , Empl_Segment                VARCHAR(7) NOT NULL
        , Empl_Paydex_Segment         VARCHAR(7) NOT NULL
        , Has_Paydex_Flag             INT NOT NULL

        , Has_UCC_Flag                INT NOT NULL
        , Sales_Volume_Segment        VARCHAR(9) NOT NULL
      )
  END
GO

SELECT DISTINCT Paydex_Score__c FROM AdventureWorks_0001.dbo.Acq_Mail_Current
/*

SELECT TOP 1000
    CampaignId
  , CampaignMemberId
  , LeadId
  , AccountId
  , Account_Number__c
  , FirstRespondedDate
  , MostRecentStartDate
  , TimesMailed
  , TimesCount
  , TimesCountYear
  , TimesMailedYear
  , DUNS_Number__c
  , SICCODE__c
  , SICName__c
  , [State]
  , MSA_Code__c
  , Year_Started__c
  , NumberOfEmployees
  , Paydex_Score__c
  , Paydex_Band__c
  , UCC_Indicator__c
  , Sales_Volume__c
  , Response_Score__c
  , Lead_List_Reference__c
  , Activation_Date__c
  , Initial_Lead_Source__c
  , Initial_Response_Channel__c
  , City
  , PostalCode
  , Fund_Score__c
  , Week_Num
  , Year_Started_Segment
  , Empl_Segment
  , Empl_Paydex_Segment
  , Has_Paydex_Flag
  , Has_UCC_Flag
  , Sales_Volume_Segment
FROM
  AdventureWorks_0001.dbo.Acq_Mail_Current



          CampaignId                   = 
        , CampaignMemberId             = 
        , LeadId                       = 
        , AccountId                    = 
        , Account_Number__c            = 
        , FirstRespondedDate           = 
        , MostRecentStartDate          = 
        , TimesMailed                  = 
        , TimesCount                   = 
        , TimesCountYear               = 
        , TimesMailedYear              = 
        , DUNS_Number__c               = 
        , SICCODE__c                   = 
        , SICName__c                   = 
        , [State]                      = 
        , MSA_Code__c                  = 
        , Year_Started__c              = 
        , NumberOfEmployees            = 
        , Paydex_Score__c              = 
        , Paydex_Band__c               = 
        , UCC_Indicator__c             = 
        , Sales_Volume__c              = 
        , Response_Score__c            = 
        , Lead_List_Reference__c       = 
        , Activation_Date__c           = 
        , Initial_Lead_Source__c       = 
        , Initial_Response_Channel__c  = 
        , City                         = 
        , PostalCode                   = 
        , Fund_Score__c                = 
        , Week_Num                     = 
        , Year_Started_Segment         = 
        , Empl_Segment                 = 
        , Empl_Paydex_Segment          = 
        , Has_Paydex_Flag              = 
        , Has_UCC_Flag                 = 
        , Sales_Volume_Segment         = 

        */




