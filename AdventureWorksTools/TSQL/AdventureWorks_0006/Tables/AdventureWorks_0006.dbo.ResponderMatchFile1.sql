/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   AdventureWorks_0006.dbo.ResponderMatchFile1
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
  │                                                                                             │
  │                                                                                             │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ───────────────────────────────────────────────────────────────┤
      2018.12.18 bwarner         Initial Draft
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DATA MIGRATION SCRIPT                                                                       │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤

    INSERT
      dbo.ResponderMatchFile1
        (
            DUNS
          , SalesForceID
        )
    SELECT 
        DUNS
      , LeadID
    FROM
      (
        SELECT
            DUNS
          , LeadID = Cust_Key
          , rn = ROW_NUMBER() OVER(PARTITION BY DUNS ORDER BY Cust_Key ASC)
        FROM
          AdventureWorks_0007.dbo.NF_Matching_DUNS_1
      ) x
    WHERE
      x.rn = 1
      
\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/

USE AdventureWorks_0006
GO

IF EXISTS (SELECT *
           FROM sys.objects
           WHERE object_id = OBJECT_ID(N'dbo.ResponderMatchFile1')
                 AND type IN (N'U'))
    DROP TABLE 
      dbo.ResponderMatchFile1
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'dbo.ResponderMatchFile1')
                     AND type IN (N'U'))
  BEGIN
    CREATE TABLE
      dbo.ResponderMatchFile1
        (
            DUNS                      INT       NOT NULL
                                      CONSTRAINT
                                        PK_ResponderMatchFile1
                                      PRIMARY KEY CLUSTERED
          , SalesForceID              NCHAR(18) NULL
        )
  END
GO




