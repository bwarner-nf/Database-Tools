/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   AdventureWorks_0006.dbo.DataFeed
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
  │                                                                                             │
  │                                                                                             │


    SELECT 
        mo.MailingOrgName
      , dp.DataProviderCode
      , dp.DataProviderName
      , df.*
    FROM 
      dbo.DataFeed df
      JOIN
      dbo.DataProvider dp
        ON df.DataProviderID = dp.DataProviderID
      JOIN
      dbo.MailingOrg mo
        ON mo.MailingOrgID = df.MailingOrgID

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
           WHERE object_id = OBJECT_ID(N'dbo.DataFeed')
                 AND type IN (N'U'))
    DROP TABLE 
      dbo.DataFeed
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'dbo.DataFeed')
                     AND type IN (N'U'))
  BEGIN
    CREATE TABLE
      dbo.DataFeed
        (
            DataFeedID        BIGINT        NOT NULL
                              IDENTITY(1,1)
                              CONSTRAINT 
                                PK_dbo_DataFeed
                              PRIMARY KEY CLUSTERED
          , MailingOrgID      TINYINT       NOT NULL
                              CONSTRAINT
                                FK_dbo_DataFeed_MailingOrg
                              FOREIGN KEY REFERENCES
                                dbo.MailingOrg(MailingOrgID)

          , DataProviderID    TINYINT     NOT NULL
                              CONSTRAINT
                                FK_DataFeed_DataProvider
                              FOREIGN KEY REFERENCES
                                dbo.DataProvider(DataProviderID)
          , DataFeedName      VARCHAR(128)   NOT NULL
          , DataFeedDesc      VARCHAR(512)   NULL
          , FileNameingConv   NVARCHAR(255)  NULL
          , FormatDesc        VARCHAR(128)   NULL
          , DeliveryMechanism VARCHAR(128)   NULL
          , DeliverySchedule  VARCHAR(128)   NULL
          , IsInbound         BIT            NOT NULL
                              CONSTRAINT
                                DF_dbo_DataFeed_IsInbound
                              DEFAULT
                                (1)
          , ValidFrom         DATETIME2      NOT NULL
                              CONSTRAINT
                                DF_dbo_DataFeed_ValidFrom
                              DEFAULT
                                GETDATE()
          , ValidTo           DATETIME2      NULL
          , IsCurrent         AS CAST(CASE WHEN ValidTo IS NULL AND ValidFrom < GETDATE() THEN 1 ELSE 0 END AS BIT)

          , CreatedDate       DATETIME     NOT NULL
                              CONSTRAINT
                                DF_DataFeed_CreatedDate
                              DEFAULT 
                                GETDATE()
          , CreatedBy         SYSNAME      NOT NULL
                              CONSTRAINT
                                DF_DataFeed_CreatedBy
                              DEFAULT 
                                SUSER_NAME()
          , ModifiedDate      DATETIME     NOT NULL
                              CONSTRAINT
                                DF_DataFeed_ModifiedDate
                              DEFAULT 
                                GETDATE()
          , ModifiedBy        SYSNAME      NOT NULL
                              CONSTRAINT
                                DF_DataFeed_ModifiedBy
                              DEFAULT 
                                SUSER_NAME()
          , CONSTRAINT
              UN_dbo_DataFeed_BisKey
            UNIQUE
              (
                  MailingOrgID  ASC
                , DataFeedName  ASC
                , ValidFrom     DESC
              )
          , CONSTRAINT 
              CHK_dbo_DataFeed_ValidDateRange_Expire
            CHECK 
              (
                    ValidTo IS NULL
                OR  ValidTo > ValidFrom
              )
        )
  END
GO






