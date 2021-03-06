/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   AdventureWorks_0006.imp.MenuUniverseExtract_01_AdventureWorks_0007_BaseRecordSet
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
           WHERE object_id = OBJECT_ID(N'imp.MenuUniverseExtract_01_AdventureWorks_0007_BaseRecordSet')
                 AND type IN (N'U'))
    DROP TABLE 
      imp.MenuUniverseExtract_01_AdventureWorks_0007_BaseRecordSet
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'imp.MenuUniverseExtract_01_AdventureWorks_0007_BaseRecordSet')
                     AND type IN (N'U'))
  BEGIN
    CREATE TABLE
      imp.MenuUniverseExtract_01_AdventureWorks_0007_BaseRecordSet
        (
            DUNS                            INT           NOT NULL  -- siDunsNb
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
          , HL_NewLegalEntity               BIT           NULL      -- saHLNLE
          , HL_New2File                     BIT           NULL      -- saHLNTF
          , HL_OwnershipChng                BIT           NULL      -- saHLOC
          , HL_CEO_Chng                     BIT           NULL      -- saHLCEO
          , HL_CoNameChng                   BIT           NULL      -- saHLNC
          , HL_AddChng                      BIT           NULL      -- saHLAC
          , HL_PhoneChng                    BIT           NULL      -- saHLPC

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
/*
siFipsMS
*/
        )
  END
GO




