/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   AdventureWorks_0006.ref.GeoState
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
           WHERE object_id = OBJECT_ID(N'ref.GeoState')
                 AND type IN (N'U'))
    DROP TABLE 
      ref.GeoState
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'ref.GeoState')
                     AND type IN (N'U'))
  BEGIN
    CREATE TABLE
      ref.GeoState
        (
            GeoStateID    TINYINT     NOT NULL
                          IDENTITY(1,1)
                          CONSTRAINT
                            PK_ref_GeoState
                          PRIMARY KEY CLUSTERED
          , GeoStateName  VARCHAR(36) NOT NULL
                          CONSTRAINT
                            UK_ref_GeoState_GeoStateName
                          UNIQUE
          , GeoStateAbrv  CHAR(2)     NOT NULL
                          CONSTRAINT 
                            UK_ref_GeoState_GeoStateAbrv
                          UNIQUE
          , GeoRegionID   TINYINT     NOT NULL
                          CONSTRAINT
                            FK_ref_GeoState_GeoRegionID
                          FOREIGN KEY REFERENCES
                            ref.GeoRegion(GeoRegionID)
        )
  END
GO


/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ Populate From Old Table                                                                     │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤

    INSERT
      ref.GeoState
        (
            GeoStateName
          , GeoStateAbrv
          , GeoRegionID
        )
    SELECT
        old.[state_full_name]
      , old.[state_abbrev]
      --, old.[region]
      , gr.GeoRegionID
    FROM
      [AdventureWorks_0002].[OM].[state_to_region_xmap] old
      JOIN
      ref.GeoRegion gr
        ON old.[region] = gr.GeoRegionName

  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ Populate Special State Codes                                                                │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤

  
    INSERT 
      ref.GeoState([GeoRegionID],[GeoStateAbrv],[GeoStateName])
    VALUES
        (254, 'PW', 'Palau')
      , (254, 'AS', 'American Samoa')
      , (254, 'PR', 'Puerto Rico')
      , (254, 'GU', 'Guam')
      , (254, 'MP', 'Northern Mariana Islands')
      , (254, 'VI', 'U.S. Virgin Islands')
      , (254, 'AP', 'U.S. Armed Forces – Pacific')
      , (254, 'AA', 'U.S. Armed Forces – Americas')
      , (254, 'FM', 'Micronesia')
      , (254, 'AE', 'U.S. Armed Forces – Europe')
      , (254, 'MH', 'Marshall Islands')

  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ Populate Special Key Values                                                                 │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤


    SET IDENTITY_INSERT ref.GeoState ON

    INSERT 
      ref.GeoState(GeoStateID,[GeoRegionID],[GeoStateAbrv],[GeoStateName])
    VALUES
        (252, 252, '!!', 'NONE')
      , (253, 253, '##', 'OTHER')
      , (254, 254, '??', 'UNKNOWN')
      , ( 0,   0, '**', 'ALL')

    SET IDENTITY_INSERT ref.GeoState OFF



    SELECT * FROM ref.GeoState

--Division	MajorGroup	IndustryGroup	SIC	SIC_Desc
--!	252	-3	-3	NONE
--#	253	-2	-2	OTHER
--?	254	-1	-1	UNKNOWN
--*	0	0	0	ALL

    --SELECT
    --    MAX(LEN([state_full_name]))
    --  , MAX(LEN([region]))

    --  --, [state_abbrev]
    --  --, [region]
    --FROM
    --  [AdventureWorks_0002].[OM].[state_to_region_xmap]

\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/






