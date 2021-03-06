/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   AdventureWorks_0006.config.ListSegmentation
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
           WHERE object_id = OBJECT_ID(N'config.ListSegmentation')
                 AND type IN (N'U'))
    DROP TABLE 
      config.ListSegmentation
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'config.ListSegmentation')
                     AND type IN (N'U'))
  BEGIN
    CREATE TABLE
      config.ListSegmentation
        (
            ListSegmentationID    SMALLINT NOT NULL
                                  IDENTITY(1,1)
          , MailingOrgID          TINYINT       NOT NULL
                                  CONSTRAINT
                                    FK_config_ListSegmentation_MailingOrg
                                  FOREIGN KEY REFERENCES
                                    dbo.MailingOrg(MailingOrgID)
                                  ON DELETE CASCADE
          , EmployeeSizeSegmentID SMALLINT      NOT NULL
          , BusinessAgeSegmentID  SMALLINT      NOT NULL 
          , GeoRegionID           TINYINT       NOT NULL
                                  CONSTRAINT
                                    FK_config_ListSegmentation_GeoRegionID
                                  FOREIGN KEY REFERENCES
                                    ref.GeoRegion(GeoRegionID)
                                  ON DELETE CASCADE
          --, SegmentsID           VARCHAR(255) NULL
          --, Segments             VARCHAR(255) NULL

          , HasPaydex             TINYINT       NOT NULL
          , RecordCnt             INT           NULL
          , ResponseRate          NUMERIC(9,4)  NULL
          , LeadToFundPct         NUMERIC(9,4)  NULL
          , MailablePopRecordCnt  INT           NULL
          , ThisMonthRecordCnt    INT           NULL
          --, ValidFrom             DATETIME2     NOT NULL
          --                        CONSTRAINT
          --                          DF_config_ListSegmentation_ValidFrom
          --                        DEFAULT
          --                          GETDATE()
          --, ValidTo               DATETIME2     NULL
          --, IsCurrent             AS CAST(CASE WHEN ValidTo IS NULL AND ValidFrom < GETDATE() THEN 1 ELSE 0 END AS BIT)
          , CONSTRAINT
              UN_config_ListSegmentation_BisKey
            UNIQUE
              (
                  MailingOrgID          ASC
                , EmployeeSizeSegmentID ASC
                , BusinessAgeSegmentID  ASC
                , GeoRegionID           ASC
                , HasPaydex             DESC
                --, ValidFrom             DESC
              )

          , CONSTRAINT
              PK_config_ListSegmentation_ListSegmentationID
            PRIMARY KEY CLUSTERED
              (
                  MailingOrgID
                , ListSegmentationID
              )
          --, CONSTRAINT 
          --    CHK_config_ListSegmentation_ValidDateRange_Expire
          --  CHECK 
          --    (
          --          ValidTo IS NULL
          --      OR  ValidTo > ValidFrom
          --    )
          , CONSTRAINT
              FK_config_ListSegmentation_EmployeeSizeSegment
            FOREIGN KEY 
              (
                  MailingOrgID
                , EmployeeSizeSegmentID
              )
            REFERENCES
              config.EmployeeSizeSegment
                (
                    MailingOrgID
                  , EmployeeSizeSegmentID
                )
            ON DELETE CASCADE
          , CONSTRAINT
              FK_config_ListSegmentation_BusinessAgeSegment
            FOREIGN KEY 
              (
                  MailingOrgID
                , BusinessAgeSegmentID
              )
            REFERENCES
              config.BusinessAgeSegment
                (
                    MailingOrgID
                  , BusinessAgeSegmentID
                )
            ON DELETE CASCADE
        )
  END
