/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   AdventureWorks_0006.ref.SIC_MajorGroup
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
           WHERE object_id = OBJECT_ID(N'ref.SIC_MajorGroup')
                 AND type IN (N'U'))
    DROP TABLE 
      ref.SIC_MajorGroup
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'ref.SIC_MajorGroup')
                     AND type IN (N'U'))
  BEGIN
    CREATE TABLE
      ref.SIC_MajorGroup
        (
            Division        CHAR(1)       NOT NULL
                            CONSTRAINT
                              FK_ref_SIC_MajorGroup_Division
                            FOREIGN KEY REFERENCES
                              ref.SIC_Division(Division)
          , MajorGroup      TINYINT       NOT NULL
                            CONSTRAINT 
                              PK_ref_SIC_MajorGroup
                            PRIMARY KEY CLUSTERED

          , MajorGroupDesc  NVARCHAR(128) NOT NULL
                            CONSTRAINT 
                              UK_ref_SIC_MajorGroup_MajorGroupDesc
                            UNIQUE
        )
  END
GO

/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ BULK LOAD CSV (only works with v 2k17)                                                      │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤

    BULK INSERT
      ref.SIC_MajorGroup
    FROM
      '\\SDW-BITOOLS-P01\FlatFileExtractImport\ReferenceData\sic4-list\major-groups.csv'
    WITH 
      ( 
          FIELDTERMINATOR = ','
        , ROWTERMINATOR   = '\n'
        , FIRSTROW        = 2
        , FIELDQUOTE      = '"'
      )

    SELECT * FROM ref.SIC_MajorGroup

  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ Load from manual import temp table I set up                                                 │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
    INSERT
      ref.SIC_MajorGroup
        (
            Division
          , MajorGroup
          , MajorGroupDesc
        )
    SELECT
        Division
      , MajorGroup
      , Description
    FROM
      dbo.SIC_MajorGroups

  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ Load special values                                                                         │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤

    INSERT
      ref.SIC_MajorGroup
        (
            Division
          , MajorGroup
          , MajorGroupDesc
        )
    VALUES
        ('*', 0 , 'ALL')
      , ('?', 254, 'UNKNOWN')
      , ('#', 253, 'OTHER')
      , ('!', 252, 'NONE')

\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/






