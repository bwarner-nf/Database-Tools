/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   AdventureWorks_0006.dbo.ResponseSource
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
  │                                                                                             │
  │                                                                                             │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ───────────────────────────────────────────────────────────────┤
      2018.11.12 bwarner         Initial Draft

  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ Initial Populate table script                                                               │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤


    INSERT
      dbo.ResponseSource
        (
            ResponseSourceName
          , ResponseSourceDesc
        )
    VALUES
      (
          'Salesforce Accounts'
        , 'Implied response from the fact that this DUNS already has an account'
      )


    INSERT
      dbo.ResponseSource
        (
            ResponseSourceName
          , ResponseSourceDesc
        )
    VALUES
      (
          'Responed Campain Members'
        , 'DUNS numbers for campain members who have been marked as responed'
      )

    INSERT
      dbo.ResponseSource
        (
            ResponseSourceName
          , ResponseSourceDesc
        )
    VALUES
      (
          'Non-House-Status Leads'
        , 'Grab ALL Duns numbers from Non-house Leads when lead is inserted the lead status defaults to house?, until they respond'
      )

    INSERT
      dbo.ResponseSource
        (
            ResponseSourceName
          , ResponseSourceDesc
        )
    VALUES
      (
          'Marketing Scrub Leads'
        , 'Leads marked as Marketing Scrub'
      )

    INSERT
      dbo.ResponseSource
        (
            ResponseSourceName
          , ResponseSourceDesc
        )
    VALUES
      (
          'Out of Business Leads'
        , 'Leads marked as Out of Buisiness'
      )

    INSERT
      dbo.ResponseSource
        (
            ResponseSourceName
          , ResponseSourceDesc
        )
    VALUES
      (
          'Responder File Matched 1'
        , 'Old database cleaning project; We gave Ron a bunch OF responded files, and he appended these to supress from mail: FILE 1'
      )

    INSERT
      dbo.ResponseSource
        (
            ResponseSourceName
          , ResponseSourceDesc
        )
    VALUES
      (
          'Responder File Matched 2'
        , 'Old database cleaning project; We gave Ron a bunch OF responded files, and he appended these to supress from mail: FILE 2'
      )






      










\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE AdventureWorks_0006
GO

IF EXISTS (SELECT *
           FROM sys.objects
           WHERE object_id = OBJECT_ID(N'dbo.ResponseSource')
                 AND type IN (N'U'))
    DROP TABLE 
      dbo.ResponseSource
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'dbo.ResponseSource')
                     AND type IN (N'U'))
  BEGIN
    CREATE TABLE
      dbo.ResponseSource
        (
            ResponseSourceID  TINYINT        NOT NULL
                              IDENTITY(1,1)
                              CONSTRAINT 
                                PK_dbo_ResponseSource
                              PRIMARY KEY CLUSTERED
          , ResponseSourceName VARCHAR(128)   NOT NULL
          , ResponseSourceDesc VARCHAR(512)   NULL
        )
  END
GO