GO
/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ Populate From Old Table                                                                     │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤

    INSERT
      config.ListSegmentation
        (
            Segments
          , IsPrevLicensed
          , YearSegment
          , RegionName
          , HasPaydex
          , SIC_Division
          , EmpSegment
          , RecordCnt
          , ResponseRate
          , LeadToFundPct
          , MailablePopRecordCnt
          , ThisMonthRecordCnt
        
        )
    SELECT
        [Segments]
      , [NL_PL]
      , [Year_segment]
      , [Region]
      , [Has_Paydex_Flag]
      , [SIC_Division]
      , [Empl_Segment]
      , [Number_of_Records]
      , [Response_Rate]
      , [LTF_perc]
      , [AdventureWorks_0007_Mailable_Population]
      , [AdventureWorks_0007_Current_Month_Count]
    FROM
      [AdventureWorks_0002].[OM].[list_segmentation_n1]


















    SELECT
        [Segments]
    FROM
      [AdventureWorks_0002].[OM].[list_segmentation_n1]


    SELECT DISTINCT
        [Segments]
    FROM
      [AdventureWorks_0002].[OM].[list_segmentation_n1]

      DECLARE 
      @RegExPatt NVARCHAR(MAX)  = '|'
    , @RegExOpts INT            = AdventureWorks_0002.dbo.RegExOptionEnumeration (
                                                                  1 -- Ignore Case
                                                                , 0 -- Multiline
                                                                , 0 -- Explicit Capture
                                                                , 0 -- Single Line
                                                                , 0 -- Ignore Pattern Whitespace
                                                                , 0 -- Right-to-Left
                                                                , 0 -- ECMAScript
                                                                , 0 -- Culture Invariant
                                                              )

SELECT
    ls1.[Segments]
    , rm.[Match]
FROM
  [AdventureWorks_0002].[OM].[list_segmentation_n1] ls1
  CROSS APPLY
  AdventureWorks_0002.dbo.RegexMatches(ls1.[Segments],@RegExPatt,@RegExOpts) rm




    SELECT TOP 1000
        [Segments]
      , [NL_PL]
      , [Year_segment]
      , [Region]
      , [Has_Paydex_Flag]
      , [SIC_Division]
      , [Empl_Segment]
      , [Number_of_Records]
      , [Response_Rate]
      , [LTF_perc]
      , [AdventureWorks_0007_Mailable_Population]
      , [AdventureWorks_0007_Current_Month_Count]
    FROM
      [AdventureWorks_0002].[OM].[list_segmentation_n1]





    SELECT TOP 1000
        [Segments]
      , Test = LTRIM(STR([Empl_Segment])) + ' ' + LTRIM(STR([Has_Paydex_Flag])) + ' ' + [Region]
      , [NL_PL]
      , [Year_segment]
      , [Region]
      , [Has_Paydex_Flag]
      , [SIC_Division]
      , [Empl_Segment]
      , [Number_of_Records]
      , [Response_Rate]
      , [LTF_perc]
      , [AdventureWorks_0007_Mailable_Population]
      , [AdventureWorks_0007_Current_Month_Count]
    FROM
      [AdventureWorks_0002].[OM].[list_segmentation_n1]



    SELECT DISTINCT
        [Segments]
      , Test = LTRIM(STR([Empl_Segment])) + ' ' + LTRIM(STR([Has_Paydex_Flag])) + ' ' + [Region]
      , Test = LTRIM(STR([Empl_Segment])) + ' ' + LTRIM(STR([Has_Paydex_Flag])) + ' ' + [Region]
      , Test2 = REPLACE([Segments], LTRIM(STR([Empl_Segment])) + ' ' + LTRIM(STR([Has_Paydex_Flag])) + ' ' + [Region], '')
      , Test3 = REPLACE(REPLACE([Segments], LTRIM(STR([Empl_Segment])) + ' ' + LTRIM(STR([Has_Paydex_Flag])) + ' ' + [Region], ''), 'Unk 1 1 North', 'Unk')
      , NL_PL
    FROM
      [AdventureWorks_0002].[OM].[list_segmentation_n1]
    WHERE 
      [Segments] = 'Unk 1 1 North'






    SELECT DISTINCT
        Segment = RTRIM(REPLACE(REPLACE([Segments], LTRIM(STR([Empl_Segment])) + ' ' + LTRIM(STR([Has_Paydex_Flag])) + ' ' + [Region], ''), 'Unk 1 1 North', 'Unk'))
    FROM
      [AdventureWorks_0002].[OM].[list_segmentation_n1]
    WHERE
      RTRIM(REPLACE(REPLACE([Segments], LTRIM(STR([Empl_Segment])) + ' ' + LTRIM(STR([Has_Paydex_Flag])) + ' ' + [Region], ''), 'Unk 1 1 North', 'Unk'))
      NOT IN('Other','Unk')



SELECT * 
FROM [AdventureWorks_0002].[OM].[list_segmentation_n1]
WHERE [Segments] = 'Unk 1 1 North'
ORDER BY 6,5

ORDER BY 5,7,6


\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/








