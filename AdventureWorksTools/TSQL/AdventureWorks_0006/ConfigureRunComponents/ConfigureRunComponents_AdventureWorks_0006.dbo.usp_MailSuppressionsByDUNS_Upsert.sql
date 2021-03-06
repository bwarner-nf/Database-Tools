

USE AdventureWorks_0006
GO


SELECT * FROM logging.RunComponent

DECLARE 
    @RunComponentID_parent  SMALLINT 
  , @RunComponentID_child   SMALLINT

EXEC logging.usp_RunComponent_Add
    @RunComponentName     = 'usp_MailSuppressionsByDUNS_Upsert' 
  , @RunComponentDesc     = 'Updates the master MailSuppressionsByDUNS list that suppressies mail by DUNS'
  , @ParentRunComponentID = NULL
  , @SequentialPosition   = NULL
  , @RunComponentID       = @RunComponentID_parent OUTPUT

EXEC logging.usp_RunComponent_Add
    @RunComponentName     = 'Add Suppressions: Existing Accounts' 
  , @RunComponentDesc     = 'Suppress all Existing Salesforce Accounts'
  , @ParentRunComponentID = @RunComponentID_parent
  , @SequentialPosition   = 1
  , @RunComponentID       = @RunComponentID_child OUTPUT

EXEC logging.usp_RunComponent_Add
    @RunComponentName     = 'Add Suppressions: Campain Member Responders' 
  , @RunComponentDesc     = 'Suppress all Campaing members marked as "Has Responded"'
  , @ParentRunComponentID = @RunComponentID_parent
  , @SequentialPosition   = 2
  , @RunComponentID       = @RunComponentID_child OUTPUT

EXEC logging.usp_RunComponent_Add
    @RunComponentName     = 'Add Suppressions: Non-House Status Leads' 
  , @RunComponentDesc     = 'Suppress all Existing Salesforce Leads that do not have a status of "House", which is the default until they respond'
  , @ParentRunComponentID = @RunComponentID_parent
  , @SequentialPosition   = 3
  , @RunComponentID       = @RunComponentID_child OUTPUT

EXEC logging.usp_RunComponent_Add
    @RunComponentName     = 'Add Suppressions: Marketing Scrub Leads' 
  , @RunComponentDesc     = 'Suppress all Existing Salesforce Leads that are marked as "Marketing Scrub" = TRUE'
  , @ParentRunComponentID = @RunComponentID_parent
  , @SequentialPosition   = 4
  , @RunComponentID       = @RunComponentID_child OUTPUT

EXEC logging.usp_RunComponent_Add
    @RunComponentName     = 'Add Suppressions: Out of Business Leads' 
  , @RunComponentDesc     = 'Suppress all Existing Salesforce Leads that are marked as Out of Buisness'
  , @ParentRunComponentID = @RunComponentID_parent
  , @SequentialPosition   = 5
  , @RunComponentID       = @RunComponentID_child OUTPUT

EXEC logging.usp_RunComponent_Add
    @RunComponentName     = 'Add Suppressions: Responder File Matched 1' 
  , @RunComponentDesc     = 'This is adding suppressions from an old responder match file'
  , @ParentRunComponentID = @RunComponentID_parent
  , @SequentialPosition   = 6
  , @RunComponentID       = @RunComponentID_child OUTPUT


EXEC logging.usp_RunComponent_Add
    @RunComponentName     = 'Add Suppressions: Responder File Matched 2' 
  , @RunComponentDesc     = 'This is adding suppressions from an old responder match file'
  , @ParentRunComponentID = @RunComponentID_parent
  , @SequentialPosition   = 7
  , @RunComponentID       = @RunComponentID_child OUTPUT






