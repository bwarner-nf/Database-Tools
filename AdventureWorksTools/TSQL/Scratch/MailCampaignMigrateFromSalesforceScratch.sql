

DECLARE 
    @MailCylceDurrationID TINYINT
  , @MailingOrgID TINYINT

SELECT
  @MailCylceDurrationID = MailCycleDurrationID
FROM
  dbo.MailCycleDurration
WHERE
  MailCycleDurrationName = 'Monthly'

SELECT
  @MailingOrgID = MailingOrgID
FROM
  dbo.MailingOrg
WHERE
  MailingOrgName = 'National Funding'




;WITH MailWeeks AS
  (
    SELECT DISTINCT
      Week_Num
    FROM
      AdventureWorks_0001.dbo.Acq_Mail_Current
  )

INSERT
  dbo.Mailing
    (
        MailingOrgID
      , MailCycleDurrationID
      , SalesForceID
      , CycleStartDate
      , StartDate
      , EndDate
      , MailCampaignName
      , 
      , 
      , IsFinal
    )

  



          , SalesForceID          NCHAR(18)     NULL
          , StartDate             DATETIME      NULL
          , EndDate               DATETIME      NULL
          , MailCampaignName      NVARCHAR(80)  NOT NULL
          , MailingOrgID          TINYINT       NOT NULL
                                  CONSTRAINT
                                    FK_dbo_MailCampaign_MailingOrg
                                  FOREIGN KEY REFERENCES
                                    dbo.MailingOrg(MailingOrgID)
          , MailCycleDurrationID  TINYINT NOT NULL
                                    CONSTRAINT
                                    FK_dbo_MailCampaign_MailCycleDurrationID
                                  FOREIGN KEY REFERENCES
                                    dbo.MailCycleDurration(MailCycleDurrationID)
          , CycleStartDate        DATE NOT NULL



SELECT
    c.StartDate
  , c.Prospect_Type__c
  , c.[Name]
FROM
  AdventureWorks_0022.dbo.Campaign c
WHERE
      c.[TYPE] = 'direct mail'
  AND c.Prospect_Type__c IN('Acquisition','House')
  AND c.StartDate IS NOT NULL
  --AND c.Prospect_Type__c = 'acquisition'
ORDER BY
  1 desc,2,3





SELECT DISTINCT
    c.StartDate
  , c.EndDate
  , DATEDIFF(day,c.StartDate,c.EndDate)
  , c.Prospect_Type__c
  , c.[Name]
  , c.ParentId
FROM
  AdventureWorks_0022.dbo.Campaign c
WHERE
      c.[TYPE] = 'direct mail'
  AND c.Prospect_Type__c IN('Acquisition','House')
  AND c.StartDate IS NOT NULL
  AND c.ParentId IS NULL
  --AND c.Prospect_Type__c = 'acquisition'
ORDER BY
  1 desc,2,3


