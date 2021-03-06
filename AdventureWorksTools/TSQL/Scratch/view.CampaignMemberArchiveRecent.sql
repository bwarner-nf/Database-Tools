USE [AdventureWorks_0001]
GO

/****** Object:  View [dbo].[CampaignMemberArchiveRecent]    Script Date: 12/31/2018 12:06:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO









CREATE View [dbo].[CampaignMemberArchiveRecent]

as


-- Return most recent years
SELECT 
[Account_Number__c]
      ,[Activation_Code__c]
      ,[CampaignId]
      ,[ContactId]
      ,[CreatedById]
      ,[CreatedDate]
      ,[FirstRespondedDate]
      ,[HasResponded]
      ,[Id]
      ,[IsDeleted]
      ,[LastModifiedById]
      ,[LastModifiedDate]
      ,[LeadId]
      ,[Response_Rep__c]
      ,[Short_Account_Number__c]
      ,[Status]
      ,[SystemModstamp]
      ,[X1st_Response_Date__c]

 FROM AdventureWorks_0001.dbo.CampaignMemberArchive2014
UNION ALL
SELECT 
[Account_Number__c]
      ,[Activation_Code__c]
      ,[CampaignId]
      ,[ContactId]
      ,[CreatedById]
      ,[CreatedDate]
      ,[FirstRespondedDate]
      ,[HasResponded]
      ,[Id]
      ,[IsDeleted]
      ,[LastModifiedById]
      ,[LastModifiedDate]
      ,[LeadId]
      ,[Response_Rep__c]
      ,[Short_Account_Number__c]
      ,[Status]
      ,[SystemModstamp]
      ,[X1st_Response_Date__c]
FROM AdventureWorks_0001.dbo.CampaignMemberArchive2015
UNION ALL
SELECT 
[Account_Number__c]
      ,[Activation_Code__c]
      ,[CampaignId]
      ,[ContactId]
      ,[CreatedById]
      ,[CreatedDate]
      ,[FirstRespondedDate]
      ,[HasResponded]
      ,[Id]
      ,[IsDeleted]
      ,[LastModifiedById]
      ,[LastModifiedDate]
      ,[LeadId]
      ,[Response_Rep__c]
      ,[Short_Account_Number__c]
      ,[Status]
      ,[SystemModstamp]
      ,[X1st_Response_Date__c]
FROM AdventureWorks_0001.dbo.CampaignMemberArchive2016





GO





