/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   AdventureWorks_0006.ref.GeoZip5
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
  │                                                                                             │
  │                                                                                             │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ───────────────────────────────────────────────────────────────┤
      2018.12.27 bwarner         Initial Draft
\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE AdventureWorks_0006
GO

IF EXISTS (SELECT *
           FROM sys.objects
           WHERE object_id = OBJECT_ID(N'ref.GeoZip5')
                 AND type IN (N'U'))
    DROP TABLE 
      ref.GeoZip5
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'ref.GeoZip5')
                     AND type IN (N'U'))
  BEGIN
    CREATE TABLE
      ref.GeoZip5
        (
            Zip5     INT        NOT NULL
                        CONSTRAINT 
                          PK_ref_GeoZip5
                        PRIMARY KEY CLUSTERED
          , MSA         INT        NOT NULL
                        CONSTRAINT
                          FK_ref_GeoZip5_MSA
                        FOREIGN KEY REFERENCES 
                          ref.GeoMSA(MSA)
          , GeoStateID  TINYINT NOT NULL
                        CONSTRAINT
                          FK_ref_GeoZip5_GeoStateID
                        FOREIGN KEY REFERENCES 
                          ref.GeoState(GeoStateID)

        )
  END
GO

/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ Load from manual import temp table I set up                                                 │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤

    INSERT
      ref.GeoZip5
        (
            Zip5
          , MSA
          , GeoStateID
        )
    SELECT DISTINCT 
        Zip5        = CAST(csv.ZIP_CODE AS INT)
      , MSA         = ISNULL(CAST(csv.MSA AS INT),-1)
      , GeoStateID  = gs.GeoStateID
    FROM 
      [ref].[fs11_gpci_by_msa_ZIP] csv
      LEFT JOIN
      ref.GeoState gs
        ON csv.[STATE] = gs.GeoStateAbrv
    WHERE
      csv.ZIP_CODE IS NOT NULL

  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ Load special values                                                                         │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤

    INSERT
      ref.GeoZip5
        (
            Zip5
          , MSA
          , GeoStateID
        )
    VALUES
        ( 0,  0, 0)   -- 'ALL'
      , (-1, -1, 254) -- 'UNKNOWN'
      , (-2, -2, 253) -- 'OTHER'
      , (-3, -3, 252) -- 'NONE'

--      SET IDENTITY_INSERT ref.GeoRegion ON

--    INSERT
--      ref.GeoRegion
--        (
--            GeoRegionID
--          , GeoRegionName
--        )
--    VALUES
--        (0, 'ALL')
--      , (254, 'UNKNOWN')
--      , (253, 'OTHER')
--      , (252, 'NONE')

--SET IDENTITY_INSERT ref.GeoRegion OFF

--Division	MajorGroup	IndustryGroup	SIC	SIC_Desc
--!	252	-3	-3	NONE
--#	253	-2	-2	OTHER
--?	254	-1	-1	UNKNOWN
--*	0	0	0	ALL

--    SELECT DISTINCT 
--        '  , (''' + csv.[STATE] + ''', '''')'
--    FROM 
--      [ref].[fs11_gpci_by_msa_ZIP] csv
--      LEFT JOIN
--      ref.GeoState gs
--        ON csv.[STATE] = gs.GeoStateAbrv
--    WHERE
--      csv.ZIP_CODE IS NOT NULL
--      AND gs.GeoStateID IS NULL


\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/






