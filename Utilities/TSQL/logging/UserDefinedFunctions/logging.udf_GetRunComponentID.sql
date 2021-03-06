/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: User Defined Function DDL                                                            │
  │   AdventureWorks.logging.udf_GetRunComponentID
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
      
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ────────────────────────────────────────────────────────────── │
      2019.01.15 bwarner         Initial Draft
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ UNIT TESTING SCRIPTS:                                                                       │

      SELECT TestResult = logging.udf_GetRunComponentID('Test_Param')


CREATE SYNONYM dbo.rcn FOR dbo.udf_GetRunComponentName 


\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
--USE AdventureWorks
--GO

IF  EXISTS (SELECT 1
            FROM  sys.objects 
            WHERE     [object_id] = OBJECT_ID(N'logging.udf_GetRunComponentID')
                  AND [type_desc] LIKE 'SQL%FUNCTION')
  DROP FUNCTION 
    logging.udf_GetRunComponentID
GO

CREATE FUNCTION 
  logging.udf_GetRunComponentID
    (
        @RunComponentName   SYSNAME
    )
RETURNS
  SMALLINT
AS
BEGIN
  RETURN (  SELECT TOP 1 RunComponentID 
            FROM logging.RunComponent 
            WHERE RunComponentName = @RunComponentName  )
END

--CREATE SYNONYM dbo.rcid FOR logging.udf_GetRunComponentID