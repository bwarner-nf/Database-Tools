/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   AdventureWorks_0006.imp.MenuUniverseExtract_XX_IFG_All
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
  │   InfoGroup Unmatched Template                                                              │
  │                                                                                             │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ───────────────────────────────────────────────────────────────┤
      2018.10.18 bwarner         Initial Draft
\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE AdventureWorks_0006
GO

IF EXISTS (SELECT *
           FROM sys.objects
           WHERE object_id = OBJECT_ID(N'imp.MenuUniverseExtract_XX_IFG_All')
                 AND type IN (N'U'))
    DROP TABLE 
      imp.MenuUniverseExtract_XX_IFG_All
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'imp.MenuUniverseExtract_XX_IFG_All')
                     AND type IN (N'U'))
  BEGIN
    CREATE TABLE 
      imp.MenuUniverseExtract_XX_IFG_All
        (
            MonthCount                        TINYINT NOT NULL
          , [LOCATION NUMBER OF DEBTOR]       INT NULL -- [LOCATION NUMBER OF DEBTOR]       INT NULL
          , [INFOUSA CONTACT NAME]            VARCHAR(64) NULL -- [INFOUSA CONTACT NAME]            VARCHAR(64) NULL
          , FirstName                         VARCHAR(64) NULL -- FirstName                         VARCHAR(16) NULL
          , [MIDDLE NAME OF DEBTOR]           VARCHAR(64) NOT NULL -- [MIDDLE NAME OF DEBTOR]           VARCHAR(64) NOT NULL
          , [DEBTOR NAME]                     varchar(64) NOT NULL -- [DEBTOR NAME]                     varchar(64) NOT NULL
          , [LAST NAME SUFFIX]                varchar(3) NOT NULL -- [LAST NAME SUFFIX]                varchar(3) NOT NULL
 
          , LastName                         VARCHAR(16) NULL -- LastName                         VARCHAR(16) NULL
          , [Business Email Flag]            CHAR(1) NULL -- [Business Email Flag]            CHAR(1) NULL
          , [CONTACT TITLE CODE]             CHAR(1) NULL -- [CONTACT TITLE CODE]             CHAR(1) NULL
          , [CONTACT TITLE CODE DESCRIPTION] VARCHAR(32) NULL -- [CONTACT TITLE CODE DESCRIPTION] VARCHAR(32) NULL
          , [IUSA COMPANY NAME]              VARCHAR(64) NULL -- [IUSA COMPANY NAME]              VARCHAR(64) NULL
          , [IUSA MAILING ADDRESS]           VARCHAR(64) NULL -- [IUSA MAILING ADDRESS]           VARCHAR(64) NULL
          , [IUSA MAIL CITY NAME]            VARCHAR(64) NULL -- [IUSA MAIL CITY NAME]            VARCHAR(32) NULL
          , [IUSA MAIL STATE ABBREV]         CHAR(2) NULL -- [IUSA MAIL STATE ABBREV]         CHAR(2) NULL
          , [IUSA MAIL ZIP]                  INT NULL -- [IUSA MAIL ZIP]                  INT NULL
          , [IUSA MAIL ZIP4]                 SMALLINT NULL -- [IUSA MAIL ZIP4]                 SMALLINT NULL
          , [IUSA MAIL ZIP MERGE]            VARCHAR(10) NULL -- [IUSA MAIL ZIP MERGE]            VARCHAR(10) NULL
          , [IUSA MAIL CRCODE]               CHAR(4) NULL -- [IUSA MAIL CRCODE]               CHAR(4) NULL
          , [IUSA MAIL STATE CODE]           TINYINT NULL -- [IUSA MAIL STATE CODE]           TINYINT NULL
          , [IUSA MAIL COUNTY CODE]          SMALLINT NULL -- [IUSA MAIL COUNTY CODE]          SMALLINT NULL
          , [IUSA COUNTY DESC]               VARCHAR(16) NULL -- [IUSA COUNTY DESC]               VARCHAR(16) NULL
          --, [MSA CODE]                       VARCHAR(255) NULL
          --, [MSA DESCRIPTION]                VARCHAR(255) NULL
          , [IUSA CENSUS TRACT]              INT NULL -- [IUSA CENSUS TRACT]              INT NULL
          , [IUSA BLOCK GROUP]               TINYINT NULL -- [IUSA BLOCK GROUP]               TINYINT NULL
          , [IUSA PHONE NUMBER]              CHAR(12) NULL -- [IUSA PHONE NUMBER]              CHAR(12) NULL
          , FAXNUMO                          CHAR(12) NULL -- FAXNUMO                          CHAR(12) NULL
          , [PRIMARY SIC CODE]               INT NULL -- [PRIMARY SIC CODE]               INT NULL
          , [PRIMARY SIC DESC]               VARCHAR(64) NULL -- [PRIMARY SIC DESC]               VARCHAR(64) NULL
          , [SEC SIC CODE 1]                 INT NULL -- [SEC SIC CODE 1]                 INT NULL
          , [SEC SIC DESC 1]                 VARCHAR(64) NULL -- [SEC SIC DESC 1]                 VARCHAR(64) NULL
          , [SEC SIC CODE 2]                 INT NULL -- [SEC SIC CODE 2]                 INT NULL
          , [SEC SIC DESC 2]                 VARCHAR(64) NULL -- [SEC SIC DESC 2]                 VARCHAR(64) NULL
          , [SEC SIC CODE 3]                 INT NULL -- [SEC SIC CODE 3]                 INT NULL
          , [SEC SIC DESC 3]                 VARCHAR(64) NULL -- [SEC SIC DESC 3]                 VARCHAR(64) NULL
          , [SEC SIC CODE 4]                 INT NULL -- [SEC SIC CODE 4]                 INT NULL
          , [SEC SIC DESC 4]                 VARCHAR(64) NULL -- [SEC SIC DESC 4]                 VARCHAR(64) NULL
          , [NAICS CODE]                     INT NULL -- [NAICS CODE]                     INT NULL
          , [NAICS DESCRIPTION]              VARCHAR(128) NULL -- [NAICS DESCRIPTION]              VARCHAR(128) NULL
          , [LOC EMP SIZE CODE]              CHAR(1) NULL -- [LOC EMP SIZE CODE]              CHAR(1) NULL
          , [LOC EMP SIZE DESC]              VARCHAR(16) NULL -- [LOC EMP SIZE DESC]              VARCHAR(16) NULL
          , [ACTUAL LOCATION EMPLOYEE SIZE]  INT NULL -- [ACTUAL LOCATION EMPLOYEE SIZE]  INT NULL
          , [LOC SALES VOLUME CODE]          CHAR(1) NULL -- [LOC SALES VOLUME CODE]          CHAR(1) NULL
          , [LOCATION SALES VOL DESC]        VARCHAR(32) NULL -- [LOCATION SALES VOL DESC]        VARCHAR(32) NULL
          , [ACTUAL LOCATION SALES VOLUME]   BIGINT NULL -- [ACTUAL LOCATION SALES VOLUME]   BIGINT NULL
          --, [IUSA SUBSIDIARY ID]             VARCHAR(255) NULL
          --, [IUSA PARENT ID]                 VARCHAR(255) NULL
          , [BUSINESS STATUS CODE]           TINYINT NULL -- [BUSINESS STATUS CODE]           TINYINT NULL
          , [YEAR FIRST APPEARED IN YP]      SMALLINT NULL -- [YEAR FIRST APPEARED IN YP]      SMALLINT NULL
          , [BUS CREDIT SCORE CODE]          VARCHAR(2) NULL -- [BUS CREDIT SCORE CODE]          VARCHAR(2) NULL
          , [BUSINESS CREDIT SCORE CODE]     VARCHAR(32) NULL -- [BUSINESS CREDIT SCORE CODE]     VARCHAR(32) NULL
          , [BUSINESS CREDIT SCORE (ACTUAL)] TINYINT NULL -- [BUSINESS CREDIT SCORE (ACTUAL)] TINYINT NULL
          , [WORK AT HOME INDICATOR]         CHAR(1) NULL -- [WORK AT HOME INDICATOR]         CHAR(1) NULL
          , [OWN-LEASE CODE]                 CHAR(1) NULL -- [OWN-LEASE CODE]                 CHAR(1) NULL
          --, [SQUARE FOOTAGE CODE]            VARCHAR(255) NULL
          , [WEB ADDRESS - URL]              VARCHAR(2083) NULL -- [WEB ADDRESS - URL]              VARCHAR(2083) NULL
          , [COLLATERAL TYPE]                CHAR(2) NULL -- [COLLATERAL TYPE]                CHAR(2) NULL
          , [COLLATERAL TYPE DESC]           VARCHAR(32) NULL -- [COLLATERAL TYPE DESC]           VARCHAR(32) NULL
          , [CORP OR IND]                    CHAR(1) NULL -- [CORP OR IND]                    CHAR(1) NULL
          , [DAY ADDED TO UCC DB]            TINYINT NULL -- [DAY ADDED TO UCC DB]            TINYINT NULL
          , [MONTH ADDED TO UCC DB]          TINYINT NULL -- [MONTH ADDED TO UCC DB]          TINYINT NULL
          , [YEAR ADDED TO UCC DB]           SMALLINT NULL -- [YEAR ADDED TO UCC DB]           SMALLINT NULL
          , [RECEIVED DAY]                   TINYINT NULL -- [RECEIVED DAY]                   TINYINT NULL
          , [RECEIVED MONTH]                 TINYINT NULL -- [RECEIVED MONTH]                 TINYINT NULL
          , [RECEIVED YEAR]                  SMALLINT NULL -- [RECEIVED YEAR]                  SMALLINT NULL
          , [DELIVERABILITY SCORE]           CHAR(2) NULL -- [DELIVERABILITY SCORE]           CHAR(2) NULL
          , [DELIVERY POINT BARCODE]         SMALLINT NULL -- [DELIVERY POINT BARCODE]         SMALLINT NULL
          , [EXP DAY]                        TINYINT NULL -- [EXP DAY]                        TINYINT NULL
          , [EXP MONTH]                      TINYINT NULL -- [EXP MONTH]                      TINYINT NULL
          , [EXP YEAR]                       SMALLINT NULL -- [EXP YEAR]                       SMALLINT NULL
          , [FILING DAY]                     TINYINT NULL -- [FILING DAY]                     TINYINT NULL
          , [FILING MONTH]                   TINYINT NULL -- [FILING MONTH]                   TINYINT NULL
          , [FILING YEAR]                    SMALLINT NULL -- [FILING YEAR]                    SMALLINT NULL
          , [FILING STATE]                   CHAR(2) NULL -- [FILING STATE]                   CHAR(2) NULL
          --, [FILING STATUS]                  CHAR(1) NULL
          , [FILING STATUS DESC]             VARCHAR(8) NULL -- [FILING STATUS DESC]             VARCHAR(8) NULL
          , [FILING TYPE CODE]               CHAR(2) NULL -- [FILING TYPE CODE]               CHAR(2) NULL
          , [FILING TYPE DESC]               CHAR(8) NULL -- [FILING TYPE DESC]               CHAR(8) NULL
          , [ORIGINAL FILING ID]             VARCHAR(32) NULL -- [ORIGINAL FILING ID]             VARCHAR(32) NULL
          , [PARTY TYPE CODE]                CHAR(1) NULL -- [PARTY TYPE CODE]                CHAR(1) NULL
          , [SOURCE FILING ID]               VARCHAR(32) NULL -- [SOURCE FILING ID]               VARCHAR(32) NULL
          , [SEC PARTY NAME]                 VARCHAR(64) NULL -- [SEC PARTY NAME]                 VARCHAR(64) NULL
          , [SECURED PARTY ADDRESS]          VARCHAR(64) NULL -- [SECURED PARTY ADDRESS]          VARCHAR(64) NULL
          , [SECURED PARTY CITY]             VARCHAR(32) NULL -- [SECURED PARTY CITY]             VARCHAR(32) NULL
          , [SEC PARTY STATE]                CHAR(2) NULL -- [SEC PARTY STATE]                CHAR(2) NULL
          , [SECURED PARTY ZIP]              INT NULL -- [SECURED PARTY ZIP]              INT NULL
          , [SECURED PARTY ZIP4]             SMALLINT NULL -- [SECURED PARTY ZIP4]             SMALLINT NULL
          , [match code]                     CHAR(1) NULL -- [match code]                     CHAR(1) NULL
          , [Fulfillment Flag]               CHAR(1) NULL -- [Fulfillment Flag]               CHAR(1) NULL
          , [Key Code 1]                     VARCHAR(8) NULL -- [Key Code 1]                     VARCHAR(8) NULL
          , InfoId                           BIGINT NULL -- InfoId                           INT NULL
          --, startDate                        DATE NOT NULL
          --, endDate                          DATE NOT NULL
        )
  END
GO












