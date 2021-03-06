/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   AdventureWorks_0006.dbo.RespondersMasterList_ByDUNS
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
\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE AdventureWorks_0006
GO

IF EXISTS (SELECT *
           FROM sys.objects
           WHERE object_id = OBJECT_ID(N'dbo.RespondersMasterList_ByDUNS')
                 AND type IN (N'U'))
    DROP TABLE 
      dbo.RespondersMasterList_ByDUNS
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'dbo.RespondersMasterList_ByDUNS')
                     AND type IN (N'U'))
  BEGIN
    CREATE TABLE
      dbo.RespondersMasterList_ByDUNS
        (
            DUNS                            INT           NOT NULL
                                            CONSTRAINT
                                              PK_RespondersMasterList_ByDUNS
                                            PRIMARY KEY CLUSTERED
          , ResponseSourceID TINYINT   NOT NULL
            CONSTRAINT
              FK_RespondersMasterList_ByDUNS_ResponseSource
            FOREIGN KEY REFERENCES 
              dbo.ResponseSource(ResponseSourceID)
        )
  END
GO





