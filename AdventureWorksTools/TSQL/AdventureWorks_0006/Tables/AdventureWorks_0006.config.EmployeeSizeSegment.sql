/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   AdventureWorks_0006.config.EmployeeSizeSegment
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
  │                                                                                             │
  │                                                                                             │



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
            WHERE [object_id] = OBJECT_ID(N'config.udf_CheckRowValidDateRange_EmployeeSizeSegment')
            AND [type_desc] LIKE 'SQL%FUNCTION')
	DROP FUNCTION 
    config.udf_CheckRowValidDateRange_EmployeeSizeSegment
GO



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
           WHERE object_id = OBJECT_ID(N'config.EmployeeSizeSegment')
                 AND type IN (N'U'))
    DROP TABLE 
      config.EmployeeSizeSegment
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'config.EmployeeSizeSegment')
                     AND type IN (N'U'))
  BEGIN
    CREATE TABLE
      config.EmployeeSizeSegment
        (
            EmployeeSizeSegmentID   SMALLINT NOT NULL
                                    IDENTITY(1,1)
                                    CONSTRAINT
                                      PK_config_EmployeeSizeSegment
                                    PRIMARY KEY CLUSTERED
          , MailingOrgID            TINYINT       NOT NULL
                                    CONSTRAINT
                                      FK_config_EmployeeSizeSegment_MailingOrg
                                    FOREIGN KEY REFERENCES
                                      dbo.MailingOrg(MailingOrgID)
                                    ON DELETE CASCADE
          , MinEmpSize              INT          NULL
          , MaxEmpSize              INT          NULL
          , EmployeeSizeSegmentName AS CAST(
                                              CASE 
                                                WHEN EmployeeSizeSegmentID = 0 OR (MinEmpSize IS NULL AND MaxEmpSize IS NULL  AND EmployeeSizeSegmentID > 0)
                                                  THEN 'All Employee Sizes'
                                                WHEN EmployeeSizeSegmentID = -1
                                                  THEN 'Unknown'
                                                WHEN EmployeeSizeSegmentID = -2
                                                  THEN 'Other'
                                                WHEN EmployeeSizeSegmentID = -3
                                                  THEN 'None'
                                                WHEN MinEmpSize IS NULL
                                                  THEN 'Less than ' + LTRIM(STR(MaxEmpSize)) + ' employees.'
                                                WHEN MaxEmpSize IS NULL
                                                  THEN 'More than ' + LTRIM(STR(MinEmpSize)) + ' employees.'
                                                ELSE 'Between ' + LTRIM(STR(MinEmpSize)) + ' and ' + LTRIM(STR(MaxEmpSize)) + ' employees.'
                                              END
                                              AS VARCHAR(128)
                                          )
                                          PERSISTED
          , ValidFrom               DATETIME2      NOT NULL
                                    CONSTRAINT
                                      DF_config_EmployeeSizeSegment_ValidFrom
                                    DEFAULT
                                      GETDATE()
          , ValidTo                 DATETIME2       NULL

          , IsCurrent               AS CAST(CASE WHEN ValidTo IS NULL AND ValidFrom < GETDATE() THEN 1 ELSE 0 END AS BIT)
                                    --PERSISTED

          , CreatedDate             DATETIME        NOT NULL
                                    CONSTRAINT
                                      DF_config_EmployeeSizeSegment_CreatedDate
                                    DEFAULT 
                                      GETDATE()
          , CreatedBy               SYSNAME         NOT NULL
                                    CONSTRAINT
                                      DF_config_EmployeeSizeSegment_CreatedBy
                                    DEFAULT 
                                      SUSER_NAME()
          , ModifiedDate            DATETIME        NOT NULL
                                    CONSTRAINT
                                      DF_config_EmployeeSizeSegment_ModifiedDate
                                    DEFAULT 
                                      GETDATE()
          , ModifiedBy              SYSNAME         NOT NULL
                                    CONSTRAINT
                                      DF_config_EmployeeSizeSegment_ModifiedBy
                                    DEFAULT 
                                      SUSER_NAME()

          , CONSTRAINT 
              CHK_config_EmployeeSizeSegment_ValidDateRange_Expire
            CHECK 
              (
                    ValidTo IS NULL
                OR  ValidTo > ValidFrom
              )
          , CONSTRAINT
              UN_config_EmployeeSizeSegment_BusKey
            UNIQUE
              (
                  MailingOrgID ASC
                , EmployeeSizeSegmentName DESC
                , ValidFrom DESC
              )
          , CONSTRAINT
              UN_config_EmployeeSizeSegment_BusKeyID
            UNIQUE
              (
                  MailingOrgID ASC
                , EmployeeSizeSegmentID ASC
                , ValidFrom DESC
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
      config.EmployeeSizeSegment
        (
            MinEmpSize
          , MaxEmpSize
          , MailingOrgID
          , ValidFrom
        )
    SELECT
        MinEmpSize      = [min_emp_size]
      , MaxEmpSize      = [max_emp_size]
      , MailingOrgID    = @MailingOrgID
      , ValidFrom       = @TheBeginningOfDATETIME2
    FROM
      [AdventureWorks_0002].[OM].[emp_segment_xmap]


    SET IDENTITY_INSERT config.EmployeeSizeSegment ON

    --DECLARE 
    --    @MailingOrgID TINYINT
    --  , @TheBeginningOfDATETIME2  DATETIME2 = '0001-01-01 00:00:00'
    --  , @TheEndOfDATETIME2        DATETIME2 = '9999-12-31 23:59:59.9999999'

    SELECT
      @MailingOrgID = MailingOrgID
    FROM
      dbo.MailingOrg
    WHERE
      MailingOrgName = 'National Funding'


    INSERT
      config.EmployeeSizeSegment
        (
            MinEmpSize
          , MaxEmpSize
          , MailingOrgID
          , ValidFrom
          , EmployeeSizeSegmentID
        )
    VALUES
        (
            NULL
          , NULL
          , @MailingOrgID
          , @TheBeginningOfDATETIME2
          , -2
        )

    SET IDENTITY_INSERT config.EmployeeSizeSegment OFF


    SELECT * FROM  config.EmployeeSizeSegment



\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/






