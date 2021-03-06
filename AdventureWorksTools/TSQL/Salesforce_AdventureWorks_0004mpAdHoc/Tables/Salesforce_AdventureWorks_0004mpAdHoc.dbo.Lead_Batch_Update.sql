/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   Salesforce_AdventureWorks_0004mpAdHoc.dbo.Lead_Batch_Update
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
  │                                                                                             │
  │                                                                                             │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ───────────────────────────────────────────────────────────────┤
      2019.01.08 bwarner         Initial Draft
  └─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE Salesforce_AdventureWorks_0004mpAdHoc
GO

IF EXISTS (SELECT *
           FROM sys.objects
           WHERE object_id = OBJECT_ID(N'dbo.Lead_Batch_Update')
                 AND type IN (N'U'))
    DROP TABLE 
      dbo.Lead_Batch_Update
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'dbo.Lead_Batch_Update')
                     AND type IN (N'U'))
  CREATE TABLE
    dbo.Lead_Batch_Update
      (
          Error                      NVARCHAR(255) NULL
        , Id                         NCHAR(18)     NULL
        , City                       NVARCHAR(50)  NULL
        , Commercial_Credit_Score__c DECIMAL(18,0) NULL
        , Company                    NVARCHAR(255) NULL
        , DUNS_Number__c             NVARCHAR(32)  NULL
        , FirstName                  NVARCHAR(40)  NULL
        , LastName                   NVARCHAR(80)  NULL
        , MSA_Code__c                NVARCHAR(32)  NULL
        , [Name]                     NVARCHAR(121) NULL
        , NumberOfEmployees          INT           NULL
        , Ownership__c               NVARCHAR(255) NULL
        , Owns_Rents1__c             NVARCHAR(255) NULL
        , Paydex_Band__c             DECIMAL(18,0) NULL
        , Phone                      NVARCHAR(40)  NULL
        , PostalCode                 NVARCHAR(20)  NULL
        , Response_Score__c          DECIMAL(18,0) NULL
        , Sales_Volume__c            DECIMAL(18,0) NULL
        , SICCODE__c                 NVARCHAR(16)  NULL
        , [State]                    NVARCHAR(20)  NULL
        , Street                     NVARCHAR(255) NULL
        , Year_Started__c            NVARCHAR(4)   NULL
        , UCC_Indicator__c           NVARCHAR(8)   NULL
        , Title                      NVARCHAR(128) NULL
        , Fund_Score__c              DECIMAL(18,0) NULL
        , Temp_Campaign_Id           NCHAR(18)     NOT  NULL
        , Temp_Account_Number        NVARCHAR(16)  NULL
        , stagingId                  INT           NOT  NULL
      )
GO




