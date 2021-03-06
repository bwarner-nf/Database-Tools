/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   AdventureWorks_0006.ref.SIC_Division
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
           WHERE object_id = OBJECT_ID(N'ref.SIC_Division')
                 AND type IN (N'U'))
    DROP TABLE 
      ref.SIC_Division
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'ref.SIC_Division')
                     AND type IN (N'U'))
  BEGIN
    CREATE TABLE
      ref.SIC_Division
        (
            Division          CHAR(1) NOT NULL
                              CONSTRAINT 
                                PK_ref_SIC_Division
                              PRIMARY KEY CLUSTERED
          , DivisionDesc      NVARCHAR(100) NOT NULL
                              CONSTRAINT 
                                UK_ref_SIC_Division_DivisionDesc
                              UNIQUE
          , DivisionFullDesc  NVARCHAR(MAX) NOT NULL
        )
  END
GO

/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ BULK LOAD CSV (only works with v 2k17)                                                      │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤

    BULK INSERT
      ref.SIC_Division
    FROM
      '\\SDW-BITOOLS-P01\FlatFileExtractImport\ReferenceData\sic4-list\divisions.csv'
    WITH 
      ( 
          FIELDTERMINATOR = ','
        , ROWTERMINATOR   = '\n'
        , FIRSTROW        = 2
        , FIELDQUOTE = '"'
      )

    SELECT * FROM ref.SIC_Division

  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ Load from manual import temp table I set up                                                 │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤

    INSERT
      ref.SIC_Division
        (
            Division
          , DivisionDesc
          , DivisionFullDesc
        )
    SELECT
        Division
      , Description
      , Full_Description
    FROM
      dbo.SIC_Divisions

  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ Load special values                                                                         │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤

    INSERT
      ref.SIC_Division
        (
            Division
          , DivisionDesc
          , DivisionFullDesc
        )
    VALUES
        ('*', 'ALL', 'SPECIAL_DIVISION: Represent All SIC Divisions')
      , ('?', 'UNKNOWN', 'SPECIAL_DIVISION: Represents SIC Division that is not known or unavaiable')
      , ('#', 'OTHER', 'SPECIAL_DIVISION: Represents a SIC Division outside of existing divisions')
      , ('!', 'NONE', 'SPECIAL_DIVISION: Represents no SIC Divisions')

\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/







