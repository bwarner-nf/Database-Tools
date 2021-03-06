/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Stored Procedure DDL                                                                 │
  │   AdventureWorks_0006.stage.usp_Stage_MenuUniverse
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
      
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ────────────────────────────────────────────────────────────── │
      2018.10.08 bwarner         Initial Draft
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ UNIT TESTING SCRIPTS:                                                                       │

      EXEC stage.usp_Stage_MenuUniverse 

\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE AdventureWorks_0006
GO

IF EXISTS 
  (
    SELECT 
      * 
    FROM 
      sys.objects 
    WHERE 
          [object_id] = OBJECT_ID(N'stage.usp_Stage_MenuUniverse') 
      AND [type] IN(N'P', N'PC')
  )
	DROP PROCEDURE 
    stage.usp_Stage_MenuUniverse
GO

CREATE PROCEDURE 
  stage.usp_Stage_MenuUniverse
AS
BEGIN

  IF EXISTS (SELECT *
             FROM sys.indexes
             WHERE object_id = OBJECT_ID(N'stage.MenuUniverse')
                   AND name = N'idx_stage_MenuUniverse_DUNS')
    DROP INDEX 
      idx_stage_MenuUniverse_DUNS
    ON 
      stage.MenuUniverse

  IF EXISTS (SELECT *
             FROM sys.indexes
             WHERE object_id = OBJECT_ID(N'stage.MenuUniverse')
                   AND name = N'idx_stage_MenuUniverse_PriSIC')
    DROP INDEX 
      idx_stage_MenuUniverse_PriSIC
    ON 
      stage.MenuUniverse

  TRUNCATE TABLE
    stage.MenuUniverse

  INSERT
    stage.MenuUniverse
      (
          DUNS
        , BusName
        , City
        , US_State
        , MSA
        , Zip
        , EmpTotal
        , SalesVol
        , YearStarted
        , MajorIndustryCat
        , PaydexRangeCode
        , LegalStatus
        , OwnsRentsCode
        , IsClass2
        , PriSIC
        , MarketabilityInd
        , ConfidenceCode
        , HL_New2World
        , HL_NewLegalEntity
        , HL_New2File
        , HL_OwnershipChng
        , HL_CEO_Chng
        , HL_CoNameChng
        , HL_AddChng
        , HL_PhoneChng
        , AccountId
        , LeadId
        , RecencyUDate
        , RecencyUCCDate_O
        , CottageIndustryInd
        , CommCreditScrPerctlRangeCode
        , LoanPropSgmtCode
        , LeasePropSgmtCode
        , LineCreditSgmtCode
        , CreditSgmtCode
        , TotBalSgmtCode
        , LeaseBalSgmtCode
        , TPA_FundScore
        , TPA_RespScore    
        , PhysicalStreetAddressLine1
        , PhysicalStreetAddressLine2
        , PhysicalCity
        , PhysicalStateAbbreviation
        , PhysicalZipUS
        , MailStreetAddressLine1
        , MailStreetAddressLine2
        , MailCity
        , MailState
        , MailZip
        , Telephone
        , CEO_Prefix
        , CEO_FirstName
        , CEO_MiddleInitial
        , CEO_LastName
        , CEO_FullName
        , CEO_Suffix
        , CEOTitle
        , CEO_MRC_Code
        , IsCEO_NameAvailable
      )
      SELECT
          DUNS
        , BusName
        , City
        , US_State
        , MSA
        , Zip
        , EmpTotal
        , SalesVol
        , YearStarted
        , MajorIndustryCat
        , PaydexRangeCode
        , LegalStatus
        , OwnsRentsCode
        , IsClass2
        , PriSIC
        , MarketabilityInd
        , ConfidenceCode
        , HL_New2World
        , HL_NewLegalEntity
        , HL_New2File
        , HL_OwnershipChng
        , HL_CEO_Chng
        , HL_CoNameChng
        , HL_AddChng
        , HL_PhoneChng
        , AccountId
        , LeadId
        , RecencyUDate
        , RecencyUCCDate_O
        , CottageIndustryInd
        , CommCreditScrPerctlRangeCode
        , LoanPropSgmtCode
        , LeasePropSgmtCode
        , LineCreditSgmtCode
        , CreditSgmtCode
        , TotBalSgmtCode
        , LeaseBalSgmtCode
        , TPA_FundScore
        , TPA_RespScore
        , PhysicalStreetAddressLine1
        , PhysicalStreetAddressLine2
        , PhysicalCity
        , PhysicalStateAbbreviation
        , PhysicalZipUS
        , MailStreetAddressLine1
        , MailStreetAddressLine2
        , MailCity
        , MailState
        , MailZip
        , Telephone
        , CEO_Prefix
        , CEO_FirstName
        , CEO_MiddleInitial
        , CEO_LastName
        , CEO_FullName
        , CEO_Suffix
        , CEOTitle
        , CEO_MRC_Code
        , IsCEO_NameAvailable
      FROM
        (
          SELECT
              brs.DUNS
            , brs.BusName
            , brs.City
            , brs.US_State
            , brs.MSA
            , brs.Zip
            , brs.EmpTotal
            , brs.SalesVol
            , brs.YearStarted
            , brs.MajorIndustryCat
            , brs.PaydexRangeCode
            , brs.LegalStatus
            , brs.OwnsRentsCode
            , brs.IsClass2
            , brs.PriSIC
            , brs.MarketabilityInd
            , brs.ConfidenceCode
            , brs.HL_New2World
            , brs.HL_NewLegalEntity
            , brs.HL_New2File
            , brs.HL_OwnershipChng
            , brs.HL_CEO_Chng
            , brs.HL_CoNameChng
            , brs.HL_AddChng
            , brs.HL_PhoneChng
            , brs.AccountId
            , brs.LeadId
            , brs.RecencyUDate
            , brs.RecencyUCCDate_O
            , brs.CottageIndustryInd
            , brs.CommCreditScrPerctlRangeCode
            , brs.LoanPropSgmtCode
            , brs.LeasePropSgmtCode
            , brs.LineCreditSgmtCode
            , brs.CreditSgmtCode
            , brs.TotBalSgmtCode
            , brs.LeaseBalSgmtCode
            , brs.TPA_FundScore
            , brs.TPA_RespScore
            , ln.PhysicalStreetAddressLine1
            , ln.PhysicalStreetAddressLine2
            , ln.PhysicalCity
            , ln.PhysicalStateAbbreviation
            , ln.PhysicalZipUS
            , ln.MailStreetAddressLine1
            , ln.MailStreetAddressLine2
            , ln.MailCity
            , ln.MailState
            , ln.MailZip
            , ln.Telephone
            , ln.CEO_Prefix
            , ln.CEO_FirstName
            , ln.CEO_MiddleInitial
            , ln.CEO_LastName
            , ln.CEO_FullName
            , ln.CEO_Suffix
            , ln.CEOTitle
            , ln.CEO_MRC_Code
            , IsCEO_NameAvailable             = CASE 
                                                  WHEN ncn.DUNS IS NULL 
                                                    THEN CAST(1 AS BIT) 
                                                  ELSE CAST(0 AS BIT) 
                                                END
            , rn                              = ROW_NUMBER()   OVER
                                                  (
                                                    PARTITION BY 
                                                      ln.DUNS 
                                                    ORDER BY 
                                                        brs.AccountId ASC
                                                      , brs.LeadId ASC
                                                  )
          FROM
            imp.MenuUniverseExtract_01_AdventureWorks_0007_BaseRecordSet brs
            LEFT JOIN
            imp.MenuUniverseExtract_02_AdventureWorks_0007_LicensedRecords ln
              on brs.DUNS = ln.DUNS
            LEFT JOIN
            imp.MenuUniverseExtract_03_AdventureWorks_0007_NoCEO_NameRecords ncn
              ON ncn.DUNS = brs.DUNS
        ) x
      WHERE
        rn = 1


  IF NOT EXISTS (SELECT *
                 FROM sys.indexes
                 WHERE object_id = OBJECT_ID(N'stage.MenuUniverse')
                       AND name = N'idx_stage_MenuUniverse_DUNS')
    CREATE UNIQUE NONCLUSTERED INDEX 
      idx_stage_MenuUniverse_DUNS
    ON 
      stage.MenuUniverse
        (
            DUNS DESC
          --, IsRowCurrent DESC
        ) 
    WITH 
      (
          PAD_INDEX               = OFF
        , STATISTICS_NORECOMPUTE  = OFF
        , SORT_IN_TEMPDB          = OFF
        , IGNORE_DUP_KEY          = OFF
        , DROP_EXISTING           = OFF
        , ONLINE                  = OFF
        , ALLOW_ROW_LOCKS         = ON
        , ALLOW_PAGE_LOCKS        = ON
      )
  IF NOT EXISTS (SELECT *
                 FROM sys.indexes
                 WHERE object_id = OBJECT_ID(N'stage.MenuUniverse')
                       AND name = N'idx_stage_MenuUniverse_PriSIC')
    CREATE NONCLUSTERED INDEX 
      idx_stage_MenuUniverse_PriSIC
    ON 
      stage.MenuUniverse
        (
            PriSIC
        ) 
    WITH 
      (
          PAD_INDEX               = OFF
        , STATISTICS_NORECOMPUTE  = OFF
        , SORT_IN_TEMPDB          = OFF
        , IGNORE_DUP_KEY          = OFF
        , DROP_EXISTING           = OFF
        , ONLINE                  = OFF
        , ALLOW_ROW_LOCKS         = ON
        , ALLOW_PAGE_LOCKS        = ON
      )



