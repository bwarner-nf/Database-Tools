/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: User Defined Function DDL                                                            │
  │   AdventureWorks_0006.config.udf_CheckRowValidDateRange_ListSegmentationThreshold
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
      
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ────────────────────────────────────────────────────────────── │
      2018.12.20 bwarner         Initial Draft
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ UNIT TESTING SCRIPTS:                                                                       │

      SELECT TestResult = config.udf_CheckRowValidDateRange_ListSegmentationThreshold('Test_Param')

\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE AdventureWorks_0006
GO

IF  EXISTS (SELECT * 
            FROM sys.objects 
            WHERE [object_id] = OBJECT_ID(N'config.udf_CheckRowValidDateRange_ListSegmentationThreshold')
            AND [type_desc] LIKE 'SQL%FUNCTION')
	DROP FUNCTION 
    config.udf_CheckRowValidDateRange_ListSegmentationThreshold
GO

CREATE FUNCTION 
  config.udf_CheckRowValidDateRange_ListSegmentationThreshold
    (
        @ValidFrom      DATETIME2
      , @MailingOrgID   TINYINT
      , @SIC_Division   CHAR(1)
      , @IsPrevLicensed BIT
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
    config.ListSegmentationThreshold
  WHERE
        MailingOrgID    = @MailingOrgID
    AND SIC_Division    = @SIC_Division
    AND IsPrevLicensed  = @IsPrevLicensed

  IF @LastExpired IS NULL OR @ValidFrom >= @LastExpired
    SET @IsValid = 1
  RETURN @IsValid
END
GO






