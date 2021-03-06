/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Table DDL                                                                            │
  │   DirectMail.logging.OperationType
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
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ UNIT TESTING SCRIPTS:                                                                       │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤

      INSERT
        logging.OperationType
          (
             OperationType
          )
      VALUES                  
          ('Insert')
        , ('Update')
        , ('Delete')
        
      INSERT
        logging.OperationType
          (
             OperationType
          )
      VALUES                  
          ('Archive')


    SELECT * FROM logging.OperationType

OperationTypeID	OperationType
1	Insert
2	Update
3	Delete


\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE DirectMail
GO

IF EXISTS (SELECT *
           FROM sys.objects
           WHERE object_id = OBJECT_ID(N'logging.OperationType')
                 AND type IN (N'U'))
    DROP TABLE 
      logging.OperationType
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.objects
               WHERE object_id = OBJECT_ID(N'logging.OperationType')
                     AND type IN (N'U'))
  BEGIN
    CREATE TABLE
      logging.OperationType
        (
            OperationTypeID   TINYINT        NOT NULL
                              IDENTITY(1,1)
                              CONSTRAINT 
                                PK_logging_OperationType
                              PRIMARY KEY CLUSTERED
                              WITH(PAD_INDEX = OFF, FILLFACTOR = 100)
          , OperationType     VARCHAR(128)   NOT NULL
        )
  END
GO

