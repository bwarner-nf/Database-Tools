/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Stored Procedure DDL                                                                 │
  │   Analytics_WS.logging.usp_RunAttribute_Set
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

      EXEC logging.usp_RunAttribute_Set 
          @RunLogID       = 
        , @AttributeName  = 
        , @AttributeValue = 

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
          [object_id] = OBJECT_ID(N'logging.usp_RunAttribute_Set') 
      AND [type] IN(N'P', N'PC')
  )
	DROP PROCEDURE 
    logging.usp_RunAttribute_Set
GO

CREATE PROCEDURE 
  logging.usp_RunAttribute_Set
    (
        @RunLogID       BIGINT
      , @AttributeName  NVARCHAR(128)
      , @AttributeValue NVARCHAR(MAX)
      , @Verbose        BIT            = 0
    )
AS
BEGIN


  DECLARE
      @DidUpdate BIT = 0

  IF @Verbose = 1
    BEGIN
      DECLARE @msg NVARCHAR(4000) = @AttributeName + ':' + LEFT(@AttributeValue,250) + '[RunLogID:'+  LTRIM(STR(@RunLogID)) + ']'
      EXEC logging.usp_EventMessage_Log @EventMessage=@msg
    END
  

  

  IF EXISTS(SELECT TOP 1 1 FROM logging.RunAttribute WHERE RunLogID = @RunLogID AND AttributeName = @AttributeName)
    BEGIN
      UPDATE
        logging.RunAttribute
      SET
        AttributeValue = @AttributeValue
      WHERE
            RunLogID      = @RunLogID 
        AND AttributeName = @AttributeName
      SET @DidUpdate = 1
    END
  ELSE
    BEGIN
      INSERT logging.RunAttribute(RunLogID,AttributeName,AttributeValue)
      VALUES(@RunLogID,@AttributeName,@AttributeValue)

      SET @DidUpdate = 1

    END

  IF @DidUpdate <> 1
    BEGIN
      EXEC logging.usp_EventMessage_Log @EventMessage='Unable to set Run Attribute',@ErrSeverity=16,@ErrState =89
    END

END
GO
