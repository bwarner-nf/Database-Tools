/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Stored Procedure DDL                                                                 │
  │   AdventureWorks_0006.stage.usp_UnpackHotlist
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
      
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ────────────────────────────────────────────────────────────── │
      2018.10.06 bwarner         Initial Draft
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ UNIT TESTING SCRIPTS:                                                                       │

      EXEC stage.usp_UnpackHotlist @Param01 = 'Phu-Barr'

\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE AdventureWorks_0006
GO

IF EXISTS 
  (
    SELECT 
      * 
    FROM 
      sys.objects 
    WHERE 
          [object_id] = OBJECT_ID(N'stage.usp_UnpackHotlist') 
      AND [type] IN(N'P', N'PC')
  )
	DROP PROCEDURE 
    stage.usp_UnpackHotlist
GO

CREATE PROCEDURE 
  stage.usp_UnpackHotlist
    (
        @Param01   VARCHAR(64)
    )
AS
BEGIN

  INSERT
    dbo.HotListFinal
      (
          DUNS
        , HotList
      )
  SELECT
      Duns
    , Hotlist
  FROM
    #Hotlist_import
  UNPIVOT
    (
      IsInHotlist
      FOR 
        Hotlist
          IN
            (
                NewtotheWorld
              , NewLegalEntity
              , NewtotheFile
              , OwnershipChange
              , CEOChange
              , CompanyNameChange
              , AddressChange
              , PhoneChange
            )
    ) x
  WHERE
    LEFT(IsInHotlist,1) = 'Y'

  IF (SELECT Row_Count = COUNT(*) FROM dbo.HotListFinal) = 0
    BEGIN

      SELECT
          @ErrMsg = 'No records where inserted into table dbo.HotListFinal'
        , @ErrSvr = 11

      RAISERROR 
        (
            @ErrMsg
          , @ErrSvr -- Severity 
          , 2       -- State
        )

END
GO





