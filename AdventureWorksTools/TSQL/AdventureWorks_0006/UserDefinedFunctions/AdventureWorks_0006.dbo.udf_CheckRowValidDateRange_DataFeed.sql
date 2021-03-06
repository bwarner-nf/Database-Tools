/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: User Defined Function DDL                                                            │
  │   AdventureWorks_0006.dbo.udf_CheckRowValidDateRange_DataFeed
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
      
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ────────────────────────────────────────────────────────────── │
      2018.12.21 bwarner         Initial Draft
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ UNIT TESTING SCRIPTS:                                                                       │

      SELECT TestResult = dbo.udf_CheckRowValidDateRange_DataFeed('Test_Param')

\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE AdventureWorks_0006
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'dbo.udf_CheckRowValidDateRange_DataFeed'))
	DROP FUNCTION 
    dbo.udf_CheckRowValidDateRange_DataFeed
GO

CREATE FUNCTION 
  dbo.udf_CheckRowValidDateRange_DataFeed
    (
        @ValidFrom    DATETIME2
      , @MailingOrgID TINYINT
      , @DataFeedName VARCHAR(32)
    )
RETURNS
  BIT
AS
BEGIN
  DECLARE 
      @IsValid      BIT       = 0
    , @LastExpired  DATETIME2

  SELECT
    @LastExpired = MAX(ValidTo)
  FROM
    dbo.DataFeed
  WHERE
        MailingOrgID  = @MailingOrgID
    AND DataFeedName  = @DataFeedName

  IF @LastExpired IS NULL OR @ValidFrom >= @LastExpired
    SET @IsValid = 1
  RETURN @IsValid
END
GO






