/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   AdventureWorks_0006.logging.RowsAffected
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
           WHERE object_id = OBJECT_ID(N'logging.RowsAffected')
                 AND type IN (N'U'))
    DROP TABLE 
      logging.RowsAffected
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'logging.RowsAffected')
                     AND type IN (N'U'))
  BEGIN
    CREATE TABLE
      logging.RowsAffected
        (
            RowsAffectedID    BIGINT          NOT NULL
                              IDENTITY(1,1)
                              CONSTRAINT 
                                PK_logging_RowsAffected
                              PRIMARY KEY CLUSTERED
          , RunLogID          BIGINT        NULL
                              CONSTRAINT
                                FK_logging_RowsAffected_RunLogID
                              FOREIGN KEY REFERENCES
                                logging.RunLog(RunLogID)
          , OperationTypeID   TINYINT       NOT NULL
                              CONSTRAINT
                                FK_logging_RowsAffected_OperationTypeID
                              FOREIGN KEY REFERENCES
                                logging.OperationType(OperationTypeID)
          , ServerInstance    NVARCHAR(16)  NULL
          , DatabaseName      SYSNAME       NULL
          , SchemaName        SYSNAME       NULL
          , ObjectName        SYSNAME       NOT NULL
          , RowsAffected      BIGINT        NOT NULL
          , IsTotal           BIT           NOT NULL
                              CONSTRAINT
                                DF_logging_RowsAffected_IsTotal
                              DEFAULT 0
        )
  END
GO






