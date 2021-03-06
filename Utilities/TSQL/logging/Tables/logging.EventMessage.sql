/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   DirectMail.logging.EventMessage
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
  │  This table holds event messages that are logged durring the execution of mail processes    │
  │                                                                                             │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ───────────────────────────────────────────────────────────────┤
      2018.12.12 bwarner         Initial Draft
\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE DirectMail
GO

IF EXISTS (SELECT *
           FROM sys.objects
           WHERE object_id = OBJECT_ID(N'logging.EventMessage')
                 AND type IN (N'U'))
    DROP TABLE 
      logging.EventMessage
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'logging.EventMessage')
                     AND type IN (N'U'))
  BEGIN
    CREATE TABLE
      logging.EventMessage
        (
            EventMessageID  BIGINT        NOT NULL
                            IDENTITY(1,1)
                            CONSTRAINT 
                              PK_logging_EventMessage
                            PRIMARY KEY CLUSTERED
          , Occured         DATETIME2
                            CONSTRAINT
                              DF_logging_EventMessage_Occured
                            DEFAULT (GETDATE())
          , MsgID           INT           NULL      -- ERROR_NUMBER()          
          , EventMessage    NVARCHAR(MAX) NOT NULL  -- ERROR_MESSAGE()
          , ErrSeverity     INT           NULL      -- ERROR_SEVERITY()
          , ErrState        INT           NULL      -- ERROR_STATE()
          , ProcName        SYSNAME       NULL      -- ERROR_PROCEDURE()
          , Line            INT           NULL      -- ERROR_LINE()
          --, SchemaName      SYSNAME       NULL
          --, ObjectName      SYSNAME       NULL
          --, RowsAffected    BIGINT        NULL
        )
  END
GO

--select * FROM sys.messages