/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Stored Procedure DDL                                                                 │
  │   Analytics_WS.logging.usp_RunAttribute_Get
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
      
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ────────────────────────────────────────────────────────────── │
      2019.01.08 bwarner         Initial Draft
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ UNIT TESTING SCRIPTS:                                                                       │

      EXEC logging.usp_RunAttribute_Get @Param01 = 'Phu-Barr'

\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE Analytics_WS
GO

IF EXISTS 
  (
    SELECT 
      * 
    FROM 
      sys.objects 
    WHERE 
          [object_id] = OBJECT_ID(N'logging.usp_RunAttribute_Get') 
      AND [type] IN(N'P', N'PC')
  )
	DROP PROCEDURE 
    logging.usp_RunAttribute_Get
GO

CREATE PROCEDURE 
  logging.usp_RunAttribute_Get
    (
        @RunLogID       BIGINT
      , @AttributeName  NVARCHAR(128)
      , @AttributeValue NVARCHAR(MAX) OUTPUT
    )
AS
BEGIN
  SET @AttributeValue = 
    (
      SELECT 
        AttributeValue 
      FROM 
        logging.RunAttribute 
      WHERE 
            RunLogID      = @RunLogID 
        AND AttributeName = @AttributeName
    )
END
GO

