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

declare  @thisResponseSourceID tinyint

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

  SELECT
          x.DUNS
        , ResponseSourceID = @thisResponseSourceID
  FROM
    (


    SELECT DISTINCT
      y.DUNS
    FROM
      (

  SELECT 
      DUNS = a.Duns_Number__c
  FROM
    AdventureWorks_0022.dbo.Account a



  UNION ALL

  SELECT 
      DUNS = l.Duns_Number__c

  FROM
    AdventureWorks_0022.dbo.Lead l
    JOIN 
    AdventureWorks_0022.dbo.CampaignMember cm
      ON cm.LeadId   = l.ID
    --JOIN 
    --AdventureWorks_0022.dbo.Campaign c
    --  ON c.CampaignId   = l.Id

  WHERE 
        cm.HasResponded = 'TRUE'
    or  l.Out_Of_Business__c  = 'TRUE'
    or  l.Marketing_Scrub__c  = 'TRUE'
    or  l.[Status] <> 'House'


    ) y


    ) x
    LEFT JOIN
    dbo.RespondersMasterList_ByDUNS existing
      ON existing.DUNS = x.DUNS
    WHERE
      existing.DUNS IS NULL
      AND x.DUNS IS NOT NULL
      AND ISNUMERIC(x.DUNS) = 1


  --/* Grab ALL Duns numbers from Non-house Leads when lead is inserted the lead status defaults to house?, until they respond
  --    --todo:DOUBLE CHECK DEFAULT */
  -- SELECT 
  --    @thisResponseSourceID = (
  --                              SELECT 
  --                                ResponseSourceID 
  --                              FROM 
  --                                dbo.ResponseSource 
  --                              WHERE 
  --                                ResponseSourceName = 'Non-House-Status Leads'
  --                            )

  --INSERT
  --  dbo.RespondersMasterList_ByDUNS
  --    (
  --        DUNS
  --      , ResponseSourceID
  --    )


  --/* Marketing Scrub Leads */
  -- SELECT 
  --    @thisResponseSourceID = (
  --                              SELECT 
  --                                ResponseSourceID 
  --                              FROM 
  --                                dbo.ResponseSource 
  --                              WHERE 
  --                                ResponseSourceName = 'Marketing Scrub Leads'
  --                            )

  --INSERT
  --  dbo.RespondersMasterList_ByDUNS
  --    (
  --        DUNS
  --      , ResponseSourceID
  --    )
          

  --/* 'Out of Business Leads' */

  -- SELECT 
  --    @thisResponseSourceID = (
  --                              SELECT 
  --                                ResponseSourceID 
  --                              FROM 
  --                                dbo.ResponseSource 
  --                              WHERE 
  --                                ResponseSourceName = 'Out of Business Leads'
  --                            )

  --INSERT
  --  dbo.RespondersMasterList_ByDUNS
  --    (
  --        DUNS
  --      , ResponseSourceID
  --    )


  --/* 'Responder File Matched 1 */
  -- SELECT 
  --    @thisResponseSourceID = (
  --                              SELECT 
  --                                ResponseSourceID 
  --                              FROM 
  --                                dbo.ResponseSource 
  --                              WHERE 
  --                                ResponseSourceName = 'Responder File Matched 1'
  --                            )

  --INSERT
  --  dbo.RespondersMasterList_ByDUNS
  --    (
  --        DUNS
  --      , ResponseSourceID
  --    )


  --/* 'Responder File Matched 2 */
  -- SELECT 
  --    @thisResponseSourceID = (
  --                              SELECT 
  --                                ResponseSourceID 
  --                              FROM 
  --                                dbo.ResponseSource 
  --                              WHERE 
  --                                ResponseSourceName = 'Responder File Matched 2'
  --                            )

  --INSERT
  --  dbo.RespondersMasterList_ByDUNS
  --    (
  --        DUNS
  --      , ResponseSourceID
  --    )


END
GO





