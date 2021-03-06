/*â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”*\
  â”‚ TITLE: Stored Procedure DDL                                                                 â”‚
  â”‚   AdventureWorks_0006.dbo.usp_MailSuppressionsByDUNS_Upsert
  â”œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¤
  â”‚ DESCRIPTION:                                                                                â”‚
      
  â”œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¤
  â”‚ REVISION HISTORY:                                                                           â”‚
  â”œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¤
  â”‚   DATE       AUTHOR          CHANGE DESCRIPTION                                             â”‚
  â”‚   â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ â”‚
      2018.11.12 bwarner         Initial Draft
  â”œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¤
  â”‚ UNIT TESTING SCRIPTS:                                                                       â”‚

      EXEC dbo.usp_MailSuppressionsByDUNS_Upsert @IncludeOldPreMatched = 1

      EXEC dbo.usp_MailSuppressionsByDUNS_Upsert @IncludeOldPreMatched = 1

      SELECT TOP 1000 * 
      FROM dbo.MailSuppressionsByDUNS

      SELECT
          x.DUNS
        , x.SalesForceID
        , x.SuppressionSource
      FROM
        (
          SELECT 
              ms.DUNS
            , ms.SalesForceID
            , SuppressionSource = mss.MailSuppressionSourceName
            , rn = ROW_NUMBER() OVER (PARTITION BY ms.MailSuppressionSourceID ORDER BY ms.DUNS)
          FROM 
            dbo.MailSuppressionsByDUNS ms
            JOIN
            dbo.MailSuppressionSource mss
              ON ms.MailSuppressionSourceID = mss.MailSuppressionSourceID
        ) x
      WHERE
        x.rn <= 25

      -- TRUNCATE TABLE dbo.MailSuppressionsByDUNS




BEGIN TRANSACTION

DECLARE 
    @RunComponentID_parent  SMALLINT 
  , @RunComponentID_child   SMALLINT 

SELECT @RunComponentID_parent = RunComponentID 
FROM logging.RunComponent 
WHERE RunComponentName = 'usp_MailSuppressionsByDUNS_Upsert' 

EXEC logging.usp_RunComponent_Add
    @RunComponentName     = 'SF_Refresh: Account, Lead, CampaingMember'
  , @RunComponentDesc     = 'Runs SF_Refresh on __SERVER_INSTANCE_NAME__''s AdventureWorks_0022e for  Account, Lead, CampaingMember'
  , @ParentRunComponentID = @RunComponentID_parent
  , @SequentialPosition   = 0
  , @RunComponentID       = @RunComponentID_child OUTPUT


SELECT * FROM logging.RunComponent WHERE ParentRunComponentID = @RunComponentID_parent

UPDATE  logging.RunComponent SET SequentialPosition += 1 WHERE ParentRunComponentID = @RunComponentID_parent


SELECT * FROM logging.RunComponent WHERE ParentRunComponentID = @RunComponentID_parent



--COMMIT TRANSACTION

ROLLBACK TRANSACTION


\*â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜*/



USE AdventureWorks_0006
GO

IF EXISTS 
  (
    SELECT 
      * 
    FROM 
      sys.objects 
    WHERE 
          [object_id] = OBJECT_ID(N'dbo.usp_MailSuppressionsByDUNS_Upsert') 
      AND [type] IN(N'P', N'PC')
  )
  DROP PROCEDURE 
    dbo.usp_MailSuppressionsByDUNS_Upsert
GO

CREATE PROCEDURE 
  dbo.usp_MailSuppressionsByDUNS_Upsert
    (
        @IncludeOldPreMatched BIT = 0 -- Only set to 1 for first run (adds old static premached responder list)
    )
