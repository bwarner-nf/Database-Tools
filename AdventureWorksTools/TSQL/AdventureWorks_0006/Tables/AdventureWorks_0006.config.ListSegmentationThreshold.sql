/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   AdventureWorks_0006.config.ListSegmentationThreshold
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
  │                                                                                             │
  │                                                                                             │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ───────────────────────────────────────────────────────────────┤
      2018.12.19 bwarner          Initial Draft
\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE AdventureWorks_0006
GO

IF EXISTS (SELECT *
           FROM sys.objects
           WHERE object_id = OBJECT_ID(N'config.ListSegmentationThreshold')
                 AND type IN (N'U'))
    DROP TABLE 
      config.ListSegmentationThreshold
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'config.ListSegmentationThreshold')
                     AND type IN (N'U'))
  BEGIN
    CREATE TABLE
      config.ListSegmentationThreshold
        (
            ListSegmentationThresholdID TINYINT NOT NULL
                                        IDENTITY(1,1)
                                        CONSTRAINT
                                          PK_config_ListSegmentationThreshold
                                        PRIMARY KEY CLUSTERED
          , MailingOrgID                TINYINT       NOT NULL
                                        CONSTRAINT
                                          FK_config_ListSegmentationThreshold_MailingOrg
                                        FOREIGN KEY REFERENCES
                                          dbo.MailingOrg(MailingOrgID)
                                        ON DELETE CASCADE
          , SIC_Division                CHAR(1)      NOT NULL
                                        CONSTRAINT
                                          FK_config_ListSegmentationThreshold_SIC_Division
                                        FOREIGN KEY REFERENCES
                                          ref.SIC_Division(Division)
                                        ON DELETE CASCADE
          , IsPrevLicensed              BIT          NOT NULL
          , ValidFrom                   DATETIME2      NOT NULL
                                        CONSTRAINT
                                          DF_config_ListSegmentationThreshold_ValidFrom
                                        DEFAULT
                                          GETDATE()
          , ValidTo                     DATETIME2       NULL
          , IsCurrent                   AS CAST(CASE WHEN ValidTo IS NULL AND ValidFrom < GETDATE() THEN 1 ELSE 0 END AS BIT)
          , LeadToFundPct               NUMERIC(9,4) NOT NULL
          , ResponseRatePctMedian       NUMERIC(9,4) NOT NULL
          , ResponseRatePct1            NUMERIC(9,4) NOT NULL
          , ResponseRatePct2            NUMERIC(9,4) NOT NULL
          , CONSTRAINT
              UN_config_ListSegmentationThreshold_BisKey
            UNIQUE
              (
                  MailingOrgID    ASC
                , SIC_Division    ASC
                , IsPrevLicensed  DESC
                , ValidFrom       DESC
              )
          , CONSTRAINT 
              CHK_config_ListSegmentationThreshold_ValidDateRange_Expire
            CHECK 
              (
                    ValidTo IS NULL
                OR  ValidTo > ValidFrom
              )
        )
  END

GO



/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ Populate From Old Table                                                                     │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤

    DECLARE 
        @MailingOrgID TINYINT
      , @TheBeginningOfDATETIME2  DATETIME2 = '0001-01-01 00:00:00'
      , @TheEndOfDATETIME2        DATETIME2 = '9999-12-31 23:59:59.9999999'

    SELECT
      @MailingOrgID = MailingOrgID
    FROM
      dbo.MailingOrg
    WHERE
      MailingOrgName = 'National Funding'

    INSERT
      config.ListSegmentationThreshold
        (
            MailingOrgID
          , SIC_Division
          , IsPrevLicensed
          , ValidFrom
          , LeadToFundPct
          , ResponseRatePctMedian
          , ResponseRatePct1
          , ResponseRatePct2
        )
    SELECT
        MailOrgID             = @MailingOrgID
      , SIC_Division          = sd.Division
      , IsPrevLicensed        = CASE [NL_PL] WHEN 'PL' THEN 1 ELSE 0 END
      , ValidFrom             = @TheBeginningOfDATETIME2
      , LeadToFundPct         = [LTF_perc]
      , ResponseRatePctMedian = [Median_RR_perc]
      , ResponseRatePct1      = [RR_1_perc]
      , ResponseRatePct2      = [RR_2_perc]
    FROM
      [AdventureWorks_0002].[OM].[list_segmentation_n1_thresholds] old
      LEFT JOIN
      ref.SIC_Division sd
        ON REPLACE
            (
                REPLACE
                  (
                      old.SIC_Division
                    , 'Agri, Forestry, and Fishing'
                    , 'Agriculture, Forestry, And Fishing'
                  )
              , 'Transportation, Comms, Electric, Gas, & Sanitary'
              , 'Transportation, Communications, Electric, Gas, And Sanitary Services'
            ) = sd.DivisionDesc



  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ Dev Scratch:                                                                                │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤

    SELECT
        [SIC_Division]
      , [NL_PL]
      , [LTF_perc]
      , [RR_1_perc]
      , [RR_2_perc]
      , [Median_RR_perc]
    FROM
      [AdventureWorks_0002].[OM].[list_segmentation_n1_thresholds]



   SELECT * FROM config.ListSegmentationThreshold 

    SELECT DISTINCT
        [SIC_Division]
    FROM
      [AdventureWorks_0002].[OM].[list_segmentation_n1_thresholds] old
      LEFT JOIN
      ref.SIC_Division sd
        ON old.SIC_Division = sd.DivisionDesc
    WHERE
      sd.Division IS NULL

    SELECT * FROM ref.SIC_Division

    SELECT
        [SIC_Division]   = MAX(LEN([SIC_Division]))
      , [NL_PL]          = MAX(LEN([NL_PL]))
      , [LTF_perc]       = MAX(LEN([LTF_perc]))
      , [RR_1_perc]      = MAX(LEN([RR_1_perc]))
      , [RR_2_perc]      = MAX(LEN([RR_2_perc]))
      , [Median_RR_perc] = MAX(LEN([Median_RR_perc]))
    FROM
      [AdventureWorks_0002].[OM].[list_segmentation_n1_thresholds]

    SIC_Division	NL_PL	LTF_perc	RR_1_perc	RR_2_perc	Median_RR_perc
    48	2	6	6	6	6


   SELECT 
      mo.MailingOrgName 
    , SIC_Division = sd.DivisionDesc
    , lst.IsPrevLicensed
    , IsCurrent
    , lst.ValidFrom
    , lst.ValidTo
    , lst.LeadToFundPct
    , lst.ResponseRatePctMedian
    , lst.ResponseRatePct1
    , lst.ResponseRatePct2
   FROM 
    config.ListSegmentationThreshold lst
    JOIN
    dbo.MailingOrg mo
      ON lst.MailingOrgID = mo.MailingOrgID
    JOIN
    ref.SIC_Division sd
      ON lst.SIC_Division = sd.Division


\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/