/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ Populate Initial Data Set                                                                   │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤

    DECLARE 
        @MailingOrgID TINYINT
      , @DataProviderID    TINYINT 

    SELECT
      @MailingOrgID = MailingOrgID
    FROM
      dbo.MailingOrg
    WHERE
      MailingOrgName = 'National Funding'

    SELECT
      @DataProviderID = DataProviderID
    FROM
      dbo.DataProvider
    WHERE
      DataProviderName = 'Dun & Bradstreet'

    INSERT
      dbo.DataFeed
        (
            MailingOrgID
          , DataProviderID
          , DataFeedName
          , DataFeedDesc
          , FileNameingConv
          , FormatDesc
          , DeliveryMechanism
          , DeliverySchedule
        )
    VALUES
        (
            @MailingOrgID
          , @DataProviderID
          , 'Base Record Set'
          , 'Base set of markeing prospects from D&B'
          , 'MenueUniverseExtract_DnB_01_BaseRecordSet.txt'
          , 'Flat File; Tab-Delimited; No string quotes; Header Row Included'
          , 'Market Insight Data Grid Flat  File Export'
          , 'Monthly Usual after the 8th or 9th'
        )
      , (
            @MailingOrgID
          , @DataProviderID
          , 'Licensed Records: Pre Menue selection'
          , 'Special extract for currently licensed records from D&B that occurs prior to prospect list selection'
          , 'MenueUniverseExtract_DnB_02_LicensedNames.txt'
          , 'Flat File; Tab-Delimited; No string quotes; Header Row Included'
          , 'Market Insight Data Grid Flat  File Export'
          , 'Monthly Usual after the 8th or 9th'
        )

    SELECT
      @DataProviderID = DataProviderID
    FROM
      dbo.DataProvider
    WHERE
      DataProviderName = 'InfoGroup'

    INSERT
      dbo.DataFeed
        (
            MailingOrgID
          , DataProviderID
          , DataFeedName
          , DataFeedDesc
          , FileNameingConv
          , FormatDesc
          , DeliveryMechanism
          , DeliverySchedule
        )
    VALUES
        (
            @MailingOrgID
          , @DataProviderID
          , '24 Month Matched'
          , 'List of UCC Filings (Unified Commercial Code-1) that have been matched to InfoGroup''s Database in the past 24 months'
          , 'MenuUniverseExtract_04_IFG_24Month_Matched.txt'
          , 'Flat File; Tab-Delimited; No string quotes; Header Row Included'
          , 'Links to download file via internet browser sent in email'
          , 'Monthly, usually durring the second week of the month'
        )
      , (
            @MailingOrgID
          , @DataProviderID
          , '36 Month Matched'
          , 'List of UCC Filings (Unified Commercial Code-1) that have been matched to InfoGroup''s Database in the past 36 months (excluding lower month lookback lists for this month)'
          , 'MenuUniverseExtract_06_IFG_36Month_Matched.txt'
          , 'Flat File; Tab-Delimited; No string quotes; Header Row Included'
          , 'Links to download file via internet browser sent in email'
          , 'Monthly, usually durring the second week of the month'
        )
      , (
            @MailingOrgID
          , @DataProviderID
          , '48 Month Matched'
          , 'List of UCC Filings (Unified Commercial Code-1) that have been matched to InfoGroup''s Database in the past 48 months (excluding lower month lookback lists for this month)'
          , 'MenuUniverseExtract_08_IFG_48Month_Matched.txt'
          , 'Flat File; Tab-Delimited; No string quotes; Header Row Included'
          , 'Links to download file via internet browser sent in email'
          , 'Monthly, usually durring the second week of the month'
        )
      , (
            @MailingOrgID
          , @DataProviderID
          , '60 Month Matched'
          , 'List of UCC Filings (Unified Commercial Code-1) that have been matched to InfoGroup''s Database in the past 60 months (excluding lower month lookback lists for this month)'
          , 'MenuUniverseExtract_10_IFG_60Month_Matched.txt'
          , 'Flat File; Tab-Delimited; No string quotes; Header Row Included'
          , 'Links to download file via internet browser sent in email'
          , 'Monthly, usually durring the second week of the month'
        )


      , (
            @MailingOrgID
          , @DataProviderID
          , '24 Month Unmatched'
          , 'List of UCC Filings (Unified Commercial Code-1) that could not be matched to InfoGroup''s Database in the past 24 months (excluding lower month lookback lists for this month)'
          , 'MenuUniverseExtract_05_IFG_24Month_Unmatched.txt'
          , 'Flat File; Comma-Delimited; No string quotes; Header Row Included'
          , 'Links to download file via internet browser sent in email'
          , 'Monthly, usually durring the second week of the month'
        )
      , (
            @MailingOrgID
          , @DataProviderID
          , '36 Month Unmatched'
          , 'List of UCC Filings (Unified Commercial Code-1) that could not be matched to InfoGroup''s Database in the past 36 months (excluding lower month lookback lists for this month)'
          , 'MenuUniverseExtract_07_IFG_36Month_Unmatched.txt'
          , 'Flat File; Comma-Delimited; No string quotes; Header Row Included'
          , 'Links to download file via internet browser sent in email'
          , 'Monthly, usually durring the second week of the month'
        )
      , (
            @MailingOrgID
          , @DataProviderID
          , '48 Month Unmatched'
          , 'List of UCC Filings (Unified Commercial Code-1) that could not be matched to InfoGroup''s Database in the past 48 months (excluding lower month lookback lists for this month)'
          , 'MenuUniverseExtract_09_IFG_48Month_Unmatched.txt'
          , 'Flat File; Comma-Delimited; No string quotes; Header Row Included'
          , 'Links to download file via internet browser sent in email'
          , 'Monthly, usually durring the second week of the month'
        )
      , (
            @MailingOrgID
          , @DataProviderID
          , '60 Month Unmatched'
          , 'List of UCC Filings (Unified Commercial Code-1) that could not be matched to InfoGroup''s Database in the past 60 months (excluding lower month lookback lists for this month)'
          , 'MenuUniverseExtract_11_IFG_60Month_Unmatched.txt'
          , 'Flat File; Comma-Delimited; No string quotes; Header Row Included'
          , 'Links to download file via internet browser sent in email'
          , 'Monthly, usually durring the second week of the month'
        )


    SELECT
      @DataProviderID = DataProviderID
    FROM
      dbo.DataProvider
    WHERE
      DataProviderName = 'Lattice'

    INSERT
      dbo.DataFeed
        (
            MailingOrgID
          , DataProviderID
          , DataFeedName
          , DataFeedDesc
          , FileNameingConv
          , FormatDesc
          , DeliveryMechanism
          , DeliverySchedule
        )
    VALUES
        (
            @MailingOrgID
          , @DataProviderID
          , 'Scored Lattice 2nd Look Candidants'
          , 'List of prospects scoped for a second look and subbmitted to Lattice for scoring'
          , 'TBD'
          , 'Flat File; <TBD> Comma-Delimited; string quotes; Header Row Included'
          , '<TBD> FTP'
          , 'Monthly; Ad-Hoc (data processing manual step)'
        )

    SELECT
      @DataProviderID = DataProviderID
    FROM
      dbo.DataProvider
    WHERE
      DataProviderName = 'National Change of Address'

    INSERT
      dbo.DataFeed
        (
            MailingOrgID
          , DataProviderID
          , DataFeedName
          , DataFeedDesc
          , FileNameingConv
          , FormatDesc
          , DeliveryMechanism
          , DeliverySchedule
        )
    VALUES
        (
            @MailingOrgID
          , @DataProviderID
          , 'Scrubbed Mail Addresses'
          , 'Data scrubbing service from http://www.nationalchangeofaddress.com/'
          , ''
          , ''
          , 'FTP pickup on E1DD''s FTP site'
          , 'Monthly; Ad-Hoc (data processing manual step)'
        )


    SELECT
      @DataProviderID = DataProviderID
    FROM
      dbo.DataProvider
    WHERE
      DataProviderName = 'National Funding'

    INSERT
      dbo.DataFeed
        (
            MailingOrgID
          , DataProviderID
          , DataFeedName
          , DataFeedDesc
          , FileNameingConv
          , FormatDesc
          , DeliveryMechanism
          , DeliverySchedule
          , IsInbound
        )
    VALUES
        (
            @MailingOrgID
          , @DataProviderID
          , 'Lattice 2nd Look Candidants'
          , 'List of prospects scoped for a second look to be subbmitted to Lattice for scoring'
          , 'TBD'
          , 'Flat File; <TBD> Comma-Delimited; string quotes; Header Row Included'
          , '<TBD> FTP?'
          , 'Monthly; Ad-Hoc (data processing manual step)'
          , 0
        )

      , (
            @MailingOrgID
          , @DataProviderID
          , 'Mail Addresses to Be Scrubbed'
          , 'Outbound mail addresses for data scrubbing service from http://www.nationalchangeofaddress.com/'
          , 'AcqMail_BeforeNCOA_<Date>.txt'
          , 'Flat File; Tab-Delimited; string quotes; Header Row Included'
          , 'FTP to E1DD'
          , 'Monthly; Ad-Hoc (data processing manual step)'
          , 0
        )

      , (
            @MailingOrgID
          , @DataProviderID
          , 'D&B License '
          , 'Outbound file that is submitted to Dun & Bradstreet to license the new set of records marketing has selected for a particular mail campaign'
          , 'AcqMail_BeforeNCOA_<Date>.txt'
          , 'Flat File; Proprietary *.URN for D&B record licensing'
          , 'FTP to E1DD'
          , 'Monthly; Ad-Hoc (data processing manual step)'
          , 0
        )


  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ Populate Data Scratch                                                                       │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤

    SELECT
      @DataProviderID = DataProviderID
    FROM
      dbo.DataProvider
    WHERE
      DataProviderName = 'Salesforce'



    INSERT
      dbo.DataFeed
        (
            MailingOrgID
          , DataProviderID
          , DataFeedName
          , DataFeedDesc
          , FileNameingConv
          , FormatDesc
          , DeliveryMechanism
          , DeliverySchedule
        )
    VALUES
        (
            @MailingOrgID
          , @DataProviderID
          , ''
          , ''
          , ''
          , ''
          , ''
          , ''
        )

    SET IDENTITY_INSERT dbo.DataFeed ON

    SELECT
      @MailingOrgID = MailingOrgID
    FROM
      dbo.MailingOrg
    WHERE
      MailingOrgName = 'National Funding'


    INSERT
      dbo.DataFeed
        (
            MailingOrgID
          , DataFeedName
          , ValidFrom
          , DataFeedID
          , FileNameingConv
          , FormatDesc
          , DeliveryMechanism
          , DeliverySchedule
        )
    VALUES
        (
            @MailingOrgID
          , 'Other'
          , @TheBeginningOfDATETIME2
          , -2
          , ''
          , ''
          , ''
          , ''
        )

    SET IDENTITY_INSERT dbo.DataFeed OFF






  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ Dev Scratch                                                                                 │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤



    SELECT
      '      DataProviderName = ''' + DataProviderName + ''''
    FROM
      dbo.DataProvider


\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/





    SELECT 
        mo.MailingOrgName
      , dp.DataProviderCode
      , dp.DataProviderName
      , df.DataFeedName
      , df.DataFeedDesc
      , df.DeliveryMechanism
      , df.DeliverySchedule
      , df.IsCurrent
      , df.ValidFrom
      , df.ValidTo

    FROM 
      dbo.DataFeed df
      JOIN
      dbo.DataProvider dp
        ON df.DataProviderID = dp.DataProviderID
      JOIN
      dbo.MailingOrg mo
        ON mo.MailingOrgID = df.MailingOrgID




