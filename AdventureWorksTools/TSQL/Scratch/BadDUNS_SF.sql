

SELECT
    MIN(l.CreatedDate)
  , MAX(l.CreatedDate)
FROM
  AdventureWorks_0022.dbo.Lead l
WHERE
      l.DUNS_Number__c IS NOT NULL
  AND ISNUMERIC(l.Duns_Number__c) <> 1




SELECT
    AccountId  = a.Id
  , DUNS    =  a.DUNS_Number__c
FROM
  AdventureWorks_0022.dbo.Account a
WHERE
      a.DUNS_Number__c IS NOT NULL
  AND ISNUMERIC(a.Duns_Number__c) <> 1





