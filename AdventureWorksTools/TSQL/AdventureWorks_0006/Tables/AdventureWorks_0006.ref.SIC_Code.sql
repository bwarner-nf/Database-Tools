/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   AdventureWorks_0006.ref.SIC_Code
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
  │                                                                                             │
  │                                                                                             │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ───────────────────────────────────────────────────────────────┤
      2018.12.19 bwarner         Initial Draft
\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE AdventureWorks_0006
GO

IF EXISTS (SELECT *
           FROM sys.objects
           WHERE object_id = OBJECT_ID(N'ref.SIC_Code')
                 AND type IN (N'U'))
    DROP TABLE 
      ref.SIC_Code
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'ref.SIC_Code')
                     AND type IN (N'U'))
  BEGIN
    CREATE TABLE
      ref.SIC_Code
        (
            Division      CHAR(1) NOT NULL
                          CONSTRAINT
                            FK_ref_SIC_Code_Division
                          FOREIGN KEY REFERENCES
                            ref.SIC_Division(Division)
          , MajorGroup    TINYINT NOT NULL
                          CONSTRAINT
                            FK_ref_SIC_Code_MajorGroup
                          FOREIGN KEY REFERENCES
                            ref.SIC_MajorGroup(MajorGroup)
          , IndustryGroup SMALLINT NOT NULL
                          CONSTRAINT
                            FK_ref_SIC_Code_IndustryGroup
                          FOREIGN KEY REFERENCES
                            ref.SIC_IndustryGroup(IndustryGroup)
          , SIC           SMALLINT NOT NULL
                          CONSTRAINT 
                            PK_ref_SIC_Code
                          PRIMARY KEY CLUSTERED
          , SIC_Desc      NVARCHAR(128) NOT NULL
        )
  END
GO

/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ BULK LOAD CSV (only works with v 2k17)                                                      │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤

    BULK INSERT
      ref.SIC_Code
    FROM
      '\\SDW-BITOOLS-P01\FlatFileExtractImport\ReferenceData\sic4-list\sic-codes.csv'
    WITH 
      ( 
          FIELDTERMINATOR = ','
        , ROWTERMINATOR   = '\n'
        , FIRSTROW        = 2
        , FIELDQUOTE      = '"'
      )

    SELECT * FROM ref.SIC_Code

  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ Load from manual import temp table I set up                                                 │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤


    SELECT * FROM dbo.SIC_Codes WHERE Description = 'Ophthalmic Goods'

    INSERT
      ref.SIC_Code
        (
            Division
          , MajorGroup
          , IndustryGroup
          , SIC
          , SIC_Desc
        )
    SELECT
        Division
      , MajorGroup
      , IndustryGroup
      , SIC
      , Description
    FROM
      dbo.SIC_Codes

  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ Load special values                                                                         │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤

    INSERT
      ref.SIC_Code
        (
            Division
          , MajorGroup
          , IndustryGroup
          , SIC
          , SIC_Desc
        )
    VALUES
        ('*',   0,  0,  0, 'ALL')
      , ('?',  , -1, -1, 'UNKNOWN')
      , ('#', 253, -2, -2, 'OTHER')
      , ('!', 252, -3, -3, 'NONE')

\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/