END
GO



  --INSERT
  --  stage.MI_MenuUniverse
  --    (
  --        DUNS
  --      , BusName
  --      , City
  --      , US_State
  --      , MSA
  --      , Zip
  --      , EmpTotal
  --      , SalesVol
  --      , YearStarted
  --      , MajorIndustryCat
  --      , PaydexRangeCode
  --      , LegalStatus
  --      , OwnsRentsCode
  --      , IsClass2
  --      , PriSIC
  --      , MarketabilityInd
  --      , ConfidenceCode
  --      , HL_New2World
  --      , HL_NewLegalEntity
  --      , HL_New2File
  --      , HL_OwnershipChng
  --      , HL_CEO_Chng
  --      , HL_CoNameChng
  --      , HL_AddChng
  --      , HL_PhoneChng
  --      , AccountId
  --      , LeadId
  --      , RecencyUDate
  --      , RecencyUCCDate_O
  --      , CottageIndustryInd
  --      , CommCreditScrPerctlRangeCode
  --      , LoanPropSgmtCode
  --      , LeasePropSgmtCode
  --      , LineCreditSgmtCode
  --      , CreditSgmtCode
  --      , TotBalSgmtCode
  --      , LeaseBalSgmtCode
  --      , TPA_FundScore
  --      , TPA_RespScore    
  --      , PhysicalStreetAddressLine1
  --      , PhysicalStreetAddressLine2
  --      , PhysicalCity
  --      , PhysicalStateAbbreviation
  --      , PhysicalZipUS
  --      , MailStreetAddressLine1
  --      , MailStreetAddressLine2
  --      , MailCity
  --      , MailState
  --      , MailZip
  --      , Telephone
  --      , CEO_Prefix
  --      , CEO_FirstName
  --      , CEO_MiddleInitial
  --      , CEO_LastName
  --      , CEO_FullName
  --      , CEO_Suffix
  --      , CEOTitle
  --      , CEO_MRC_Code
  --    )
  --  SELECT
  --      DUNS
  --    , BusName
  --    , City
  --    , US_State
  --    , MSA
  --    , Zip
  --    , EmpTotal
  --    , SalesVol
  --    , YearStarted
  --    , MajorIndustryCat
  --    , PaydexRangeCode
  --    , LegalStatus
  --    , OwnsRentsCode
  --    , IsClass2
  --    , PriSIC
  --    , MarketabilityInd
  --    , ConfidenceCode
  --    , HL_New2World
  --    , HL_NewLegalEntity
  --    , HL_New2File
  --    , HL_OwnershipChng
  --    , HL_CEO_Chng
  --    , HL_CoNameChng
  --    , HL_AddChng
  --    , HL_PhoneChng
  --    , AccountId
  --    , LeadId
  --    , RecencyUDate
  --    , RecencyUCCDate_O
  --    , CottageIndustryInd
  --    , CommCreditScrPerctlRangeCode
  --    , LoanPropSgmtCode
  --    , LeasePropSgmtCode
  --    , LineCreditSgmtCode
  --    , CreditSgmtCode
  --    , TotBalSgmtCode
  --    , LeaseBalSgmtCode
  --    , TPA_FundScore
  --    , TPA_RespScore
  --    , PhysicalStreetAddressLine1
  --    , PhysicalStreetAddressLine2
  --    , PhysicalCity
  --    , PhysicalStateAbbreviation
  --    , PhysicalZipUS
  --    , MailStreetAddressLine1
  --    , MailStreetAddressLine2
  --    , MailCity
  --    , MailState
  --    , MailZip
  --    , Telephone
  --    , CEO_Prefix
  --    , CEO_FirstName
  --    , CEO_MiddleInitial
  --    , CEO_LastName
  --    , CEO_FullName
  --    , CEO_Suffix
  --    , CEOTitle
  --    , CEO_MRC_Code
  --  FROM
  --    (
  --      MERGE 
  --        stage.MI_MenuUniverse dst
  --      USING 
  --        (
  --          SELECT
  --              DUNS
  --            , BusName
  --            , City
  --            , US_State
  --            , MSA
  --            , Zip
  --            , EmpTotal
  --            , SalesVol
  --            , YearStarted
  --            , MajorIndustryCat
  --            , PaydexRangeCode
  --            , LegalStatus
  --            , OwnsRentsCode
  --            , IsClass2
  --            , PriSIC
  --            , MarketabilityInd
  --            , ConfidenceCode
  --            , HL_New2World
  --            , HL_NewLegalEntity
  --            , HL_New2File
  --            , HL_OwnershipChng
  --            , HL_CEO_Chng
  --            , HL_CoNameChng
  --            , HL_AddChng
  --            , HL_PhoneChng
  --            , AccountId
  --            , LeadId
  --            , RecencyUDate
  --            , RecencyUCCDate_O
  --            , CottageIndustryInd
  --            , CommCreditScrPerctlRangeCode
  --            , LoanPropSgmtCode
  --            , LeasePropSgmtCode
  --            , LineCreditSgmtCode
  --            , CreditSgmtCode
  --            , TotBalSgmtCode
  --            , LeaseBalSgmtCode
  --            , TPA_FundScore
  --            , TPA_RespScore
  --            , PhysicalStreetAddressLine1
  --            , PhysicalStreetAddressLine2
  --            , PhysicalCity
  --            , PhysicalStateAbbreviation
  --            , PhysicalZipUS
  --            , MailStreetAddressLine1
  --            , MailStreetAddressLine2
  --            , MailCity
  --            , MailState
  --            , MailZip
  --            , Telephone
  --            , CEO_Prefix
  --            , CEO_FirstName
  --            , CEO_MiddleInitial
  --            , CEO_LastName
  --            , CEO_FullName
  --            , CEO_Suffix
  --            , CEOTitle
  --            , CEO_MRC_Code
  --          FROM
  --            (
  --              SELECT
  --                  brs.DUNS
  --                , brs.BusName
  --                , brs.City
  --                , brs.US_State
  --                , brs.MSA
  --                , brs.Zip
  --                , brs.EmpTotal
  --                , brs.SalesVol
  --                , brs.YearStarted
  --                , brs.MajorIndustryCat
  --                , brs.PaydexRangeCode
  --                , brs.LegalStatus
  --                , brs.OwnsRentsCode
  --                , brs.IsClass2
  --                , brs.PriSIC
  --                , brs.MarketabilityInd
  --                , brs.ConfidenceCode
  --                , brs.HL_New2World
  --                , brs.HL_NewLegalEntity
  --                , brs.HL_New2File
  --                , brs.HL_OwnershipChng
  --                , brs.HL_CEO_Chng
  --                , brs.HL_CoNameChng
  --                , brs.HL_AddChng
  --                , brs.HL_PhoneChng
  --                , brs.AccountId
  --                , brs.LeadId
  --                , brs.RecencyUDate
  --                , brs.RecencyUCCDate_O
  --                , brs.CottageIndustryInd
  --                , brs.CommCreditScrPerctlRangeCode
  --                , brs.LoanPropSgmtCode
  --                , brs.LeasePropSgmtCode
  --                , brs.LineCreditSgmtCode
  --                , brs.CreditSgmtCode
  --                , brs.TotBalSgmtCode
  --                , brs.LeaseBalSgmtCode
  --                , brs.TPA_FundScore
  --                , brs.TPA_RespScore
  --                , ln.PhysicalStreetAddressLine1
  --                , ln.PhysicalStreetAddressLine2
  --                , ln.PhysicalCity
  --                , ln.PhysicalStateAbbreviation
  --                , ln.PhysicalZipUS
  --                , ln.MailStreetAddressLine1
  --                , ln.MailStreetAddressLine2
  --                , ln.MailCity
  --                , ln.MailState
  --                , ln.MailZip
  --                , ln.Telephone
  --                , ln.CEO_Prefix
  --                , ln.CEO_FirstName
  --                , ln.CEO_MiddleInitial
  --                , ln.CEO_LastName
  --                , ln.CEO_FullName
  --                , ln.CEO_Suffix
  --                , ln.CEOTitle
  --                , ln.CEO_MRC_Code
  --                , rn                        = ROW_NUMBER()   OVER
  --                                                              (
  --                                                                PARTITION BY 
  --                                                                  brs.DUNS 
  --                                                                ORDER BY 
  --                                                                    brs.AccountId ASC
  --                                                                  , brs.LeadId ASC
  --                                                              )
  --              FROM
  --                imp.MI_MenuUniverse brs
  --                LEFT JOIN
  --                imp.MI_LicensedNames ln
  --                  on brs.DUNS = ln.DUNS
  --            ) x
  --          WHERE
  --            rn = 1
  --        ) src
  --      ON 
  --        src.DUNS = dst.DUNS
  --        AND dst.IsRowCurrent = 1
  --      WHEN 
  --        MATCHED 
  --        AND
  --          (
  --                 src.BusName                      <> dst.BusName
  --              OR src.City                         <> dst.City
  --              OR src.US_State                     <> dst.US_State
  --              OR src.MSA                          <> dst.MSA
  --              OR src.Zip                          <> dst.Zip
  --              OR src.EmpTotal                     <> dst.EmpTotal
  --              OR src.SalesVol                     <> dst.SalesVol
  --              OR src.YearStarted                  <> dst.YearStarted
  --              OR src.MajorIndustryCat             <> dst.MajorIndustryCat
  --              OR src.PaydexRangeCode              <> dst.PaydexRangeCode
  --              OR src.LegalStatus                  <> dst.LegalStatus
  --              OR src.OwnsRentsCode                <> dst.OwnsRentsCode
  --              OR src.IsClass2                     <> dst.IsClass2
  --              OR src.PriSIC                       <> dst.PriSIC
  --              OR src.MarketabilityInd             <> dst.MarketabilityInd
  --              OR src.ConfidenceCode               <> dst.ConfidenceCode
  --              OR src.HL_New2World                 <> dst.HL_New2World
  --              OR src.HL_NewLegalEntity            <> dst.HL_NewLegalEntity
  --              OR src.HL_New2File                  <> dst.HL_New2File
  --              OR src.HL_OwnershipChng             <> dst.HL_OwnershipChng
  --              OR src.HL_CEO_Chng                  <> dst.HL_CEO_Chng
  --              OR src.HL_CoNameChng                <> dst.HL_CoNameChng
  --              OR src.HL_AddChng                   <> dst.HL_AddChng
  --              OR src.HL_PhoneChng                 <> dst.HL_PhoneChng
  --              OR src.AccountId                    <> dst.AccountId
  --              --OR src.LeadId                       <> dst.LeadId
  --              --OR src.RecencyUDate                 <> dst.RecencyUDate
  --              --OR src.RecencyUCCDate_O             <> dst.RecencyUCCDate_O
  --              OR src.CottageIndustryInd           <> dst.CottageIndustryInd
  --              OR src.CommCreditScrPerctlRangeCode <> dst.CommCreditScrPerctlRangeCode
  --              OR src.LoanPropSgmtCode             <> dst.LoanPropSgmtCode
  --              OR src.LeasePropSgmtCode            <> dst.LeasePropSgmtCode
  --              OR src.LineCreditSgmtCode           <> dst.LineCreditSgmtCode
  --              OR src.CreditSgmtCode               <> dst.CreditSgmtCode
  --              OR src.TotBalSgmtCode               <> dst.TotBalSgmtCode
  --              OR src.LeaseBalSgmtCode             <> dst.LeaseBalSgmtCode
  --              OR src.TPA_FundScore                <> dst.TPA_FundScore
  --              OR src.TPA_RespScore                <> dst.TPA_RespScore
  --              OR src.PhysicalStreetAddressLine1   <> dst.PhysicalStreetAddressLine1
  --              OR src.PhysicalStreetAddressLine2   <> dst.PhysicalStreetAddressLine2
  --              OR src.PhysicalCity                 <> dst.PhysicalCity
  --              OR src.PhysicalStateAbbreviation    <> dst.PhysicalStateAbbreviation
  --              OR src.PhysicalZipUS                <> dst.PhysicalZipUS
  --              OR src.MailStreetAddressLine1       <> dst.MailStreetAddressLine1
  --              OR src.MailStreetAddressLine2       <> dst.MailStreetAddressLine2
  --              OR src.MailCity                     <> dst.MailCity
  --              OR src.MailState                    <> dst.MailState
  --              OR src.MailZip                      <> dst.MailZip
  --              OR src.Telephone                    <> dst.Telephone
  --              OR src.CEO_Prefix                   <> dst.CEO_Prefix
  --              OR src.CEO_FirstName                <> dst.CEO_FirstName
  --              OR src.CEO_MiddleInitial            <> dst.CEO_MiddleInitial
  --              OR src.CEO_LastName                 <> dst.CEO_LastName
  --              OR src.CEO_FullName                 <> dst.CEO_FullName
  --              OR src.CEO_Suffix                   <> dst.CEO_Suffix
  --              OR src.CEOTitle                     <> dst.CEOTitle
  --              OR src.CEO_MRC_Code                 <> dst.CEO_MRC_Code
  --            )
  --      THEN UPDATE SET
  --          ValidTo       = GETDATE()
  --        , IsRowCurrent  = 0

  --      WHEN NOT MATCHED BY TARGET THEN 
  --        INSERT 
  --          (
  --              DUNS
  --            , BusName
  --            , City
  --            , US_State
  --            , MSA
  --            , Zip
  --            , EmpTotal
  --            , SalesVol
  --            , YearStarted
  --            , MajorIndustryCat
  --            , PaydexRangeCode
  --            , LegalStatus
  --            , OwnsRentsCode
  --            , IsClass2
  --            , PriSIC
  --            , MarketabilityInd
  --            , ConfidenceCode
  --            , HL_New2World
  --            , HL_NewLegalEntity
  --            , HL_New2File
  --            , HL_OwnershipChng
  --            , HL_CEO_Chng
  --            , HL_CoNameChng
  --            , HL_AddChng
  --            , HL_PhoneChng
  --            , AccountId
  --            , LeadId
  --            , RecencyUDate
  --            , RecencyUCCDate_O
  --            , CottageIndustryInd
  --            , CommCreditScrPerctlRangeCode
  --            , LoanPropSgmtCode
  --            , LeasePropSgmtCode
  --            , LineCreditSgmtCode
  --            , CreditSgmtCode
  --            , TotBalSgmtCode
  --            , LeaseBalSgmtCode
  --            , TPA_FundScore
  --            , TPA_RespScore    
  --            , PhysicalStreetAddressLine1
  --            , PhysicalStreetAddressLine2
  --            , PhysicalCity
  --            , PhysicalStateAbbreviation
  --            , PhysicalZipUS
  --            , MailStreetAddressLine1
  --            , MailStreetAddressLine2
  --            , MailCity
  --            , MailState
  --            , MailZip
  --            , Telephone
  --            , CEO_Prefix
  --            , CEO_FirstName
  --            , CEO_MiddleInitial
  --            , CEO_LastName
  --            , CEO_FullName
  --            , CEO_Suffix
  --            , CEOTitle
  --            , CEO_MRC_Code
  --          )
  --        VALUES
  --          (
  --              src.DUNS
  --            , src.BusName
  --            , src.City
  --            , src.US_State
  --            , src.MSA
  --            , src.Zip
  --            , src.EmpTotal
  --            , src.SalesVol
  --            , src.YearStarted
  --            , src.MajorIndustryCat
  --            , src.PaydexRangeCode
  --            , src.LegalStatus
  --            , src.OwnsRentsCode
  --            , src.IsClass2
  --            , src.PriSIC
  --            , src.MarketabilityInd
  --            , src.ConfidenceCode
  --            , src.HL_New2World
  --            , src.HL_NewLegalEntity
  --            , src.HL_New2File
  --            , src.HL_OwnershipChng
  --            , src.HL_CEO_Chng
  --            , src.HL_CoNameChng
  --            , src.HL_AddChng
  --            , src.HL_PhoneChng
  --            , src.AccountId
  --            , src.LeadId
  --            , src.RecencyUDate
  --            , src.RecencyUCCDate_O
  --            , src.CottageIndustryInd
  --            , src.CommCreditScrPerctlRangeCode
  --            , src.LoanPropSgmtCode
  --            , src.LeasePropSgmtCode
  --            , src.LineCreditSgmtCode
  --            , src.CreditSgmtCode
  --            , src.TotBalSgmtCode
  --            , src.LeaseBalSgmtCode
  --            , src.TPA_FundScore
  --            , src.TPA_RespScore    
  --            , src.PhysicalStreetAddressLine1
  --            , src.PhysicalStreetAddressLine2
  --            , src.PhysicalCity
  --            , src.PhysicalStateAbbreviation
  --            , src.PhysicalZipUS
  --            , src.MailStreetAddressLine1
  --            , src.MailStreetAddressLine2
  --            , src.MailCity
  --            , src.MailState
  --            , src.MailZip
  --            , src.Telephone
  --            , src.CEO_Prefix
  --            , src.CEO_FirstName
  --            , src.CEO_MiddleInitial
  --            , src.CEO_LastName
  --            , src.CEO_FullName
  --            , src.CEO_Suffix
  --            , src.CEOTitle
  --            , src.CEO_MRC_Code
  --          )

  --      WHEN NOT MATCHED BY SOURCE AND dst.IsRowCurrent = 1 
  --        THEN UPDATE SET
  --            ValidTo       = GETDATE()
  --          , IsRowCurrent  = 0
  --          , IsDeleted     = 1
  --      OUTPUT 
  --          $action MergeAction
  --        , src.*
  --    ) MergeOutput
  --WHERE
  --      MergeOutput.MergeAction = 'UPDATE'
  --  AND DUNS IS NOT NULL




