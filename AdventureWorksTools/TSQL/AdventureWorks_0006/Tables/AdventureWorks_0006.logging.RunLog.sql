/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   AdventureWorks_0006.logging.RunLog
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
  │                                                                                             │
  │                                                                                             │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ───────────────────────────────────────────────────────────────┤
      2018.12.13 bwarner         Initial Draft
\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE AdventureWorks_0006
GO

IF EXISTS (SELECT *
           FROM sys.objects
           WHERE object_id = OBJECT_ID(N'logging.RunLog')
                 AND type IN (N'U'))
    DROP TABLE 
      logging.RunLog
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'logging.RunLog')
                     AND type IN (N'U'))
  BEGIN
    CREATE TABLE
      logging.RunLog
        (
            RunLogID          BIGINT        NOT NULL
                              IDENTITY(1,1)
                              CONSTRAINT 
                                PK_logging_RunLog
                              PRIMARY KEY CLUSTERED
          , ParentRunLogID    BIGINT        NULL
                              CONSTRAINT
                                FK_RunLog_ParentRunLogID
                              FOREIGN KEY REFERENCES
                                logging.RunLog(RunLogID)
          , RunComponentID    SMALLINT     NOT NULL
                              CONSTRAINT
                                FK_RunLog_RunComponentID
                              FOREIGN KEY REFERENCES
                                logging.RunComponent(RunComponentID)
          , Executed          DATETIME2     NOT NULL
                              CONSTRAINT
                                DF_logging_RunLog_Occured
                              DEFAULT (GETDATE())
          , Completed         DATETIME2     NULL
          , ReturnCode        INT           NULL
          , DidSucceed        BIT           NOT NULL
                              CONSTRAINT
                                DF_logging_RunLog_DidSucceed
                              DEFAULT 0
          , DidComplete       BIT           NOT NULL
                              CONSTRAINT
                                DF_logging_RunLog_DidComplete
                              DEFAULT 0
          , Comments          NVARCHAR(512) NULL
        )
  END
GO






