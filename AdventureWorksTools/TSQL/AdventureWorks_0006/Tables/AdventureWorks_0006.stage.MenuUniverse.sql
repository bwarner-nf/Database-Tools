/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   AdventureWorks_0006.stage.MenuUniverse
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
           WHERE object_id = OBJECT_ID(N'stage.MenuUniverse')
                 AND type IN (N'U'))
    DROP TABLE 
      stage.MenuUniverse
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'stage.MenuUniverse')
                     AND type IN (N'U'))
  BEGIN
    CREATE TABLE
      stage.MenuUniverse
        (
            --RowVerSurrogateID               BIGINT        NOT NULL
            --                                              IDENTITY(-9223372036854775808,1)
            --                                              CONSTRAINT
            --                                                PK_stage_MenuUniverseExtract_01_AdventureWorks_0007_BaseRecordSet
            --                                              PRIMARY KEY CLUSTERED
            DUNS                            INT           NOT NULL  -- siDunsNb
                                                          CONSTRAINT
                                                            PK_stage_MenuUniverseExtract_01_AdventureWorks_0007_BaseRecordSet
                                                          PRIMARY KEY CLUSTERED
          , IsLicensed                      BIT           NULL      -- Status
          , BusName                         VARCHAR(90)   NULL      -- siBusNme
          , City                            VARCHAR(50)   NULL      -- siCity
          , US_State                        VARCHAR(36)   NULL      -- siState1
          , MSA                             SMALLINT      NULL      -- siFipsMS
          , Zip                             VARCHAR(16)   NULL      -- siPhyZip
          , EmpTotal                        INT           NULL      -- siEmpTot
          , SalesVol                        BIGINT        NULL      -- siSlsVUS
          , YearStarted                     DATE          NULL      -- siYearSt
          , MajorIndustryCat                TINYINT       NULL      -- siMajor
          , LocationType                    TINYINT       NULL      -- siLocTyp
          , PaydexRangeCode                 TINYINT       NULL      -- FiPaydex
          , LegalStatus                     TINYINT       NULL      -- siLegal
          , OwnsRentsCode                   TINYINT       NULL      -- siOwnRnt
          , IsClass2                        BIT           NULL      -- siClass39
          , PriSIC                          INT           NULL      -- siPriSIC
          , MarketabilityInd                CHAR(1)       NULL      -- siMarket
          , ConfidenceCode                  TINYINT       NULL      -- CuConfCd
          , HL_New2World                    BIT           NULL      -- saHLNTW
                                            CONSTRAINT
                                              DF_stage_MenuUniverseExtract_01_AdventureWorks_0007_BaseRecordSet_HL_New2World
                                            DEFAULT
                                              CAST(0 AS BIT)
          , HL_NewLegalEntity               BIT           NULL      -- saHLNLE
                                            CONSTRAINT
                                              DF_stage_MenuUniverseExtract_01_AdventureWorks_0007_BaseRecordSet_HL_NewLegalEntity
                                            DEFAULT
                                              CAST(0 AS BIT)
          , HL_New2File                     BIT           NULL      -- saHLNTF
                                            CONSTRAINT
                                              DF_stage_MenuUniverseExtract_01_AdventureWorks_0007_BaseRecordSet_HL_New2File
                                            DEFAULT
                                              CAST(0 AS BIT)
          , HL_OwnershipChng                BIT           NULL      -- saHLOC
                                            CONSTRAINT
                                              DF_stage_MenuUniverseExtract_01_AdventureWorks_0007_BaseRecordSet_HL_OwnershipChng
                                            DEFAULT
                                              CAST(0 AS BIT)
          , HL_CEO_Chng                     BIT           NULL      -- saHLCEO
                                            CONSTRAINT
                                              DF_stage_MenuUniverseExtract_01_AdventureWorks_0007_BaseRecordSet_HL_CEO_Chng
                                            DEFAULT
                                              CAST(0 AS BIT)
          , HL_CoNameChng                   BIT           NULL      -- saHLNC
                                            CONSTRAINT
                                              DF_stage_MenuUniverseExtract_01_AdventureWorks_0007_BaseRecordSet_HL_CoNameChng
                                            DEFAULT
                                              CAST(0 AS BIT)
          , HL_AddChng                      BIT           NULL      -- saHLAC
                                            CONSTRAINT
                                              DF_stage_MenuUniverseExtract_01_AdventureWorks_0007_BaseRecordSet_HL_AddChng
                                            DEFAULT
                                              CAST(0 AS BIT)
          , HL_PhoneChng                    BIT           NULL      -- saHLPC
                                            CONSTRAINT
                                              DF_stage_MenuUniverseExtract_01_AdventureWorks_0007_BaseRecordSet_HL_PhoneChng
                                            DEFAULT
                                              CAST(0 AS BIT)

          , IsHotListMember                 AS 
                                            CASE 
                                              WHEN HL_New2World = 1
                                                THEN CAST(1 AS BIT)
                                              WHEN HL_NewLegalEntity = 1 
                                                THEN CAST(1 AS BIT)
                                              WHEN HL_New2File = 1 
                                                THEN CAST(1 AS BIT)
                                              WHEN HL_OwnershipChng = 1 
                                                THEN CAST(1 AS BIT)
                                              WHEN HL_CEO_Chng = 1 
                                                THEN CAST(1 AS BIT)
                                              WHEN HL_CoNameChng = 1 
                                                THEN CAST(1 AS BIT)
                                              WHEN HL_AddChng = 1 
                                                THEN CAST(1 AS BIT)
                                              WHEN HL_PhoneChng = 1 
                                                THEN CAST(1 AS BIT)
                                              ELSE CAST(0 AS BIT)
                                            END 
                                            PERSISTED


          , AccountId                       NCHAR(18)     NULL      -- CuAcctId
          , LeadId                          NCHAR(18)     NULL      -- CuLeadid

          , RecencyUDate                    DATE          NULL      -- siRecenc
          , RecencyUCCDate_O                DATE          NULL      -- siRece66
          , CottageIndustryInd              BIT           NULL      -- saCottag
          , CommCreditScrPerctlRangeCode    TINYINT       NULL      -- FiCommCr
          , LoanPropSgmtCode                TINYINT       NULL      -- FiLoanPr
          , LeasePropSgmtCode               TINYINT       NULL      -- FiLeaseP
          , LineCreditSgmtCode              TINYINT       NULL      -- FiLineCr
          , CreditSgmtCode                  TINYINT       NULL      -- FiCredit
          , TotBalSgmtCode                  TINYINT       NULL      -- FiTotBal
          , LeaseBalSgmtCode                TINYINT       NULL      -- FiLeaseB
          , TPA_FundScore                   TINYINT       NULL      -- FiCustFu
          , TPA_RespScore                   TINYINT       NULL      -- FiCustRe

          , MC_ScoreDate                    DATE          NULL      -- siVX6UNG
          , MC_EmployeeSalesSegment         TINYINT       NULL      -- siVX6SYM
          , MC_BorrowingSegment             TINYINT       NULL      -- siVX6T3W
          , MC_SpendSegment                 TINYINT       NULL      -- siVX6T9T
          , MC_OpportunityFinalSegment      CHAR(1)       NULL      -- siVX6TTD
          , MC_CompositeRisk                TINYINT       NULL      -- siVX6U38
          , MC_RiskSegment                  VARCHAR(2)    NULL      -- siVX6U80
          , MC_TP_Segments                  VARCHAR(32)   NULL      -- siVX6UHG

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
          , CEO_FirstName                   NVARCHAR(15)  NULL      -- siCEOFNm
          , CEO_MiddleInitial               NVARCHAR(1)   NULL      -- siCEOMIn
          , CEO_LastName                    NVARCHAR(15)  NULL      -- siCEOLNm
          , CEO_FullName                    NVARCHAR(60)  NULL      -- siCEONm
          , CEO_Suffix                      VARCHAR(3)    NULL      -- siCEOSuf
          , CEOTitle                        VARCHAR(51)   NULL      -- siCEOTtl
          , CEO_MRC_Code                    VARCHAR(512)  NULL      -- siCEOMRC

          , IsCEO_NameAvailable             BIT           NOT NULL
                                            CONSTRAINT
                                              DF_stage_MenuUniverseExtract_01_AdventureWorks_0007_BaseRecordSet_IsCEO_NameAvailable
                                            DEFAULT
                                              CAST(1 AS BIT)

          --, IsRowCurrent                    BIT           NOT NULL
          --                                  CONSTRAINT
          --                                    DF_stage_MenuUniverseExtract_01_AdventureWorks_0007_BaseRecordSet_IsRowCurrent
          --                                  DEFAULT
          --                                    CAST(1 AS BIT)
          --, IsDeleted                       BIT           NOT NULL
          --                                  CONSTRAINT
          --                                    DF_stage_MenuUniverseExtract_01_AdventureWorks_0007_BaseRecordSet_IsDeleted
          --                                  DEFAULT
          --                                    CAST(0 AS BIT)

          --, AsOfRunID                       INT           NOT NULL

          --, ValidFrom                       DATETIME      NOT NULL
          --                                  CONSTRAINT
          --                                    DF_stage_MenuUniverseExtract_01_AdventureWorks_0007_BaseRecordSet_ValidFrom
          --                                  DEFAULT
          --                                    GETDATE()
          --, ValidTo                         DATETIME      NOT NULL
          --                                  CONSTRAINT
          --                                    DF_stage_MenuUniverseExtract_01_AdventureWorks_0007_BaseRecordSet_ValidTo
          --                                  DEFAULT
          --                                    CAST('9999-12-31' AS DATETIME)


        )
  END
GO

/*

(DT_BOOL)( == "Y" ? 1 : 0)


SELECT
    MarketabilityInd
  , RecordCnt = COUNT(*)
FROM
  stage.MenuUniverse mu
WHERE
  HL_New2File = 1
GROUP BY
  MarketabilityInd



SELECT *
INTO stage.MenuUniverse_bak_20181218
FROM stage.MenuUniverse

*/







