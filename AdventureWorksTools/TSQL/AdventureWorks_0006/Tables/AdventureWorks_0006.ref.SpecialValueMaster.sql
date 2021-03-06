/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   AdventureWorks_0006.ref.SpecialValueMaster
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
  │                                                                                             │
  │                                                                                             │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ───────────────────────────────────────────────────────────────┤
      2018.12.31 bwarner         Initial Draft
\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE AdventureWorks_0006
GO

IF EXISTS (SELECT *
           FROM sys.objects
           WHERE object_id = OBJECT_ID(N'ref.SpecialValueMaster')
                 AND type IN (N'U'))
    DROP TABLE 
      ref.SpecialValueMaster
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'ref.SpecialValueMaster')
                     AND type IN (N'U'))
  BEGIN
    CREATE TABLE
      ref.SpecialValueMaster
        (
            SpecialValueMasterID    BIGINT        NOT NULL
                                    IDENTITY(1,1)
                                    CONSTRAINT 
                                      PK_ref_SpecialValueMaster
                                    PRIMARY KEY CLUSTERED
          , CharVal                 CHAR(1)       NOT NULL
          , TinyIntVal              TINYINT       NOT NULL
          , SignedIntVal            SMALLINT      NOT NULL
          , SpecialValueMasterName  VARCHAR(128)  NOT NULL
          , SpecialValueMasterDesc  VARCHAR(512)  NULL
        )
  END
GO

/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ Load special values                                                                         │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤

    INSERT
      ref.SpecialValueMaster
        (
            CharVal
          , TinyIntVal
          , SignedIntVal
          , SpecialValueMasterName
          , SpecialValueMasterDesc
        )
    VALUES
        ('*',   0,  0, 'ALL', 'Reference for all (non-special) values in a reference table')
      , ('?', 254, -1, 'UNKNOWN', 'Reference for unknown values in a reference table')
      , ('#', 253, -2, 'OTHER', 'Reference for "other" values in a reference table (not in the reference table)')
      , ('!', 252, -3, 'NONE', 'Reference for none of the values in a reference table')

    SELECT * FROM ref.SpecialValueMaster

\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/