WITH RECOMPILE
AS
BEGIN

  SET NOCOUNT ON

  DECLARE
      @thisMailSuppressionSourceID  TINYINT
    , @RunLogID_sproc               BIGINT
    , @RunLogID_step                BIGINT
    , @RowsAffected_sproc           BIGINT = 0
    , @RowsAffected_step            BIGINT

  /* Sproc RunLog Start */
  EXEC logging.usp_RunLog_LogBegin 
      @ParentRunLogID   = NULL
    , @RunComponentName = 'usp_MailSuppressionsByDUNS_Upsert'
    , @RunLogID         = @RunLogID_sproc OUTPUT



  /*â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”*.
      Pull fresh Salesforce reference data
  \*â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜*/
  SET @RunLogID_step = NULL
  EXEC logging.usp_RunLog_LogBegin 
      @ParentRunLogID   = @RunLogID_sproc
    , @RunComponentName = 'SF_Refresh: Account, Lead, CampaingMember'
    , @RunLogID         = @RunLogID_step OUTPUT


    EXEC AdventureWorks_0022.dbo.SF_Refresh 
        @table_server = 'SALESFORCE'
      , @table_name   = 'Account'

    EXEC AdventureWorks_0022.dbo.SF_Refresh 
        @table_server = 'SALESFORCE'
      , @table_name   = 'Lead'

    EXEC AdventureWorks_0022.dbo.SF_Refresh 
        @table_server = 'SALESFORCE'
      , @table_name   = 'CampaignMember'

  /*â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”*.
      Existing SF Accounts
  \*â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜*/
  SET @RunLogID_step = NULL
  EXEC logging.usp_RunLog_LogBegin 
      @ParentRunLogID   = @RunLogID_sproc
    , @RunComponentName = 'Add Suppressions: Existing Accounts'
    , @RunLogID         = @RunLogID_step OUTPUT

  SELECT 
    @thisMailSuppressionSourceID =  (
                                      SELECT 
                                        MailSuppressionSourceID 
                                      FROM 
                                        dbo.MailSuppressionSource 
                                      WHERE 
                                        MailSuppressionSourceName = 'Salesforce Accounts'
                                    )

  INSERT
    dbo.MailSuppressionsByDUNS
      (
          DUNS
        , MailSuppressionSourceID
        , SalesForceID
      )
  SELECT
      DUNS
    , MailSuppressionSourceID
    , AccountID
  FROM
    (
      SELECT 
          DUNS                    = a.Duns_Number__c
        , MailSuppressionSourceID = @thisMailSuppressionSourceID
        , AccountID               = a.Id
        , rn = ROW_NUMBER() OVER(PARTITION BY a.Duns_Number__c ORDER BY a.Id)
      FROM
        AdventureWorks_0022.dbo.Account a
        LEFT JOIN
        dbo.MailSuppressionsByDUNS existing
          ON existing.DUNS = a.Duns_Number__c
      WHERE
        existing.DUNS IS NULL
        AND ISNUMERIC(a.Duns_Number__c) = 1
    ) x
  WHERE
    x.rn = 1

  SET @RowsAffected_step = @@ROWCOUNT
  SET @RowsAffected_sproc += @RowsAffected_step

  EXEC logging.usp_RowsAffected_Log 
      @RunLogID       = @RunLogID_step
    , @OperationType  = 'insert'
    , @RowsAffected   = @RowsAffected_step
    , @ObjectName     = 'MailSuppressionsByDUNS'

  EXEC logging.usp_RunLog_LogEnd 
      @RunLogID   = @RunLogID_step
    , @ReturnCode = NULL
    , @DidSucceed = 1

  /*â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”*.
      Grab ALL Duns numbers FROM Has Responded leads
  \*â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜*/
  SET @RunLogID_step = NULL
  EXEC logging.usp_RunLog_LogBegin 
      @ParentRunLogID   = @RunLogID_sproc
    , @RunComponentName = 'Add Suppressions: Campain Member Responders' 
    , @RunLogID         = @RunLogID_step OUTPUT

    SELECT 
      @thisMailSuppressionSourceID = (
                                        SELECT 
                                          MailSuppressionSourceID 
                                        FROM 
                                          dbo.MailSuppressionSource 
                                        WHERE 
                                          MailSuppressionSourceName = 'Responed Campain Members'
                                      )
  INSERT
    dbo.MailSuppressionsByDUNS
      (
          DUNS
        , MailSuppressionSourceID
        , SalesForceID
      )
  SELECT
      DUNS
    , MailSuppressionSourceID
    , LeadID
  FROM
    (
      SELECT 
          DUNS              = l.Duns_Number__c
        , MailSuppressionSourceID = @thisMailSuppressionSourceID
        , LeadID                  = l.Id
        , rn = ROW_NUMBER() OVER(PARTITION BY l.Duns_Number__c ORDER BY l.Id)
      FROM
        AdventureWorks_0022.dbo.Lead l
        JOIN 
        AdventureWorks_0022.dbo.CampaignMember cm
          ON cm.LeadId = l.ID
        --JOIN 
        --AdventureWorks_0022.dbo.Campaign c
        --  ON c.CampaignId   = l.Id
        LEFT JOIN
        dbo.MailSuppressionsByDUNS existing
          ON existing.DUNS = l.Duns_Number__c
      WHERE 
            cm.HasResponded = 'TRUE'
        AND l.Duns_Number__c IS NOT NULL
        AND existing.DUNS IS NULL
        AND ISNUMERIC(l.Duns_Number__c) = 1
    ) x
  WHERE
    x.rn = 1

  SET @RowsAffected_step = @@ROWCOUNT
  SET @RowsAffected_sproc += @RowsAffected_step

  EXEC logging.usp_RowsAffected_Log 
      @RunLogID       = @RunLogID_step
    , @OperationType  = 'insert'
    , @RowsAffected   = @RowsAffected_step
    , @ObjectName     = 'MailSuppressionsByDUNS'

  EXEC logging.usp_RunLog_LogEnd 
      @RunLogID   =  @RunLogID_step
    , @ReturnCode = NULL
    , @DidSucceed   = 1

  /*â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”*.
      Grab ALL Duns numbers from Non-house Leads when lead is inserted the 
      lead status defaults to house?, until they respond
        todo:DOUBLE CHECK DEFAULT
  \*â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜*/
  SET @RunLogID_step = NULL
  EXEC logging.usp_RunLog_LogBegin 
      @ParentRunLogID   = @RunLogID_sproc
    , @RunComponentName = 'Add Suppressions: Non-House Status Leads' 
    , @RunLogID         = @RunLogID_step OUTPUT

    SELECT 
      @thisMailSuppressionSourceID =  (
                                        SELECT 
                                          MailSuppressionSourceID 
                                        FROM 
                                          dbo.MailSuppressionSource 
                                        WHERE 
                                          MailSuppressionSourceName = 'Non-House-Status Leads'
                                      )

  INSERT
    dbo.MailSuppressionsByDUNS
      (
          DUNS
        , MailSuppressionSourceID
        , SalesForceID
      )
  SELECT
      DUNS
    , MailSuppressionSourceID
    , LeadID
  FROM
    (
      SELECT 
          DUNS                    = l.DUNS_Number__c
        , MailSuppressionSourceID = @thisMailSuppressionSourceID
        , LeadID                  = l.Id
        , rn = ROW_NUMBER() OVER(PARTITION BY l.Duns_Number__c ORDER BY l.Id)
      FROM
        AdventureWorks_0022.dbo.Lead l
        LEFT JOIN
        dbo.MailSuppressionsByDUNS existing
          ON existing.DUNS = l.DUNS_Number__c
      WHERE 
            l.DUNS_Number__c IS NOT NULL
        AND existing.DUNS IS NULL
        AND l.[Status] <> 'House'
        AND ISNUMERIC(l.Duns_Number__c) = 1
    ) x
  WHERE
    x.rn = 1

  SET @RowsAffected_step = @@ROWCOUNT
  SET @RowsAffected_sproc += @RowsAffected_step

  EXEC logging.usp_RowsAffected_Log 
      @RunLogID       = @RunLogID_step
    , @OperationType  = 'insert'
    , @RowsAffected   = @RowsAffected_step
    , @ObjectName     = 'MailSuppressionsByDUNS'

  EXEC logging.usp_RunLog_LogEnd 
      @RunLogID   =  @RunLogID_step
    , @ReturnCode = NULL
    , @DidSucceed   = 1

  /*â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”*.
      Marketing Scrub Leads
  \*â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜*/
  SET @RunLogID_step = NULL
  EXEC logging.usp_RunLog_LogBegin 
      @ParentRunLogID   = NULL
    , @RunComponentName = 'Add Suppressions: Marketing Scrub Leads' 
    , @RunLogID         = @RunLogID_step OUTPUT

    SELECT 
      @thisMailSuppressionSourceID =  (
                                        SELECT 
                                          MailSuppressionSourceID 
                                        FROM 
                                          dbo.MailSuppressionSource 
                                        WHERE 
                                          MailSuppressionSourceName = 'Marketing Scrub Leads'
                                      )

  INSERT
    dbo.MailSuppressionsByDUNS
      (
          DUNS
        , MailSuppressionSourceID
        , SalesForceID
      )
  SELECT
      DUNS
    , MailSuppressionSourceID
    , LeadID
  FROM
    (
      SELECT 
          DUNS                    = l.DUNS_Number__c
        , MailSuppressionSourceID = @thisMailSuppressionSourceID
        , LeadID                  = l.Id
        , rn = ROW_NUMBER() OVER(PARTITION BY l.Duns_Number__c ORDER BY l.Id)
      FROM
        AdventureWorks_0022.dbo.Lead l
        LEFT JOIN
        dbo.MailSuppressionsByDUNS existing
          ON existing.DUNS = l.DUNS_Number__c
      WHERE 
            l.DUNS_Number__c IS NOT NULL
        AND existing.DUNS IS NULL
        AND l.Marketing_Scrub__c  = 'TRUE'
        AND ISNUMERIC(l.Duns_Number__c) = 1   
    ) x
  WHERE
    x.rn = 1

  SET @RowsAffected_step = @@ROWCOUNT
  SET @RowsAffected_sproc += @RowsAffected_step

  EXEC logging.usp_RowsAffected_Log 
      @RunLogID       = @RunLogID_step
    , @OperationType  = 'insert'
    , @RowsAffected   = @RowsAffected_step
    , @ObjectName     = 'MailSuppressionsByDUNS'

  EXEC logging.usp_RunLog_LogEnd 
      @RunLogID   =  @RunLogID_step
    , @ReturnCode = NULL
    , @DidSucceed   = 1

  /*â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”*.
      Out of Business Leads
  \*â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜*/
  SET @RunLogID_step = NULL
  EXEC logging.usp_RunLog_LogBegin 
      @ParentRunLogID   = NULL
    , @RunComponentName = 'Add Suppressions: Out of Business Leads' 
    , @RunLogID         = @RunLogID_step OUTPUT

  SELECT 
    @thisMailSuppressionSourceID =  (
                                      SELECT 
                                        MailSuppressionSourceID 
                                      FROM 
                                        dbo.MailSuppressionSource 
                                      WHERE 
                                        MailSuppressionSourceName = 'Out of Business Leads'
                                    )

  INSERT
    dbo.MailSuppressionsByDUNS
      (
          DUNS
        , MailSuppressionSourceID
        , SalesForceID
      )
  SELECT
      DUNS
    , MailSuppressionSourceID
    , LeadID
  FROM
    (
      SELECT
          DUNS                    = l.DUNS_Number__c
        , MailSuppressionSourceID = @thisMailSuppressionSourceID
        , LeadID                  = l.Id
        , rn = ROW_NUMBER() OVER(PARTITION BY l.Duns_Number__c ORDER BY l.Id)
      FROM
        AdventureWorks_0022.dbo.Lead l
        LEFT JOIN
        dbo.MailSuppressionsByDUNS existing
          ON existing.DUNS = l.DUNS_Number__c
      WHERE 
            l.DUNS_Number__c IS NOT NULL
        AND existing.DUNS IS NULL
        AND l.Out_Of_Business__c  = 'TRUE'
        AND ISNUMERIC(l.Duns_Number__c) = 1
    ) x
  WHERE
    x.rn = 1

  SET @RowsAffected_step = @@ROWCOUNT
  SET @RowsAffected_sproc += @RowsAffected_step

  EXEC logging.usp_RowsAffected_Log 
      @RunLogID       = @RunLogID_step
    , @OperationType  = 'insert'
    , @RowsAffected   = @RowsAffected_step
    , @ObjectName     = 'MailSuppressionsByDUNS'

  EXEC logging.usp_RunLog_LogEnd 
      @RunLogID   = @RunLogID_step
    , @ReturnCode = NULL
    , @DidSucceed = 1


  /*â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”*.
      Include Old Static Pre-Matched Responder Files
  \*â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜*/
  IF @IncludeOldPreMatched = 1
    BEGIN
      /*â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”*.
          Responder File Matched 1 
      \*â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜*/
      SET @RunLogID_step = NULL
      EXEC logging.usp_RunLog_LogBegin 
          @ParentRunLogID   = NULL
        , @RunComponentName = 'Add Suppressions: Responder File Matched 1' 
        , @RunLogID         = @RunLogID_step OUTPUT

        SELECT 
          @thisMailSuppressionSourceID =  (
                                            SELECT 
                                              MailSuppressionSourceID 
                                            FROM 
                                              dbo.MailSuppressionSource 
                                            WHERE 
                                              MailSuppressionSourceName = 'Responder File Matched 1'
                                          )
      INSERT
        dbo.MailSuppressionsByDUNS
          (
              DUNS
            , MailSuppressionSourceID
            , SalesForceID
          )
      SELECT
          DUNS                    = rf1.DUNS
        , MailSuppressionSourceID = @thisMailSuppressionSourceID
        , rf1.SalesForceID
      FROM
        dbo.ResponderMatchFile1 rf1
        LEFT JOIN
        dbo.MailSuppressionsByDUNS existing
          ON existing.DUNS = rf1.DUNS
      WHERE 
            rf1.DUNS IS NOT NULL
        AND existing.DUNS IS NULL

      SET @RowsAffected_step = @@ROWCOUNT
      SET @RowsAffected_sproc += @RowsAffected_step

      EXEC logging.usp_RowsAffected_Log 
          @RunLogID       = @RunLogID_step
        , @OperationType  = 'insert'
        , @RowsAffected   = @RowsAffected_step
        , @ObjectName     = 'MailSuppressionsByDUNS'

      EXEC logging.usp_RunLog_LogEnd 
          @RunLogID   =  @RunLogID_step
        , @ReturnCode = NULL
        , @DidSucceed   = 1

    /*â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”*.
        Responder File Matched 2
    \*â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜*/
      SET @RunLogID_step = NULL
      EXEC logging.usp_RunLog_LogBegin 
          @ParentRunLogID   = NULL
        , @RunComponentName = 'Add Suppressions: Responder File Matched 2' 
        , @RunLogID         = @RunLogID_step OUTPUT

        SELECT 
          @thisMailSuppressionSourceID =  (
                                            SELECT 
                                              MailSuppressionSourceID 
                                            FROM 
                                              dbo.MailSuppressionSource 
                                            WHERE 
                                              MailSuppressionSourceName = 'Responder File Matched 2'
                                          )

      INSERT
        dbo.MailSuppressionsByDUNS
          (
              DUNS
            , MailSuppressionSourceID
          )
      SELECT
          DUNS                    = rf2.DUNS
        , MailSuppressionSourceID = @thisMailSuppressionSourceID
      FROM
        dbo.ResponderMatchFile2 rf2
        LEFT JOIN
        dbo.MailSuppressionsByDUNS existing
          ON existing.DUNS = rf2.DUNS
      WHERE 
            rf2.DUNS IS NOT NULL
        AND existing.DUNS IS NULL

      SET @RowsAffected_step = @@ROWCOUNT
      SET @RowsAffected_sproc += @RowsAffected_step

      EXEC logging.usp_RowsAffected_Log 
          @RunLogID       = @RunLogID_step
        , @OperationType  = 'insert'
        , @RowsAffected   = @RowsAffected_step
        , @ObjectName     = 'MailSuppressionsByDUNS'

      EXEC logging.usp_RunLog_LogEnd 
          @RunLogID   =  @RunLogID_step
        , @ReturnCode = NULL
        , @DidSucceed   = 1
    END


  EXEC logging.usp_RowsAffected_Log 
      @RunLogID       = @RunLogID_sproc
    , @OperationType  = 'insert'
    , @RowsAffected   = @RowsAffected_sproc
    , @ObjectName     = 'MailSuppressionsByDUNS'
    , @IsTotal        = 1

  /* Sproc RunLog End */
  EXEC logging.usp_RunLog_LogEnd 
      @RunLogID   = @RunLogID_sproc
    , @ReturnCode = NULL
    , @DidSucceed = 1

END
GO







