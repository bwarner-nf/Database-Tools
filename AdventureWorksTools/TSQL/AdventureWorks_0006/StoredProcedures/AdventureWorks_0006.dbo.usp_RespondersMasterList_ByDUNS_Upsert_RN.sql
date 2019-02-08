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

      EXEC dbo.usp_MailSuppressionsByDUNS_Upsert

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
AS
BEGIN

  DECLARE
    @thisResponseSourceID TINYINT

  /* Grab ALL Duns numbers from Account */
  SELECT 
    @thisResponseSourceID = (
                              SELECT 
                                ResponseSourceID 
                              FROM 
                                dbo.ResponseSource 
                              WHERE 
                                ResponseSourceName = 'Salesforce Accounts'
                            )

  INSERT
    dbo.MailSuppressionsByDUNS
      (
          DUNS
        , ResponseSourceID
      )
  SELECT
      DUNS
    , ResponseSourceID
  FROM
    (
      SELECT 
          DUNS              = a.Duns_Number__c
        , ResponseSourceID  = @thisResponseSourceID
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

  /* Grab ALL Duns numbers FROM Has Responded leads */
   SELECT 
      @thisResponseSourceID = (
                                SELECT 
                                  ResponseSourceID 
                                FROM 
                                  dbo.ResponseSource 
                                WHERE 
                                  ResponseSourceName = 'Responed Campain Members'
                              )
  INSERT
    dbo.MailSuppressionsByDUNS
      (
          DUNS
        , ResponseSourceID
      )
  SELECT
      DUNS
    , ResponseSourceID
  FROM
    (
      SELECT 
          DUNS              = l.Duns_Number__c
        , ResponseSourceID  = @thisResponseSourceID
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

  /* Grab ALL Duns numbers from Non-house Leads when lead is inserted the lead status defaults to house?, until they respond
      --todo:DOUBLE CHECK DEFAULT */
   SELECT 
      @thisResponseSourceID = (
                                SELECT 
                                  ResponseSourceID 
                                FROM 
                                  dbo.ResponseSource 
                                WHERE 
                                  ResponseSourceName = 'Non-House-Status Leads'
                              )

  INSERT
    dbo.MailSuppressionsByDUNS
      (
          DUNS
        , ResponseSourceID
      )
  SELECT
      DUNS
    , ResponseSourceID
  FROM
    (
      SELECT 
          DUNS              = l.DUNS_Number__c
        , ResponseSourceID  = @thisResponseSourceID
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
  /* Marketing Scrub Leads */
   SELECT 
      @thisResponseSourceID = (
                                SELECT 
                                  ResponseSourceID 
                                FROM 
                                  dbo.ResponseSource 
                                WHERE 
                                  ResponseSourceName = 'Marketing Scrub Leads'
                              )

  INSERT
    dbo.MailSuppressionsByDUNS
      (
          DUNS
        , ResponseSourceID
      )
  SELECT
      DUNS
    , ResponseSourceID
  FROM
    (
      SELECT 
          DUNS              = l.DUNS_Number__c
        , ResponseSourceID  = @thisResponseSourceID
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

  /* 'Out of Business Leads' */
   SELECT 
      @thisResponseSourceID = (
                                SELECT 
                                  ResponseSourceID 
                                FROM 
                                  dbo.ResponseSource 
                                WHERE 
                                  ResponseSourceName = 'Out of Business Leads'
                              )

  INSERT
    dbo.MailSuppressionsByDUNS
      (
          DUNS
        , ResponseSourceID
      )
  SELECT
      DUNS
    , ResponseSourceID
  FROM
    (
      SELECT
          DUNS = l.DUNS_Number__c
        , ResponseSourceID = @thisResponseSourceID
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


  /* 'Responder File Matched 1 
   SELECT 
      @thisResponseSourceID = (
                                SELECT 
                                  ResponseSourceID 
                                FROM 
                                  dbo.ResponseSource 
                                WHERE 
                                  ResponseSourceName = 'Responder File Matched 1'
                              )

  INSERT
    dbo.MailSuppressionsByDUNS
      (
          DUNS
        , ResponseSourceID
      )


  SELECT
      DUNS
    , ResponseSourceID
  FROM
    (
    , rn = ROW_NUMBER() OVER(PARTITION BY a.Duns_Number__c ORDER BY a.CreatedDate)

    ) x


  SELECT DISTINCT
      DUNS = rf1.DUNS
    , ResponseSourceID = @thisResponseSourceID
  FROM
    AdventureWorks_0007.dbo.NF_Matching_DUNS_1 rf1
    LEFT JOIN
    dbo.MailSuppressionsByDUNS existing
      ON existing.DUNS = rf1.DUNS
  WHERE 
        rf1.DUNS IS NOT NULL
    AND existing.DUNS IS NULL
*/
  /* 'Responder File Matched 2 
   SELECT 
      @thisResponseSourceID = (
                                SELECT 
                                  ResponseSourceID 
                                FROM 
                                  dbo.ResponseSource 
                                WHERE 
                                  ResponseSourceName = 'Responder File Matched 2'
                              )

  INSERT
    dbo.MailSuppressionsByDUNS
      (
          DUNS
        , ResponseSourceID
      )
  SELECT DISTINCT
      DUNS = rf2.DUNS
    , ResponseSourceID = @thisResponseSourceID
  FROM
    AdventureWorks_0007.dbo.NF_Matching_DUNS_2 rf2
    LEFT JOIN
    dbo.MailSuppressionsByDUNS existing
      ON existing.DUNS = rf2.DUNS
  WHERE 
        rf2.DUNS IS NOT NULL
    AND existing.DUNS IS NULL
*/
END
GO







