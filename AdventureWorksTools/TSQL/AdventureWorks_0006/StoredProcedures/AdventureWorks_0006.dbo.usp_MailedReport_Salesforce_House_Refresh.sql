/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Stored Procedure DDL                                                                 │
  │   AdventureWorks_0006.dbo.usp_MailedReport_Salesforce_House_Refresh
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
      
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ────────────────────────────────────────────────────────────── │
      2018.12.27 bwarner         Initial Draft
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ UNIT TESTING SCRIPTS:                                                                       │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤

      EXEC dbo.usp_MailedReport_Salesforce_House_Refresh 

      EXEC dbo.usp_MailedReport_Salesforce_House_Refresh @RebuildAll = 1

  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ Run Component Configure                                                                     │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤

    DECLARE @RunComponentID SMALLINT

    EXEC logging.usp_RunComponent_Add
        @RunComponentName     = 'usp_MailedReport_Salesforce_House_Refresh' 
      , @RunComponentDesc     = 'Updates the master MailSuppressionsByDUNS list that suppressies mail by DUNS'
      , @ParentRunComponentID = NULL
      , @SequentialPosition   = NULL
      , @RunComponentID       = @RunComponentID OUTPUT

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
          [object_id] = OBJECT_ID(N'dbo.usp_MailedReport_Salesforce_House_Refresh') 
      AND [type] IN(N'P', N'PC')
  )
	DROP PROCEDURE 
    dbo.usp_MailedReport_Salesforce_House_Refresh
GO

CREATE PROCEDURE 
  dbo.usp_MailedReport_Salesforce_House_Refresh
    (
        @RebuildAll   BIT = 0
    )
