/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   AdventureWorks_0006.imp.MenuUniverseExtract_02_AdventureWorks_0007_LicensedRecords
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
  │                                                                                             │
  │                                                                                             │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ───────────────────────────────────────────────────────────────┤
      2018.10.06 bwarner         Initial Draft
\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE AdventureWorks_0006
GO

IF EXISTS (SELECT *
           FROM sys.objects
           WHERE object_id = OBJECT_ID(N'imp.MenuUniverseExtract_02_AdventureWorks_0007_LicensedRecords')
                 AND type IN (N'U'))
    DROP TABLE 
      imp.MenuUniverseExtract_02_AdventureWorks_0007_LicensedRecords
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'imp.MenuUniverseExtract_02_AdventureWorks_0007_LicensedRecords')
                     AND type IN (N'U'))
  BEGIN
    CREATE TABLE
      imp.MenuUniverseExtract_02_AdventureWorks_0007_LicensedRecords
        (
            DUNS                            INT           NOT NULL
          , PhysicalStreetAddressLine1      VARCHAR(64)   NULL      -- siPhyAd1
          , PhysicalStreetAddressLine2      VARCHAR(64)   NULL      -- siPhyAd2
          , PhysicalCity                    VARCHAR(50)   NULL      -- siPhyCty
          , PhysicalStateAbbreviation       VARCHAR(10)   NULL      -- siPhyStat
          , PhysicalZipUS                   VARCHAR(16)   NULL      -- siPhyZip

          , MailStreetAddressLine1          VARCHAR(64)   NULL      -- siMlAd1
          , MailStreetAddressLine2          VARCHAR(64)   NULL      -- siMlAd2
          , MailCity                        VARCHAR(50)   NULL      -- siMlCty
          , MailState                       VARCHAR(10)   NULL      -- siMlStat
          , MailZip                         VARCHAR(16)   NULL      -- siMlZip

          , Telephone                       VARCHAR(16)   NULL      -- siTel

          , CEO_Prefix                      VARCHAR(10)   NULL      -- siCEOPre
          , CEO_FirstName                   VARCHAR(15)   NULL      -- siCEOFNm
          , CEO_MiddleInitial               VARCHAR(1)    NULL      -- siCEOMIn
          , CEO_LastName                    VARCHAR(15)   NULL      -- siCEOLNm
          , CEO_FullName                    VARCHAR(60)   NULL      -- siCEONm
          , CEO_Suffix                      VARCHAR(3)    NULL      -- siCEOSuf
          , CEOTitle                        VARCHAR(51)   NULL      -- siCEOTtl
          , CEO_MRC_Code                    VARCHAR(512)  NULL      -- siCEOMRC
        )
  END
GO










