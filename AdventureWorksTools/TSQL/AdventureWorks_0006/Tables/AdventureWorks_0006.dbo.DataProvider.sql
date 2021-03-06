/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   AdventureWorks_0006.dbo.DataProvider
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
  │                                                                                             │
  │                                                                                             │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ───────────────────────────────────────────────────────────────┤
      2018.11.08 bwarner         Initial Draft
\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE AdventureWorks_0006
GO

IF EXISTS (SELECT *
           FROM sys.objects
           WHERE object_id = OBJECT_ID(N'dbo.DataProvider')
                 AND type IN (N'U'))
    DROP TABLE 
      dbo.DataProvider
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'dbo.DataProvider')
                     AND type IN (N'U'))
  BEGIN
    CREATE TABLE
      dbo.DataProvider
        (
            DataProviderID    TINYINT         NOT NULL
                              IDENTITY(1,1)
                              CONSTRAINT 
                                PK_dbo_DataProvider
                              PRIMARY KEY CLUSTERED

          , MailingOrgID    TINYINT       NOT NULL
                            CONSTRAINT
                              FK_dbo_DataProvider_MailingOrg
                            FOREIGN KEY REFERENCES
                              dbo.MailingOrg(MailingOrgID)

          , DataProviderCode  VARCHAR(4)      NOT NULL

          , DataProviderName  VARCHAR(128)    NOT NULL
          , DataProviderDesc  VARCHAR(512)    NULL
          , CreatedDate       DATETIME        NOT NULL
                              CONSTRAINT
                                DF_DataProvider_CreatedDate
                              DEFAULT 
                                GETDATE()
          , CreatedBy         SYSNAME         NOT NULL
                              CONSTRAINT
                                DF_DataProvider_CreatedBy
                              DEFAULT 
                                SUSER_NAME()
          , ModifiedDate      DATETIME        NOT NULL
                              CONSTRAINT
                                DF_DataProvider_ModifiedDate
                              DEFAULT 
                                GETDATE()
          , ModifiedBy        SYSNAME         NOT NULL
                              CONSTRAINT
                                DF_DataProvider_ModifiedBy
                              DEFAULT 
                                SUSER_NAME()

          , CONSTRAINT
              UN_DataProvider_DataProviderCode
            UNIQUE
              (                  
                  MailingOrgID
                , DataProviderCode
              )
          , CONSTRAINT
              UN_DataProvider_DataProviderName
            UNIQUE
              (                  
                  MailingOrgID
                , DataProviderName
              )
        )
  END
GO



/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ Populate From Old Table                                                                     │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤

    DECLARE 
        @MailingOrgID TINYINT

    SELECT
      @MailingOrgID = MailingOrgID
    FROM
      dbo.MailingOrg
    WHERE
      MailingOrgName = 'National Funding'

    INSERT
      dbo.DataProvider
        (
            DataProviderName
          , DataProviderCode
          , DataProviderDesc
          , MailingOrgID
        )
    VALUES
        (
            'Dun & Bradstreet'
          , 'AdventureWorks_0007'
          , 'Provides mailing universe prospects'
          , @MailingOrgID
        )
      , (
            'InfoGroup'
          , 'INFG'
          , 'Provides mailing universe prospects'
          , @MailingOrgID
        )
      , (
            'National Change of Address'
          , 'NCOA'
          , 'Provides mailing universe prospects'
          , @MailingOrgID
        )
      , (
            'Lattice'
          , 'LATT'
          , 'Provides mailing universe prospects'
          , @MailingOrgID
        )
      , (
            'Salesforce'
          , 'SF'
          , 'Provides mailing universe prospects'
          , @MailingOrgID
        )






    DECLARE 
        @MailingOrgID TINYINT

    SELECT
      @MailingOrgID = MailingOrgID
    FROM
      dbo.MailingOrg
    WHERE
      MailingOrgName = 'National Funding'

    INSERT
      dbo.DataProvider
        (
            DataProviderName
          , DataProviderCode
          , DataProviderDesc
          , MailingOrgID
        )
    VALUES
        (
            'National Funding'
          , 'NF'
          , 'National Funding'
          , @MailingOrgID
        )



    DECLARE 
        @MailingOrgID TINYINT

    SELECT
      @MailingOrgID = MailingOrgID
    FROM
      dbo.MailingOrg
    WHERE
      MailingOrgName = 'QuickBridge'

    INSERT
      dbo.DataProvider
        (
            DataProviderName
          , DataProviderCode
          , DataProviderDesc
          , MailingOrgID
        )
    VALUES
        (
            'QuickBridge'
          , 'QB'
          , 'Quick Bridge Funding, LLC'
          , @MailingOrgID
        )


    SELECT * FROM dbo.DataProvider





    SELECT
      *
    FROM
      dbo.MailingOrg

\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/





