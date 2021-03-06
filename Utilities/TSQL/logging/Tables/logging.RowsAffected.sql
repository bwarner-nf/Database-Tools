/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   DirectMail.logging.RowsAffected
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
  │                                                                                             │

ALTER TABLE logging.RowsAffected
DROP COLUMN Comment

ALTER TABLE logging.RowsAffected
DROP COLUMN Executed

ALTER TABLE logging.RowsAffected
ADD  
    Comment   NVARCHAR(512) NULL
  , Executed  DATETIME2     NULL

UPDATE
  ra
SET
  Executed = rl.Executed
FROM
  logging.RowsAffected ra
  JOIN
  logging.RunLog rl
    ON ra.RunLogID = rl.RunLogID

ALTER TABLE logging.RowsAffected
ALTER COLUMN Executed DATETIME2 NOT NULL

ALTER TABLE logging.RowsAffected
ADD CONSTRAINT DF_logging_RowsAffected_Executed 
DEFAULT GETDATE() FOR Executed

  │                                                                                             │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ───────────────────────────────────────────────────────────────┤
      2018.12.13 bwarner         Initial Draft
\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE DirectMail
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
          , Comment           NVARCHAR(512) NULL
          , Executed          DATETIME2     NOT NULL

            CONSTRAINT 
              DF_logging_RowsAffected_Executed 
            DEFAULT 
              GETDATE() 

        )
  END
GO


