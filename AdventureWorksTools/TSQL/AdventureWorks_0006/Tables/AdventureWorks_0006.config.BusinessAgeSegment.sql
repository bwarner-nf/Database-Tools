/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   AdventureWorks_0006.config.BusinessAgeSegment
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
  │                                                                                             │
  │                                                                                             │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ───────────────────────────────────────────────────────────────┤
      2018.12.20 bwarner         Initial Draft
\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE AdventureWorks_0006
GO


IF EXISTS 
  (
    SELECT 1
    FROM sys.check_constraints 
    WHERE 
          [object_id]       = OBJECT_ID(N'config.CHK_config_BusinessAgeSegment_Valid_BusinessAgeSegment_Range')
      AND parent_object_id  = OBJECT_ID(N'config.BusinessAgeSegment')
  )
  ALTER TABLE 
    config.BusinessAgeSegment 
  DROP CONSTRAINT 
    CHK_config_BusinessAgeSegment_Valid_BusinessAgeSegment_Range
GO


IF  EXISTS (SELECT * 
            FROM sys.objects 
            WHERE [object_id] = OBJECT_ID(N'config.udf_CheckRowValid_BusinessAgeSegment_Range')
            AND [type_desc] LIKE 'SQL%FUNCTION')
	DROP FUNCTION 
    config.udf_CheckRowValid_BusinessAgeSegment_Range
GO


IF EXISTS (SELECT *
           FROM sys.objects
           WHERE object_id = OBJECT_ID(N'config.BusinessAgeSegment')
                 AND type IN (N'U'))
    DROP TABLE 
      config.BusinessAgeSegment
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'config.BusinessAgeSegment')
                     AND type IN (N'U'))
  BEGIN
    CREATE TABLE
      config.BusinessAgeSegment
        (
            BusinessAgeSegmentID    SMALLINT     NOT NULL
                                    IDENTITY(1,1)
                                    CONSTRAINT 
                                      PK_config_BusinessAgeSegment
                                    PRIMARY KEY CLUSTERED
          , MailingOrgID            TINYINT     NOT NULL
                                    CONSTRAINT
                                      FK_config_BusinessAgeSegment_MailingOrg
                                    FOREIGN KEY REFERENCES
                                      dbo.MailingOrg(MailingOrgID)
                                    ON DELETE CASCADE
          , MinAge                  TINYINT     NULL
          , MaxAge                  TINYINT     NULL
          , BusinessAgeSegmentName  AS CAST(
                                            CASE
                                              WHEN BusinessAgeSegmentID = 0 OR (MinAge IS NULL AND MaxAge IS NULL AND BusinessAgeSegmentID > 0)
                                                THEN 'All Ages'
                                              WHEN BusinessAgeSegmentID = -1
                                                THEN 'Unknown'
                                              WHEN BusinessAgeSegmentID = -2
                                                THEN 'Other'
                                              WHEN BusinessAgeSegmentID = -3
                                                THEN 'None'
                                              WHEN MinAge IS NULL
                                                THEN 'Less than ' + LTRIM(STR(MaxAge)) + ' years old.'
                                              WHEN MaxAge IS NULL
                                                THEN 'More than ' + LTRIM(STR(MinAge)) + ' years old.'
                                              ELSE 'Between ' + LTRIM(STR(MinAge)) + ' and ' + LTRIM(STR(MaxAge)) + ' years old.'
                                            END
                                            AS VARCHAR(32)
                                          )
                                    PERSISTED
          , ValidFrom               DATETIME2   NOT NULL
                                    CONSTRAINT
                                      DF_config_BusinessAgeSegment_ValidFrom
                                    DEFAULT
                                      GETDATE()
          , ValidTo                 DATETIME2   NULL
          , IsCurrent               AS CAST(CASE WHEN ValidTo IS NULL AND ValidFrom < GETDATE() THEN 1 ELSE 0 END AS BIT)
                                    --PERSISTED
          , CreatedDate             DATETIME        NOT NULL
                                    CONSTRAINT
                                      DF_config_BusinessAgeSegment_CreatedDate
                                    DEFAULT 
                                      GETDATE()
          , CreatedBy               SYSNAME         NOT NULL
                                    CONSTRAINT
                                      DF_config_BusinessAgeSegment_CreatedBy
                                    DEFAULT 
                                      SUSER_NAME()
          , ModifiedDate            DATETIME        NOT NULL
                                    CONSTRAINT
                                      DF_config_BusinessAgeSegment_ModifiedDate
                                    DEFAULT 
                                      GETDATE()
          , ModifiedBy              SYSNAME         NOT NULL
                                    CONSTRAINT
                                      DF_config_BusinessAgeSegment_ModifiedBy
                                    DEFAULT 
                                      SUSER_NAME()
          , CONSTRAINT
              UN_config_BusinessAgeSegment_BusKey
            UNIQUE
              (
                  MailingOrgID
                , BusinessAgeSegmentName
                , ValidFrom
              )
          , CONSTRAINT 
              UN_config_BusinessAgeSegment_BusKeyID
            UNIQUE
              (                  
                  MailingOrgID
                , BusinessAgeSegmentID
                , ValidFrom
              )
          , CONSTRAINT 
              CHK_config_BusinessAgeSegment_ValidDateRange_Expire
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
      config.BusinessAgeSegment
        (
            MailingOrgID
          , MinAge
          , MaxAge
          , ValidFrom
        )
    VALUES
        (
            @MailingOrgID
          , NULL
          , 7
          , @TheBeginningOfDATETIME2
        )
      , (
            @MailingOrgID
          , 8
          , 11
          , @TheBeginningOfDATETIME2
        )
      , (
            @MailingOrgID
          , 12
          , 15
          , @TheBeginningOfDATETIME2
        )
      , (
            @MailingOrgID
          , 16
          , 21
          , @TheBeginningOfDATETIME2
        )
      , (
            @MailingOrgID
          , 22
          , NULL
          , @TheBeginningOfDATETIME2
        )

    SET IDENTITY_INSERT config.BusinessAgeSegment ON

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
      config.BusinessAgeSegment
        (
            MailingOrgID
          , MinAge
          , MaxAge
          , ValidFrom
          , BusinessAgeSegmentID
        )
    VALUES
        (
            @MailingOrgID
          , NULL
          , NULL
          , @TheBeginningOfDATETIME2
          , -2
        )

    SET IDENTITY_INSERT config.BusinessAgeSegment OFF


  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ Dev Scratch:                                                                                │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤


		CASE WHEN [a].[Year Started] >= 2011 THEN '2011+'
			 WHEN [a].[Year Started] >= 2007 THEN '2007 - 2010'
			 WHEN [a].[Year Started] >= 2003 THEN '2003 - 2006'
			 WHEN [a].[Year Started] >= 1997 THEN '1997 - 2002'
			 WHEN [a].[Year Started] < 1997 THEN '<=1996'
			 ELSE 'Other'

   SELECT * FROM config.BusinessAgeSegment 

\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/