WITH RECOMPILE
AS
BEGIN

  SET NOCOUNT ON

  DECLARE
      @RunLogID     BIGINT
    , @RowsAffected BIGINT
    , @MailWeekAsOf DATETIME 

  /* Sproc RunLog Start */
  EXEC logging.usp_RunLog_LogBegin 
      @ParentRunLogID   = NULL
    , @RunComponentName = 'usp_MailedReport_Salesforce_House_Refresh'
    , @RunLogID         = @RunLogID OUTPUT

  /*┌────────────────────────────────────────────────────────────────────┐*
      Rebuild Case: use achived campain members and one-off corrections
      for old campains; truncate and rebuild all rows
  \*└────────────────────────────────────────────────────────────────────┘*/
  IF @RebuildAll = 1
    BEGIN

      SELECT @RowsAffected = COUNT_BIG(*) FROM AdventureWorks_0006.dbo.MailedReport_Salesforce_House

      TRUNCATE TABLE
        AdventureWorks_0006.dbo.MailedReport_Salesforce_House

      EXEC logging.usp_RowsAffected_Log 
          @RunLogID       = @RunLogID
        , @OperationType  = 'delete'
        , @RowsAffected   = @RowsAffected
        , @ObjectName     = 'MailedReport_Salesforce_House'

      ;WITH 
        CampainMemberWithArchive AS
          (
            SELECT 
                Id
              , CampaignId
              , FirstRespondedDate
              , ContactId
              , LeadId
              , Response_Rep__c
              , Account_Number__c
            FROM 
              AdventureWorks_0022.dbo.CampaignMember

            UNION ALL

            SELECT 
                Id
              , CampaignId
              , FirstRespondedDate
              , ContactId
              , LeadId
              , Response_Rep__c
              , Account_Number__c
            FROM 
              AdventureWorks_0001.dbo.CampaignMemberArchiveRecent
          )
      INSERT
        AdventureWorks_0006.dbo.MailedReport_Salesforce_House
          (
              CampaignId
            , CampaignMemberId
            , LeadId 
            , ContactId
            , AccountId
            , AccountNo
            , MailWeek
          )
      SELECT 
          CampaignId        = c.Id
        , CampaignMemberId  = cm.Id
        , LeadId            = cm.LeadId
        , ContactId         = cm.ContactId
        , AccountId         = cnt.AccountId
        , AccountNo         = cm.Account_Number__c --Account_Number__c
        , MailWeek          = CASE
                                WHEN c.StartDate <= '3/31/14'
                                  THEN c.StartDate
                                WHEN YEAR(c.StartDate) = 2014 AND DATEPART(weekday, c.StartDate) >= 3
                                  THEN DATEADD(week, CAST(SUBSTRING(cm.Account_Number__c, 5, 1) AS INT) - 1, DATEADD(day, 9 - DATEPART(weekday, c.StartDate), c.StartDate))
                                WHEN YEAR(c.StartDate) = 2014 AND DATEPART(weekday, c.StartDate) = 1
                                  THEN DATEADD(week, CAST(SUBSTRING(cm.Account_Number__c, 5, 1) AS INT) - 1, DATEADD(day, 1, c.StartDate))
                                WHEN c.StartDate = '8/24/15' AND SUBSTRING(cm.Account_Number__c, 5, 1) = '3'
                                  THEN CAST('8/24/15' AS DATETIME)
                                WHEN c.StartDate = '8/24/15' AND SUBSTRING(cm.Account_Number__c, 5, 1) = '4'
                                  THEN CAST('8/31/15' AS DATETIME)
                                WHEN c.StartDate = '8/24/15' AND SUBSTRING(cm.Account_Number__c, 5, 1) = '5'
                                  THEN CAST('9/7/15' AS DATETIME)
                                WHEN c.StartDate = '8/24/15' AND SUBSTRING(cm.Account_Number__c, 5, 1) = '1'
                                  THEN CAST('9/14/15' AS DATETIME)
                                WHEN c.StartDate = '8/24/15' AND SUBSTRING(cm.Account_Number__c, 5, 1) = '2'
                                  THEN CAST('9/21/15' AS DATETIME)
                                ELSE DATEADD(week, ISNULL(CAST(SUBSTRING(cm.Account_Number__c, 5, 1) AS INT), 1) - 1, c.StartDate)
                              END
      FROM 
        AdventureWorks_0022.dbo.Campaign c
        JOIN
        CampainMemberWithArchive cm
          ON c.Id = cm.CampaignId --To get AccountId from Contacts
        LEFT JOIN
        AdventureWorks_0022.dbo.Contact cnt
          ON cm.ContactId = cnt.Id
      WHERE
            c.[Type] = 'Direct Mail'
        AND c.Prospect_Type__c IN('House', 'Customer')
        AND c.StartDate >= '1/1/14'

      SET @RowsAffected = @@ROWCOUNT

      EXEC logging.usp_RowsAffected_Log 
          @RunLogID       = @RunLogID
        , @OperationType  = 'insert'
        , @RowsAffected   = @RowsAffected
        , @ObjectName     = 'MailedReport_Salesforce_House'

    END

  /*┌────────────────────────────────────────────────────────────────────┐*
      Standard Case: use simplified logic and only add new rows
  \*└────────────────────────────────────────────────────────────────────┘*/
  ELSE

    BEGIN

      SELECT
        @MailWeekAsOf = MAX(MailWeek)
      FROM
        AdventureWorks_0006.dbo.MailedReport_Salesforce_House

      INSERT
        AdventureWorks_0006.dbo.MailedReport_Salesforce_House
          (
              CampaignId
            , CampaignMemberId
            , LeadId 
            , ContactId
            , AccountId
            , AccountNo
            , MailWeek
          )
      SELECT 
          CampaignId        = c.Id
        , CampaignMemberId  = cm.Id
        , LeadId            = cm.LeadId
        , ContactId         = cm.ContactId
        , AccountId         = cnt.AccountId
        , AccountNo         = cm.Account_Number__c --Account_Number__c
        , MailWeek          = DATEADD(week, ISNULL(CAST(SUBSTRING(cm.Account_Number__c, 5, 1) AS INT), 1) - 1, c.StartDate)
      FROM 
        AdventureWorks_0022.dbo.Campaign c
        JOIN
        AdventureWorks_0022.dbo.CampaignMember cm
          ON c.Id = cm.CampaignId --To get AccountId from Contacts
        LEFT JOIN
        AdventureWorks_0022.dbo.Contact cnt
          ON cm.ContactId = cnt.Id
      WHERE
            c.[Type] = 'Direct Mail'
        AND c.Prospect_Type__c IN('House', 'Customer')
        AND DATEADD(week, ISNULL(CAST(SUBSTRING(cm.Account_Number__c, 5, 1) AS INT), 1) - 1, c.StartDate) > @MailWeekAsOf

      SET @RowsAffected = @@ROWCOUNT

      EXEC logging.usp_RowsAffected_Log 
          @RunLogID       = @RunLogID
        , @OperationType  = 'insert'
        , @RowsAffected   = @RowsAffected
        , @ObjectName     = 'MailedReport_Salesforce_House'

    END

  /* Sproc RunLog End */
  EXEC logging.usp_RunLog_LogEnd 
      @RunLogID   =  @RunLogID
    , @ReturnCode = NULL
    , @Suceeded   = 1

END
GO




