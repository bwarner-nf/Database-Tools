/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   AdventureWorks_0006.imp.MenuUniverseExtract_T1_IFG_Matched
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
           WHERE object_id = OBJECT_ID(N'imp.MenuUniverseExtract_T1_IFG_Matched')
                 AND type IN (N'U'))
    DROP TABLE 
      imp.MenuUniverseExtract_T1_IFG_Matched
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'imp.MenuUniverseExtract_T1_IFG_Matched')
                     AND type IN (N'U'))
  BEGIN
    CREATE TABLE 
      imp.MenuUniverseExtract_T1_IFG_Matched
        (
            MonthCount                       TINYINT NOT NULL
          , [LOCATION NUMBER OF DEBTOR]      INT NULL
          , [INFOUSA CONTACT NAME]           VARCHAR(64) NULL
          , FirstName                        VARCHAR(16) NULL
          , LastName                         VARCHAR(16) NULL
          , [Business Email Flag]            CHAR(1) NULL
          , [CONTACT TITLE CODE]             CHAR(1) NULL
          , [CONTACT TITLE CODE DESCRIPTION] VARCHAR(32) NULL
          , [IUSA COMPANY NAME]              VARCHAR(64) NULL
          , [IUSA MAILING ADDRESS]           VARCHAR(64) NULL
          , [IUSA MAIL CITY NAME]            VARCHAR(32) NULL
          , [IUSA MAIL STATE ABBREV]         CHAR(2) NULL
          , [IUSA MAIL ZIP]                  INT NULL
          , [IUSA MAIL ZIP4]                 SMALLINT NULL
          , [IUSA MAIL ZIP MERGE]            VARCHAR(10) NULL
          , [IUSA MAIL CRCODE]               CHAR(4) NULL
          , [IUSA MAIL STATE CODE]           TINYINT NULL
          , [IUSA MAIL COUNTY CODE]          SMALLINT NULL
          , [IUSA COUNTY DESC]               VARCHAR(16) NULL
          --, [MSA CODE]                       VARCHAR(255) NULL
          --, [MSA DESCRIPTION]                VARCHAR(255) NULL
          , [IUSA CENSUS TRACT]              INT NULL
          , [IUSA BLOCK GROUP]               TINYINT NULL
          , [IUSA PHONE NUMBER]              CHAR(12) NULL
          , FAXNUMO                          CHAR(12) NULL
          , [PRIMARY SIC CODE]               INT NULL
          , [PRIMARY SIC DESC]               VARCHAR(64) NULL
          , [SEC SIC CODE 1]                 INT NULL
          , [SEC SIC DESC 1]                 VARCHAR(64) NULL
          , [SEC SIC CODE 2]                 INT NULL
          , [SEC SIC DESC 2]                 VARCHAR(64) NULL
          , [SEC SIC CODE 3]                 INT NULL
          , [SEC SIC DESC 3]                 VARCHAR(64) NULL
          , [SEC SIC CODE 4]                 INT NULL
          , [SEC SIC DESC 4]                 VARCHAR(64) NULL
          , [NAICS CODE]                     INT NULL
          , [NAICS DESCRIPTION]              VARCHAR(128) NULL
          , [LOC EMP SIZE CODE]              CHAR(1) NULL
          , [LOC EMP SIZE DESC]              VARCHAR(16) NULL
          , [ACTUAL LOCATION EMPLOYEE SIZE]  INT NULL
          , [LOC SALES VOLUME CODE]          CHAR(1) NULL
          , [LOCATION SALES VOL DESC]        VARCHAR(32) NULL
          , [ACTUAL LOCATION SALES VOLUME]   BIGINT NULL
          --, [IUSA SUBSIDIARY ID]             VARCHAR(255) NULL
          --, [IUSA PARENT ID]                 VARCHAR(255) NULL
          , [BUSINESS STATUS CODE]           TINYINT NULL
          , [YEAR FIRST APPEARED IN YP]      SMALLINT NULL
          , [BUS CREDIT SCORE CODE]          VARCHAR(2) NULL
          , [BUSINESS CREDIT SCORE CODE]     VARCHAR(32) NULL
          , [BUSINESS CREDIT SCORE (ACTUAL)] TINYINT NULL
          , [WORK AT HOME INDICATOR]         CHAR(1) NULL
          , [OWN-LEASE CODE]                 CHAR(1) NULL
          --, [SQUARE FOOTAGE CODE]            VARCHAR(255) NULL
          , [WEB ADDRESS - URL]              VARCHAR(2083) NULL
          , [COLLATERAL TYPE]                CHAR(2) NULL
          , [COLLATERAL TYPE DESC]           VARCHAR(32) NULL
          , [CORP OR IND]                    CHAR(1) NULL
          , [DAY ADDED TO UCC DB]            TINYINT NULL
          , [MONTH ADDED TO UCC DB]          TINYINT NULL
          , [YEAR ADDED TO UCC DB]           SMALLINT NULL
          , [RECEIVED DAY]                   TINYINT NULL
          , [RECEIVED MONTH]                 TINYINT NULL
          , [RECEIVED YEAR]                  SMALLINT NULL
          , [DELIVERABILITY SCORE]           CHAR(2) NULL
          , [DELIVERY POINT BARCODE]         SMALLINT NULL
          , [EXP DAY]                        TINYINT NULL
          , [EXP MONTH]                      TINYINT NULL
          , [EXP YEAR]                       SMALLINT NULL
          , [FILING DAY]                     TINYINT NULL
          , [FILING MONTH]                   TINYINT NULL
          , [FILING YEAR]                    SMALLINT NULL
          , [FILING STATE]                   CHAR(2) NULL
          --, [FILING STATUS]                  CHAR(1) NULL
          , [FILING STATUS DESC]             VARCHAR(8) NULL
          , [FILING TYPE CODE]               CHAR(2) NULL
          , [FILING TYPE DESC]               CHAR(8) NULL
          , [ORIGINAL FILING ID]             VARCHAR(32) NULL
          , [PARTY TYPE CODE]                CHAR(1) NULL
          , [SOURCE FILING ID]               VARCHAR(32) NULL
          , [SEC PARTY NAME]                 VARCHAR(64) NULL
          , [SECURED PARTY ADDRESS]          VARCHAR(64) NULL
          , [SECURED PARTY CITY]             VARCHAR(32) NULL
          , [SEC PARTY STATE]                CHAR(2) NULL
          , [SECURED PARTY ZIP]              INT NULL
          , [SECURED PARTY ZIP4]             SMALLINT NULL
          , [match code]                     CHAR(1) NULL
          , [Fulfillment Flag]               CHAR(1) NULL
          , [Key Code 1]                     VARCHAR(8) NULL
          , InfoId                           INT NULL
          --, startDate                        DATE NOT NULL
          --, endDate                          DATE NOT NULL
        )
  END
