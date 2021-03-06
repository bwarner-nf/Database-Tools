/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Stored Procedure DDL                                                                 │
  │   AdventureWorks_0006.dbo.usp_RespondersMasterList_ByDUNS_Upsert
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
      
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ────────────────────────────────────────────────────────────── │
      2018.11.12 bwarner         Initial Draft
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ UNIT TESTING SCRIPTS:                                                                       │

      EXEC dbo.usp_RespondersMasterList_ByDUNS_Upsert

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
          [object_id] = OBJECT_ID(N'dbo.usp_RespondersMasterList_ByDUNS_Upsert') 
      AND [type] IN(N'P', N'PC')
  )
	DROP PROCEDURE 
    dbo.usp_RespondersMasterList_ByDUNS_Upsert
GO

CREATE PROCEDURE 
  dbo.usp_RespondersMasterList_ByDUNS_Upsert
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
    dbo.RespondersMasterList_ByDUNS
      (
          DUNS
        , ResponseSourceID
      )
  SELECT DISTINCT
      DUNS = a.Duns_Number__c
    , ResponseSourceID = @thisResponseSourceID
  FROM
    AdventureWorks_0022.dbo.Account a
    LEFT JOIN
    dbo.RespondersMasterList_ByDUNS existing
      ON existing.DUNS = a.Duns_Number__c
  WHERE
    existing.DUNS IS NULL
    AND ISNUMERIC(a.Duns_Number__c) = 1

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
    dbo.RespondersMasterList_ByDUNS
      (
          DUNS
        , ResponseSourceID
      )
  SELECT DISTINCT
      DUNS = l.Duns_Number__c
    , ResponseSourceID = @thisResponseSourceID
  FROM
    AdventureWorks_0022.dbo.Lead l
    JOIN 
    AdventureWorks_0022.dbo.CampaignMember cm
      ON cm.LeadId   = l.ID
    --JOIN 
    --AdventureWorks_0022.dbo.Campaign c
    --  ON c.CampaignId   = l.Id
    LEFT JOIN
    dbo.RespondersMasterList_ByDUNS existing
      ON existing.DUNS = l.Duns_Number__c
  WHERE 
        cm.HasResponded = 'TRUE'
    AND l.Duns_Number__c IS NOT NULL
    AND existing.DUNS IS NULL
    AND ISNUMERIC(l.Duns_Number__c) = 1

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
    dbo.RespondersMasterList_ByDUNS
      (
          DUNS
        , ResponseSourceID
      )
  SELECT DISTINCT
      DUNS = l.DUNS_Number__c
    , ResponseSourceID = @thisResponseSourceID
  FROM
    AdventureWorks_0022.dbo.Lead l
    LEFT JOIN
    dbo.RespondersMasterList_ByDUNS existing
      ON existing.DUNS = l.DUNS_Number__c
  WHERE 
        l.DUNS_Number__c IS NOT NULL
    AND existing.DUNS IS NULL
    AND l.[Status] <> 'House'
    AND ISNUMERIC(l.Duns_Number__c) = 1

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
    dbo.RespondersMasterList_ByDUNS
      (
          DUNS
        , ResponseSourceID
      )
  SELECT DISTINCT
      DUNS = l.DUNS_Number__c
    , ResponseSourceID = @thisResponseSourceID
  FROM
    AdventureWorks_0022.dbo.Lead l
    LEFT JOIN
    dbo.RespondersMasterList_ByDUNS existing
      ON existing.DUNS = l.DUNS_Number__c
  WHERE 
        l.DUNS_Number__c IS NOT NULL
    AND existing.DUNS IS NULL
    AND l.Marketing_Scrub__c  = 'TRUE'
    AND ISNUMERIC(l.Duns_Number__c) = 1            

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
    dbo.RespondersMasterList_ByDUNS
      (
          DUNS
        , ResponseSourceID
      )
  SELECT DISTINCT
      DUNS = l.DUNS_Number__c
    , ResponseSourceID = @thisResponseSourceID
  FROM
    AdventureWorks_0022.dbo.Lead l
    LEFT JOIN
    dbo.RespondersMasterList_ByDUNS existing
      ON existing.DUNS = l.DUNS_Number__c
  WHERE 
        l.DUNS_Number__c IS NOT NULL
    AND existing.DUNS IS NULL
    AND l.Out_Of_Business__c  = 'TRUE'
    AND ISNUMERIC(l.Duns_Number__c) = 1

  /* 'Responder File Matched 1 */
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
    dbo.RespondersMasterList_ByDUNS
      (
          DUNS
        , ResponseSourceID
      )
  SELECT DISTINCT
      DUNS = rf1.DUNS
    , ResponseSourceID = @thisResponseSourceID
  FROM
    AdventureWorks_0007.dbo.NF_Matching_DUNS_1 rf1
    LEFT JOIN
    dbo.RespondersMasterList_ByDUNS existing
      ON existing.DUNS = rf1.DUNS
  WHERE 
        rf1.DUNS IS NOT NULL
    AND existing.DUNS IS NULL

  /* 'Responder File Matched 2 */
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
    dbo.RespondersMasterList_ByDUNS
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
    dbo.RespondersMasterList_ByDUNS existing
      ON existing.DUNS = rf2.DUNS
  WHERE 
        rf2.DUNS IS NOT NULL
    AND existing.DUNS IS NULL

END
GO