GO










/*


      , [LOCATION NUMBER OF DEBTOR]      INT NULL
      , [INFOUSA CONTACT NAME]           VARCHAR(64) NULL
      , FirstName                        VARCHAR(16) NULL
      , LastName                         VARCHAR(16) NULL
      , [Business Email Flag]            CHAR(1) NULL
      , [CONTACT TITLE CODE]             CHAR(1) NULL
      , [CONTACT TITLE CODE DESCRIPTION] VARCHAR(32) NULL
      , [IUSA COMPANY NAME]              VARCHAR(64) NULL
      , [IUSA MAILING ADDRESS]           VARCHAR(64) NULL
      , [IUSA MAIL CITY NAME]            VARCHAR(32) NULL
      , [IUSA MAIL STATE ABBREV]         CHAR(2) NULL
      , [IUSA MAIL ZIP]                  INT NULL
      , [IUSA MAIL ZIP4]                 SMALLINT NULL
      , [IUSA MAIL ZIP MERGE]            VARCHAR(10) NULL
      , [IUSA MAIL CRCODE]               CHAR(4) NULL
      , [IUSA MAIL STATE CODE]           TINYINT NULL
      , [IUSA MAIL COUNTY CODE]          SMALLINT NULL
      , [IUSA COUNTY DESC]               VARCHAR(16) NULL
      --, [MSA CODE]                       VARCHAR(255) NULL
      --, [MSA DESCRIPTION]                VARCHAR(255) NULL
      , [IUSA CENSUS TRACT]              INT NULL
      , [IUSA BLOCK GROUP]               TINYINT NULL
      , [IUSA PHONE NUMBER]              VARCHAR(12) NULL
      , FAXNUMO                          VARCHAR(12) NULL
      , [PRIMARY SIC CODE]               INT NULL
      , [PRIMARY SIC DESC]               VARCHAR(64) NULL
      , [SEC SIC CODE 1]                 INT NULL
      , [SEC SIC DESC 1]                 VARCHAR(64) NULL
      , [SEC SIC CODE 2]                 INT NULL
      , [SEC SIC DESC 2]                 VARCHAR(64) NULL
      , [SEC SIC CODE 3]                 INT NULL
      , [SEC SIC DESC 3]                 VARCHAR(64) NULL
      , [SEC SIC CODE 4]                 INT NULL
      , [SEC SIC DESC 4]                 VARCHAR(64) NULL
      , [NAICS CODE]                     INT NULL
      , [NAICS DESCRIPTION]              VARCHAR(128) NULL
      , [LOC EMP SIZE CODE]              VARCHAR(1) NULL
      , [LOC EMP SIZE DESC]              VARCHAR(7) NULL
      , [ACTUAL LOCATION EMPLOYEE SIZE]  SMALLINT NULL
      , [LOC SALES VOLUME CODE]          VARCHAR(1) NULL
      , [LOCATION SALES VOL DESC]        VARCHAR(32) NULL
      , [ACTUAL LOCATION SALES VOLUME]   SMALLINT NULL
      --, [IUSA SUBSIDIARY ID]             VARCHAR(255) NULL
      --, [IUSA PARENT ID]                 VARCHAR(255) NULL
      , [BUSINESS STATUS CODE]           TINYINT NULL
      , [YEAR FIRST APPEARED IN YP]      SMALLINT NULL
      , [BUS CREDIT SCORE CODE]          VARCHAR(2) NULL
      , [BUSINESS CREDIT SCORE CODE]     VARCHAR(32) NULL
      , [BUSINESS CREDIT SCORE (ACTUAL)] TINYINT NULL
      , [WORK AT HOME INDICATOR]         VARCHAR(1) NULL
      , [OWN-LEASE CODE]                 VARCHAR(1) NULL
      --, [SQUARE FOOTAGE CODE]            VARCHAR(255) NULL
      , [WEB ADDRESS - URL]              VARCHAR(64) NULL
      , [COLLATERAL TYPE]                VARCHAR(2) NULL
      , [COLLATERAL TYPE DESC]           VARCHAR(32) NULL
      , [CORP OR IND]                    VARCHAR(1) NULL
      , [DAY ADDED TO UCC DB]            TINYINT NULL
      , [MONTH ADDED TO UCC DB]          TINYINT NULL
      , [YEAR ADDED TO UCC DB]           SMALLINT NULL
      , [RECEIVED DAY]                   TINYINT NULL
      , [RECEIVED MONTH]                 TINYINT NULL
      , [RECEIVED YEAR]                  SMALLINT NULL
      , [DELIVERABILITY SCORE]           VARCHAR(2) NULL
      , [DELIVERY POINT BARCODE]         SMALLINT NULL
      , [EXP DAY]                        TINYINT NULL
      , [EXP MONTH]                      TINYINT NULL
      , [EXP YEAR]                       SMALLINT NULL
      , [FILING DAY]                     TINYINT NULL
      , [FILING MONTH]                   TINYINT NULL
      , [FILING YEAR]                    SMALLINT NULL
      , [FILING STATE]                   VARCHAR(2) NULL
      --, [FILING STATUS]                  VARCHAR(1) NULL
      , [FILING STATUS DESC]             VARCHAR(7) NULL
      , [FILING TYPE CODE]               VARCHAR(2) NULL
      , [FILING TYPE DESC]               VARCHAR(8) NULL
      , [ORIGINAL FILING ID]             VARCHAR(32) NULL
      , [PARTY TYPE CODE]                VARCHAR(1) NULL
      , [SOURCE FILING ID]               VARCHAR(32) NULL
      , [SEC PARTY NAME]                 VARCHAR(64) NULL
      , [SECURED PARTY ADDRESS]          VARCHAR(64) NULL
      , [SECURED PARTY CITY]             VARCHAR(32) NULL
      , [SEC PARTY STATE]                VARCHAR(2) NULL
      , [SECURED PARTY ZIP]              INT NULL
      , [SECURED PARTY ZIP4]             SMALLINT NULL
      , [match code]                     VARCHAR(1) NULL
      , [Fulfillment Flag]               VARCHAR(1) NULL
      , [Key Code 1]                     VARCHAR(8) NULL
      , InfoId                           INT NOT NULL
      --, startDate                        DATE NOT NULL
      --, endDate                          DATE NOT NULL



      , [LOCATION NUMBER OF DEBTOR]       VARCHAR(9) NOT NULL
      , [INFOUSA CONTACT NAME]            VARCHAR(64) NOT NULL
      , FirstName                         VARCHAR(11) NOT NULL
      , LastName                          VARCHAR(14) NOT NULL
      , [Business Email Flag]             VARCHAR(1) NOT NULL
      , [CONTACT TITLE CODE]              VARCHAR(1) NOT NULL
      , [CONTACT TITLE CODE DESCRIPTION]  VARCHAR(32) NOT NULL
      , [IUSA COMPANY NAME]               VARCHAR(64) NOT NULL
      , [IUSA MAILING ADDRESS]            VARCHAR(64) NOT NULL
      , [IUSA MAIL CITY NAME]             VARCHAR(32) NOT NULL
      , [IUSA MAIL STATE ABBREV]          VARCHAR(2) NOT NULL
      , [IUSA MAIL ZIP]                   VARCHAR(5) NOT NULL
      , [IUSA MAIL ZIP4]                  VARCHAR(4) NOT NULL
      , [IUSA MAIL ZIP MERGE]             VARCHAR(10) NOT NULL
      , [IUSA MAIL CRCODE]                VARCHAR(4) NOT NULL
      , [IUSA MAIL STATE CODE]            VARCHAR(2) NOT NULL
      , [IUSA MAIL COUNTY CODE]           VARCHAR(3) NOT NULL
      , [IUSA COUNTY DESC]                VARCHAR(14) NOT NULL
      --, [MSA CODE]                        VARCHAR(255) NULL
      --, [MSA DESCRIPTION]                 VARCHAR(255) NULL
      , [IUSA CENSUS TRACT]               VARCHAR(6) NOT NULL
      , [IUSA BLOCK GROUP]                VARCHAR(1) NOT NULL
      , [IUSA PHONE NUMBER]               VARCHAR(12) NOT NULL
      , FAXNUMO                           VARCHAR(12) NOT NULL
      , [PRIMARY SIC CODE]                VARCHAR(6) NOT NULL
      , [PRIMARY SIC DESC]                VARCHAR(64) NOT NULL
      , [SEC SIC CODE 1]                  VARCHAR(6) NOT NULL
      , [SEC SIC DESC 1]                  VARCHAR(64) NOT NULL
      , [SEC SIC CODE 2]                  VARCHAR(6) NOT NULL
      , [SEC SIC DESC 2]                  VARCHAR(64) NOT NULL
      , [SEC SIC CODE 3]                  VARCHAR(6) NOT NULL
      , [SEC SIC DESC 3]                  VARCHAR(64) NOT NULL
      , [SEC SIC CODE 4]                  VARCHAR(6) NOT NULL
      , [SEC SIC DESC 4]                  VARCHAR(64) NOT NULL
      , [NAICS CODE]                      VARCHAR(8) NOT NULL
      , [NAICS DESCRIPTION]               VARCHAR(128) NOT NULL
      , [LOC EMP SIZE CODE]               VARCHAR(1) NOT NULL
      , [LOC EMP SIZE DESC]               VARCHAR(7) NOT NULL
      , [ACTUAL LOCATION EMPLOYEE SIZE]   VARCHAR(5) NOT NULL
      , [LOC SALES VOLUME CODE]           VARCHAR(1) NOT NULL
      , [LOCATION SALES VOL DESC]         VARCHAR(32) NOT NULL
      , [ACTUAL LOCATION SALES VOLUME]    VARCHAR(9) NOT NULL
      --, [IUSA SUBSIDIARY ID]              VARCHAR(255) NULL
      --, [IUSA PARENT ID]                  VARCHAR(255) NULL
      , [BUSINESS STATUS CODE]            VARCHAR(1) NOT NULL
      , [YEAR FIRST APPEARED IN YP]       VARCHAR(4) NOT NULL
      , [BUS CREDIT SCORE CODE]           VARCHAR(2) NOT NULL
      , [BUSINESS CREDIT SCORE CODE]      VARCHAR(32) NOT NULL
      , [BUSINESS CREDIT SCORE (ACTUAL)]  VARCHAR(3) NOT NULL
      , [WORK AT HOME INDICATOR]          VARCHAR(1) NOT NULL
      , [OWN-LEASE CODE]                  VARCHAR(1) NOT NULL
      --, [SQUARE FOOTAGE CODE]             VARCHAR(255) NULL
      , [WEB ADDRESS - URL]               VARCHAR(64) NOT NULL
      , [COLLATERAL TYPE]                 VARCHAR(2) NOT NULL
      , [COLLATERAL TYPE DESC]            VARCHAR(32) NOT NULL
      , [CORP OR IND]                     VARCHAR(1) NOT NULL
      , [DAY ADDED TO UCC DB]             VARCHAR(2) NOT NULL
      , [MONTH ADDED TO UCC DB]           VARCHAR(2) NOT NULL
      , [YEAR ADDED TO UCC DB]            VARCHAR(4) NOT NULL
      , [RECEIVED DAY]                    VARCHAR(2) NOT NULL
      , [RECEIVED MONTH]                  VARCHAR(2) NOT NULL
      , [RECEIVED YEAR]                   VARCHAR(4) NOT NULL
      , [DELIVERABILITY SCORE]            VARCHAR(2) NOT NULL
      , [DELIVERY POINT BARCODE]          VARCHAR(3) NOT NULL
      , [EXP DAY]                         VARCHAR(2) NOT NULL
      , [EXP MONTH]                       VARCHAR(2) NOT NULL
      , [EXP YEAR]                        VARCHAR(4) NOT NULL
      , [FILING DAY]                      VARCHAR(2) NOT NULL
      , [FILING MONTH]                    VARCHAR(2) NOT NULL
      , [FILING YEAR]                     VARCHAR(4) NOT NULL
      , [FILING STATE]                    VARCHAR(2) NOT NULL
      --, [FILING STATUS]                   VARCHAR(1) NOT NULL
      , [FILING STATUS DESC]              VARCHAR(7) NOT NULL
      , [FILING TYPE CODE]                VARCHAR(2) NOT NULL
      , [FILING TYPE DESC]                VARCHAR(8) NOT NULL
      , [ORIGINAL FILING ID]              VARCHAR(32) NOT NULL
      , [PARTY TYPE CODE]                 VARCHAR(1) NOT NULL
      , [SOURCE FILING ID]                VARCHAR(32) NOT NULL
      , [SEC PARTY NAME]                  VARCHAR(64) NOT NULL
      , [SECURED PARTY ADDRESS]           VARCHAR(64) NOT NULL
      , [SECURED PARTY CITY]              VARCHAR(32) NOT NULL
      , [SEC PARTY STATE]                 VARCHAR(2) NOT NULL
      , [SECURED PARTY ZIP]               VARCHAR(5) NOT NULL
      , [SECURED PARTY ZIP4]              VARCHAR(4) NOT NULL
      , [match code]                      VARCHAR(1) NOT NULL
      , [Fulfillment Flag]                VARCHAR(1) NOT NULL
      , [Key Code 1]                      VARCHAR(8) NOT NULL
      , InfoId                            BIGINT NOT NULL
*/



      --, [LOCATION NUMBER OF DEBTOR]       VARCHAR(255) NULL
      --, [INFOUSA CONTACT NAME]            VARCHAR(255) NULL
      --, FirstName                         VARCHAR(255) NULL
      --, LastName                          VARCHAR(255) NULL
      --, [Business Email Flag]             VARCHAR(255) NULL
      --, [CONTACT TITLE CODE]              VARCHAR(255) NULL
      --, [CONTACT TITLE CODE DESCRIPTION]  VARCHAR(255) NULL
      --, [IUSA COMPANY NAME]               VARCHAR(255) NULL
      --, [IUSA MAILING ADDRESS]            VARCHAR(255) NULL
      --, [IUSA MAIL CITY NAME]             VARCHAR(255) NULL
      --, [IUSA MAIL STATE ABBREV]          VARCHAR(255) NULL
      --, [IUSA MAIL ZIP]                   VARCHAR(255) NULL
      --, [IUSA MAIL ZIP4]                  VARCHAR(255) NULL
      --, [IUSA MAIL ZIP MERGE]             VARCHAR(255) NULL
      --, [IUSA MAIL CRCODE]                VARCHAR(255) NULL
      --, [IUSA MAIL STATE CODE]            VARCHAR(255) NULL
      --, [IUSA MAIL COUNTY CODE]           VARCHAR(255) NULL
      --, [IUSA COUNTY DESC]                VARCHAR(255) NULL
      --, [MSA CODE]                        VARCHAR(255) NULL
      --, [MSA DESCRIPTION]                 VARCHAR(255) NULL
      --, [IUSA CENSUS TRACT]               VARCHAR(255) NULL
      --, [IUSA BLOCK GROUP]                VARCHAR(255) NULL
      --, [IUSA PHONE NUMBER]               VARCHAR(255) NULL
      --, FAXNUMO                           VARCHAR(255) NULL
      --, [PRIMARY SIC CODE]                VARCHAR(255) NULL
      --, [PRIMARY SIC DESC]                VARCHAR(255) NULL
      --, [SEC SIC CODE 1]                  VARCHAR(255) NULL
      --, [SEC SIC DESC 1]                  VARCHAR(255) NULL
      --, [SEC SIC CODE 2]                  VARCHAR(255) NULL
      --, [SEC SIC DESC 2]                  VARCHAR(255) NULL
      --, [SEC SIC CODE 3]                  VARCHAR(255) NULL
      --, [SEC SIC DESC 3]                  VARCHAR(255) NULL
      --, [SEC SIC CODE 4]                  VARCHAR(255) NULL
      --, [SEC SIC DESC 4]                  VARCHAR(255) NULL
      --, [NAICS CODE]                      VARCHAR(255) NULL
      --, [NAICS DESCRIPTION]               VARCHAR(255) NULL
      --, [LOC EMP SIZE CODE]               VARCHAR(255) NULL
      --, [LOC EMP SIZE DESC]               VARCHAR(255) NULL
      --, [ACTUAL LOCATION EMPLOYEE SIZE]   VARCHAR(255) NULL
      --, [LOC SALES VOLUME CODE]           VARCHAR(255) NULL
      --, [LOCATION SALES VOL DESC]         VARCHAR(255) NULL
      --, [ACTUAL LOCATION SALES VOLUME]    VARCHAR(255) NULL
      --, [IUSA SUBSIDIARY ID]              VARCHAR(255) NULL
      --, [IUSA PARENT ID]                  VARCHAR(255) NULL
      --, [BUSINESS STATUS CODE]            VARCHAR(255) NULL
      --, [YEAR FIRST APPEARED IN YP]       VARCHAR(255) NULL
      --, [BUS CREDIT SCORE CODE]           VARCHAR(255) NULL
      --, [BUSINESS CREDIT SCORE CODE]      VARCHAR(255) NULL
      --, [BUSINESS CREDIT SCORE (ACTUAL)]  VARCHAR(255) NULL
      --, [WORK AT HOME INDICATOR]          VARCHAR(255) NULL
      --, [OWN-LEASE CODE]                  VARCHAR(255) NULL
      --, [SQUARE FOOTAGE CODE]             VARCHAR(255) NULL
      --, [WEB ADDRESS - URL]               VARCHAR(255) NULL
      --, [COLLATERAL TYPE]                 VARCHAR(255) NULL
      --, [COLLATERAL TYPE DESC]            VARCHAR(255) NULL
      --, [CORP OR IND]                     VARCHAR(255) NULL
      --, [DAY ADDED TO UCC DB]             VARCHAR(255) NULL
      --, [MONTH ADDED TO UCC DB]           VARCHAR(255) NULL
      --, [YEAR ADDED TO UCC DB]            VARCHAR(255) NULL
      --, [RECEIVED DAY]                    VARCHAR(255) NULL
      --, [RECEIVED MONTH]                  VARCHAR(255) NULL
      --, [RECEIVED YEAR]                   VARCHAR(255) NULL
      --, [DELIVERABILITY SCORE]            VARCHAR(255) NULL
      --, [DELIVERY POINT BARCODE]          VARCHAR(255) NULL
      --, [EXP DAY]                         VARCHAR(255) NULL
      --, [EXP MONTH]                       VARCHAR(255) NULL
      --, [EXP YEAR]                        VARCHAR(255) NULL
      --, [FILING DAY]                      VARCHAR(255) NULL
      --, [FILING MONTH]                    VARCHAR(255) NULL
      --, [FILING YEAR]                     VARCHAR(255) NULL
      --, [FILING STATE]                    VARCHAR(255) NULL
      --, [FILING STATUS]                   VARCHAR(255) NULL
      --, [FILING STATUS DESC]              VARCHAR(255) NULL
      --, [FILING TYPE CODE]                VARCHAR(255) NULL
      --, [FILING TYPE DESC]                VARCHAR(255) NULL
      --, [ORIGINAL FILING ID]              VARCHAR(255) NULL
      --, [PARTY TYPE CODE]                 VARCHAR(255) NULL
      --, [SOURCE FILING ID]                VARCHAR(255) NULL
      --, [SEC PARTY NAME]                  VARCHAR(255) NULL
      --, [SECURED PARTY ADDRESS]           VARCHAR(255) NULL
      --, [SECURED PARTY CITY]              VARCHAR(255) NULL
      --, [SEC PARTY STATE]                 VARCHAR(255) NULL
      --, [SECURED PARTY ZIP]               VARCHAR(255) NULL
      --, [SECURED PARTY ZIP4]              VARCHAR(255) NULL
      --, [match code]                      VARCHAR(255) NULL
      --, [Fulfillment Flag]                VARCHAR(255) NULL
      --, [Key Code 1]                      VARCHAR(255) NULL
      --, InfoId                            BIGINT NULL
      --, startDate                         [DATE] NULL
      --, endDate                         [DATE] NULL




