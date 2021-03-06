 
USE AdventureWorks_0006
GO

DECLARE @ErrMsg VARCHAR(2047) = ''         
         

--/*+---------------------------------------------------------------------+*\.
--  | Create User Permissions for Database User: CORP\Accounting          |
--  | Department                                                          |
--\*+---------------------------------------------------------------------+*/


--RAISERROR ('Create User Permissions for Database User: CORP\Accounting Department', 10,1) WITH NOWAIT
--  BEGIN TRY
 
--IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'CORP\Accounting Department')
--CREATE USER [CORP\Accounting Department] FOR LOGIN [CORP\Accounting Department]


--  END TRY
--  BEGIN CATCH
--    SET @ErrMsg = REPLICATE(' ',4) + ERROR_MESSAGE() + ISNULL(' ' + ERROR_PROCEDURE(),'') + ISNULL(' LINE:' + LTRIM(STR(ERROR_LINE())),'')
--    RAISERROR(@ErrMsg, 10, 1) WITH NOWAIT
--  END CATCH


--  /*+---------------------------------------------------------------------+*\.
--    | Add CORP\Accounting Department to Role db_datareader                |
--  \*+---------------------------------------------------------------------+*/

--  RAISERROR ('Add CORP\Accounting Department to Role db_datareader', 10,1) WITH NOWAIT
--  BEGIN TRY
--    IF NOT IS_ROLEMEMBER(N'db_datareader', N'CORP\Accounting Department') = 1
--      EXEC sp_addrolemember
--          @rolename   = N'db_datareader'
--        , @membername = N'CORP\Accounting Department'
--  END TRY
--  BEGIN CATCH
--    SET @ErrMsg = REPLICATE(' ',4) + ERROR_MESSAGE() + ISNULL(' ' + ERROR_PROCEDURE(),'') + ISNULL(' LINE:' + LTRIM(STR(ERROR_LINE())),'')
--    RAISERROR(@ErrMsg, 10, 1) WITH NOWAIT
--  END CATCH
 

--  /*+---------------------------------------------------------------------+*\.
--    | Granting CONNECT to DbPrincipal CORP\Accounting Department on AdventureWorks_0007   |
--  \*+---------------------------------------------------------------------+*/

 
--  RAISERROR ('Granting CONNECT to DbPrincipal CORP\Accounting Department on AdventureWorks_0007', 10,1) WITH NOWAIT
 
--  BEGIN TRY
--    IF NOT EXISTS
--      (
--        SELECT TOP 1
--          *
--        FROM
--          sys.database_permissions perm
--          JOIN
--          sys.database_principals grantee
--             ON perm.grantee_principal_id = grantee.principal_id
--          JOIN
--          sys.database_principals grantor
--             ON perm.grantor_principal_id = grantor.principal_id
--        WHERE
--          perm.[permission_name]  = 'CONNECT'
--          AND perm.state_desc     = 'Grant'
--          AND grantee.name        = 'CORP\Accounting Department'
--      )
--    GRANT
--      CONNECT
--    TO
--      [CORP\Accounting Department]
--  END TRY
--  BEGIN CATCH
--    SET @ErrMsg = REPLICATE(' ',4) + ERROR_MESSAGE() + ISNULL(' ' + ERROR_PROCEDURE(),'') + ISNULL(' LINE:' + LTRIM(STR(ERROR_LINE())),'')
--    RAISERROR(@ErrMsg, 10, 1) WITH NOWAIT
--  END CATCH


/*+---------------------------------------------------------------------+*\.
  | Create User Permissions for Database User: CORP\bwarner             |
\*+---------------------------------------------------------------------+*/


RAISERROR ('Create User Permissions for Database User: CORP\bwarner', 10,1) WITH NOWAIT
  BEGIN TRY
 
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'CORP\bwarner')
CREATE USER [CORP\bwarner] FOR LOGIN [CORP\bwarner] WITH DEFAULT_SCHEMA=[CORP\bwarner]


  END TRY
  BEGIN CATCH
    SET @ErrMsg = REPLICATE(' ',4) + ERROR_MESSAGE() + ISNULL(' ' + ERROR_PROCEDURE(),'') + ISNULL(' LINE:' + LTRIM(STR(ERROR_LINE())),'')
    RAISERROR(@ErrMsg, 10, 1) WITH NOWAIT
  END CATCH


/*+---------------------------------------------------------------------+*\.
  | Create User Permissions for Database User: CORP\DWAdmins            |
\*+---------------------------------------------------------------------+*/


RAISERROR ('Create User Permissions for Database User: CORP\DWAdmins', 10,1) WITH NOWAIT
  BEGIN TRY
 
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'CORP\DWAdmins')
CREATE USER [CORP\DWAdmins] FOR LOGIN [CORP\DWAdmins]


  END TRY
  BEGIN CATCH
    SET @ErrMsg = REPLICATE(' ',4) + ERROR_MESSAGE() + ISNULL(' ' + ERROR_PROCEDURE(),'') + ISNULL(' LINE:' + LTRIM(STR(ERROR_LINE())),'')
    RAISERROR(@ErrMsg, 10, 1) WITH NOWAIT
  END CATCH


  /*+---------------------------------------------------------------------+*\.
    | Add CORP\DWAdmins to Role db_owner                                  |
  \*+---------------------------------------------------------------------+*/

  RAISERROR ('Add CORP\DWAdmins to Role db_owner', 10,1) WITH NOWAIT
  BEGIN TRY
    IF NOT IS_ROLEMEMBER(N'db_owner', N'CORP\DWAdmins') = 1
      EXEC sp_addrolemember
          @rolename   = N'db_owner'
        , @membername = N'CORP\DWAdmins'
  END TRY
  BEGIN CATCH
    SET @ErrMsg = REPLICATE(' ',4) + ERROR_MESSAGE() + ISNULL(' ' + ERROR_PROCEDURE(),'') + ISNULL(' LINE:' + LTRIM(STR(ERROR_LINE())),'')
    RAISERROR(@ErrMsg, 10, 1) WITH NOWAIT
  END CATCH
 

  /*+---------------------------------------------------------------------+*\.
    | Granting CONNECT to DbPrincipal CORP\DWAdmins on AdventureWorks_0007                |
  \*+---------------------------------------------------------------------+*/

 
  RAISERROR ('Granting CONNECT to DbPrincipal CORP\DWAdmins on AdventureWorks_0007', 10,1) WITH NOWAIT
 
  BEGIN TRY
    IF NOT EXISTS
      (
        SELECT TOP 1
          *
        FROM
          sys.database_permissions perm
          JOIN
          sys.database_principals grantee
             ON perm.grantee_principal_id = grantee.principal_id
          JOIN
          sys.database_principals grantor
             ON perm.grantor_principal_id = grantor.principal_id
        WHERE
          perm.[permission_name]  = 'CONNECT'
          AND perm.state_desc     = 'Grant'
          AND grantee.name        = 'CORP\DWAdmins'
      )
    GRANT
      CONNECT
    TO
      [CORP\DWAdmins]
  END TRY
  BEGIN CATCH
    SET @ErrMsg = REPLICATE(' ',4) + ERROR_MESSAGE() + ISNULL(' ' + ERROR_PROCEDURE(),'') + ISNULL(' LINE:' + LTRIM(STR(ERROR_LINE())),'')
    RAISERROR(@ErrMsg, 10, 1) WITH NOWAIT
  END CATCH


--/*+---------------------------------------------------------------------+*\.
--  | Create User Permissions for Database User: CORP\jfong               |
--\*+---------------------------------------------------------------------+*/


--RAISERROR ('Create User Permissions for Database User: CORP\jfong', 10,1) WITH NOWAIT
--  BEGIN TRY
 
--IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'CORP\jfong')
--CREATE USER [CORP\jfong] FOR LOGIN [CORP\jfong] WITH DEFAULT_SCHEMA=[CORP\jfong]


--  END TRY
--  BEGIN CATCH
--    SET @ErrMsg = REPLICATE(' ',4) + ERROR_MESSAGE() + ISNULL(' ' + ERROR_PROCEDURE(),'') + ISNULL(' LINE:' + LTRIM(STR(ERROR_LINE())),'')
--    RAISERROR(@ErrMsg, 10, 1) WITH NOWAIT
--  END CATCH


--/*+---------------------------------------------------------------------+*\.
--  | Create User Permissions for Database User: CORP\MarketingAnalytics  |
--\*+---------------------------------------------------------------------+*/


--RAISERROR ('Create User Permissions for Database User: CORP\MarketingAnalytics', 10,1) WITH NOWAIT
--  BEGIN TRY
 
--IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'CORP\MarketingAnalytics')
--CREATE USER [CORP\MarketingAnalytics] FOR LOGIN [CORP\MarketingAnalytics]


--  END TRY
--  BEGIN CATCH
--    SET @ErrMsg = REPLICATE(' ',4) + ERROR_MESSAGE() + ISNULL(' ' + ERROR_PROCEDURE(),'') + ISNULL(' LINE:' + LTRIM(STR(ERROR_LINE())),'')
--    RAISERROR(@ErrMsg, 10, 1) WITH NOWAIT
--  END CATCH


--  /*+---------------------------------------------------------------------+*\.
--    | Add CORP\MarketingAnalytics to Role db_executor                     |
--  \*+---------------------------------------------------------------------+*/

--  RAISERROR ('Add CORP\MarketingAnalytics to Role db_executor', 10,1) WITH NOWAIT
--  BEGIN TRY
--    IF NOT IS_ROLEMEMBER(N'db_executor', N'CORP\MarketingAnalytics') = 1
--      EXEC sp_addrolemember
--          @rolename   = N'db_executor'
--        , @membername = N'CORP\MarketingAnalytics'
--  END TRY
--  BEGIN CATCH
--    SET @ErrMsg = REPLICATE(' ',4) + ERROR_MESSAGE() + ISNULL(' ' + ERROR_PROCEDURE(),'') + ISNULL(' LINE:' + LTRIM(STR(ERROR_LINE())),'')
--    RAISERROR(@ErrMsg, 10, 1) WITH NOWAIT
--  END CATCH
 

--  /*+---------------------------------------------------------------------+*\.
--    | Add CORP\MarketingAnalytics to Role db_ddladmin                     |
--  \*+---------------------------------------------------------------------+*/

--  RAISERROR ('Add CORP\MarketingAnalytics to Role db_ddladmin', 10,1) WITH NOWAIT
--  BEGIN TRY
--    IF NOT IS_ROLEMEMBER(N'db_ddladmin', N'CORP\MarketingAnalytics') = 1
--      EXEC sp_addrolemember
--          @rolename   = N'db_ddladmin'
--        , @membername = N'CORP\MarketingAnalytics'
--  END TRY
--  BEGIN CATCH
--    SET @ErrMsg = REPLICATE(' ',4) + ERROR_MESSAGE() + ISNULL(' ' + ERROR_PROCEDURE(),'') + ISNULL(' LINE:' + LTRIM(STR(ERROR_LINE())),'')
--    RAISERROR(@ErrMsg, 10, 1) WITH NOWAIT
--  END CATCH
 

--  /*+---------------------------------------------------------------------+*\.
--    | Add CORP\MarketingAnalytics to Role db_datareader                   |
--  \*+---------------------------------------------------------------------+*/

--  RAISERROR ('Add CORP\MarketingAnalytics to Role db_datareader', 10,1) WITH NOWAIT
--  BEGIN TRY
--    IF NOT IS_ROLEMEMBER(N'db_datareader', N'CORP\MarketingAnalytics') = 1
--      EXEC sp_addrolemember
--          @rolename   = N'db_datareader'
--        , @membername = N'CORP\MarketingAnalytics'
--  END TRY
--  BEGIN CATCH
--    SET @ErrMsg = REPLICATE(' ',4) + ERROR_MESSAGE() + ISNULL(' ' + ERROR_PROCEDURE(),'') + ISNULL(' LINE:' + LTRIM(STR(ERROR_LINE())),'')
--    RAISERROR(@ErrMsg, 10, 1) WITH NOWAIT
--  END CATCH
 

--  /*+---------------------------------------------------------------------+*\.
--    | Add CORP\MarketingAnalytics to Role db_datawriter                   |
--  \*+---------------------------------------------------------------------+*/

--  RAISERROR ('Add CORP\MarketingAnalytics to Role db_datawriter', 10,1) WITH NOWAIT
--  BEGIN TRY
--    IF NOT IS_ROLEMEMBER(N'db_datawriter', N'CORP\MarketingAnalytics') = 1
--      EXEC sp_addrolemember
--          @rolename   = N'db_datawriter'
--        , @membername = N'CORP\MarketingAnalytics'
--  END TRY
--  BEGIN CATCH
--    SET @ErrMsg = REPLICATE(' ',4) + ERROR_MESSAGE() + ISNULL(' ' + ERROR_PROCEDURE(),'') + ISNULL(' LINE:' + LTRIM(STR(ERROR_LINE())),'')
--    RAISERROR(@ErrMsg, 10, 1) WITH NOWAIT
--  END CATCH
 

--  /*+---------------------------------------------------------------------+*\.
--    | Granting CONNECT to DbPrincipal CORP\MarketingAnalytics on AdventureWorks_0007      |
--  \*+---------------------------------------------------------------------+*/

 
--  RAISERROR ('Granting CONNECT to DbPrincipal CORP\MarketingAnalytics on AdventureWorks_0007', 10,1) WITH NOWAIT
 
--  BEGIN TRY
--    IF NOT EXISTS
--      (
--        SELECT TOP 1
--          *
--        FROM
--          sys.database_permissions perm
--          JOIN
--          sys.database_principals grantee
--             ON perm.grantee_principal_id = grantee.principal_id
--          JOIN
--          sys.database_principals grantor
--             ON perm.grantor_principal_id = grantor.principal_id
--        WHERE
--          perm.[permission_name]  = 'CONNECT'
--          AND perm.state_desc     = 'Grant'
--          AND grantee.name        = 'CORP\MarketingAnalytics'
--      )
--    GRANT
--      CONNECT
--    TO
--      [CORP\MarketingAnalytics]
--  END TRY
--  BEGIN CATCH
--    SET @ErrMsg = REPLICATE(' ',4) + ERROR_MESSAGE() + ISNULL(' ' + ERROR_PROCEDURE(),'') + ISNULL(' LINE:' + LTRIM(STR(ERROR_LINE())),'')
--    RAISERROR(@ErrMsg, 10, 1) WITH NOWAIT
--  END CATCH


--/*+---------------------------------------------------------------------+*\.
--  | Create User Permissions for Database User: CORP\ModelAnalytics      |
--\*+---------------------------------------------------------------------+*/


--RAISERROR ('Create User Permissions for Database User: CORP\ModelAnalytics', 10,1) WITH NOWAIT
--  BEGIN TRY
 
--IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'CORP\ModelAnalytics')
--CREATE USER [CORP\ModelAnalytics] FOR LOGIN [CORP\ModelAnalytics]


--  END TRY
--  BEGIN CATCH
--    SET @ErrMsg = REPLICATE(' ',4) + ERROR_MESSAGE() + ISNULL(' ' + ERROR_PROCEDURE(),'') + ISNULL(' LINE:' + LTRIM(STR(ERROR_LINE())),'')
--    RAISERROR(@ErrMsg, 10, 1) WITH NOWAIT
--  END CATCH


--  /*+---------------------------------------------------------------------+*\.
--    | Add CORP\ModelAnalytics to Role db_executor                         |
--  \*+---------------------------------------------------------------------+*/

--  RAISERROR ('Add CORP\ModelAnalytics to Role db_executor', 10,1) WITH NOWAIT
--  BEGIN TRY
--    IF NOT IS_ROLEMEMBER(N'db_executor', N'CORP\ModelAnalytics') = 1
--      EXEC sp_addrolemember
--          @rolename   = N'db_executor'
--        , @membername = N'CORP\ModelAnalytics'
--  END TRY
--  BEGIN CATCH
--    SET @ErrMsg = REPLICATE(' ',4) + ERROR_MESSAGE() + ISNULL(' ' + ERROR_PROCEDURE(),'') + ISNULL(' LINE:' + LTRIM(STR(ERROR_LINE())),'')
--    RAISERROR(@ErrMsg, 10, 1) WITH NOWAIT
--  END CATCH
 

--  /*+---------------------------------------------------------------------+*\.
--    | Add CORP\ModelAnalytics to Role db_datareader                       |
--  \*+---------------------------------------------------------------------+*/

--  RAISERROR ('Add CORP\ModelAnalytics to Role db_datareader', 10,1) WITH NOWAIT
--  BEGIN TRY
--    IF NOT IS_ROLEMEMBER(N'db_datareader', N'CORP\ModelAnalytics') = 1
--      EXEC sp_addrolemember
--          @rolename   = N'db_datareader'
--        , @membername = N'CORP\ModelAnalytics'
--  END TRY
--  BEGIN CATCH
--    SET @ErrMsg = REPLICATE(' ',4) + ERROR_MESSAGE() + ISNULL(' ' + ERROR_PROCEDURE(),'') + ISNULL(' LINE:' + LTRIM(STR(ERROR_LINE())),'')
--    RAISERROR(@ErrMsg, 10, 1) WITH NOWAIT
--  END CATCH
 

--  /*+---------------------------------------------------------------------+*\.
--    | Granting CONNECT to DbPrincipal CORP\ModelAnalytics on AdventureWorks_0007          |
--  \*+---------------------------------------------------------------------+*/

 
--  RAISERROR ('Granting CONNECT to DbPrincipal CORP\ModelAnalytics on AdventureWorks_0007', 10,1) WITH NOWAIT
 
--  BEGIN TRY
--    IF NOT EXISTS
--      (
--        SELECT TOP 1
--          *
--        FROM
--          sys.database_permissions perm
--          JOIN
--          sys.database_principals grantee
--             ON perm.grantee_principal_id = grantee.principal_id
--          JOIN
--          sys.database_principals grantor
--             ON perm.grantor_principal_id = grantor.principal_id
--        WHERE
--          perm.[permission_name]  = 'CONNECT'
--          AND perm.state_desc     = 'Grant'
--          AND grantee.name        = 'CORP\ModelAnalytics'
--      )
--    GRANT
--      CONNECT
--    TO
--      [CORP\ModelAnalytics]
--  END TRY
--  BEGIN CATCH
--    SET @ErrMsg = REPLICATE(' ',4) + ERROR_MESSAGE() + ISNULL(' ' + ERROR_PROCEDURE(),'') + ISNULL(' LINE:' + LTRIM(STR(ERROR_LINE())),'')
--    RAISERROR(@ErrMsg, 10, 1) WITH NOWAIT
--  END CATCH


--/*+---------------------------------------------------------------------+*\.
--  | Create User Permissions for Database User: CORP\omouradi            |
--\*+---------------------------------------------------------------------+*/


--RAISERROR ('Create User Permissions for Database User: CORP\omouradi', 10,1) WITH NOWAIT
--  BEGIN TRY
 
--IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'CORP\omouradi')
--CREATE USER [CORP\omouradi] FOR LOGIN [CORP\omouradi] WITH DEFAULT_SCHEMA=[dbo]


--  END TRY
--  BEGIN CATCH
--    SET @ErrMsg = REPLICATE(' ',4) + ERROR_MESSAGE() + ISNULL(' ' + ERROR_PROCEDURE(),'') + ISNULL(' LINE:' + LTRIM(STR(ERROR_LINE())),'')
--    RAISERROR(@ErrMsg, 10, 1) WITH NOWAIT
--  END CATCH


--  /*+---------------------------------------------------------------------+*\.
--    | Add CORP\omouradi to Role db_owner                                  |
--  \*+---------------------------------------------------------------------+*/

--  RAISERROR ('Add CORP\omouradi to Role db_owner', 10,1) WITH NOWAIT
--  BEGIN TRY
--    IF NOT IS_ROLEMEMBER(N'db_owner', N'CORP\omouradi') = 1
--      EXEC sp_addrolemember
--          @rolename   = N'db_owner'
--        , @membername = N'CORP\omouradi'
--  END TRY
--  BEGIN CATCH
--    SET @ErrMsg = REPLICATE(' ',4) + ERROR_MESSAGE() + ISNULL(' ' + ERROR_PROCEDURE(),'') + ISNULL(' LINE:' + LTRIM(STR(ERROR_LINE())),'')
--    RAISERROR(@ErrMsg, 10, 1) WITH NOWAIT
--  END CATCH
 

--  /*+---------------------------------------------------------------------+*\.
--    | Granting CONNECT to DbPrincipal CORP\omouradi on AdventureWorks_0007                |
--  \*+---------------------------------------------------------------------+*/

 
--  RAISERROR ('Granting CONNECT to DbPrincipal CORP\omouradi on AdventureWorks_0007', 10,1) WITH NOWAIT
 
--  BEGIN TRY
--    IF NOT EXISTS
--      (
--        SELECT TOP 1
--          *
--        FROM
--          sys.database_permissions perm
--          JOIN
--          sys.database_principals grantee
--             ON perm.grantee_principal_id = grantee.principal_id
--          JOIN
--          sys.database_principals grantor
--             ON perm.grantor_principal_id = grantor.principal_id
--        WHERE
--          perm.[permission_name]  = 'CONNECT'
--          AND perm.state_desc     = 'Grant'
--          AND grantee.name        = 'CORP\omouradi'
--      )
--    GRANT
--      CONNECT
--    TO
--      [CORP\omouradi]
--  END TRY
--  BEGIN CATCH
--    SET @ErrMsg = REPLICATE(' ',4) + ERROR_MESSAGE() + ISNULL(' ' + ERROR_PROCEDURE(),'') + ISNULL(' LINE:' + LTRIM(STR(ERROR_LINE())),'')
--    RAISERROR(@ErrMsg, 10, 1) WITH NOWAIT
--  END CATCH


--/*+---------------------------------------------------------------------+*\.
--  | Create User Permissions for Database User: CORP\sannett             |
--\*+---------------------------------------------------------------------+*/


--RAISERROR ('Create User Permissions for Database User: CORP\sannett', 10,1) WITH NOWAIT
--  BEGIN TRY
 
--IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'CORP\sannett')
--CREATE USER [CORP\sannett] FOR LOGIN [CORP\sannett] WITH DEFAULT_SCHEMA=[CORP\sannett]


--  END TRY
--  BEGIN CATCH
--    SET @ErrMsg = REPLICATE(' ',4) + ERROR_MESSAGE() + ISNULL(' ' + ERROR_PROCEDURE(),'') + ISNULL(' LINE:' + LTRIM(STR(ERROR_LINE())),'')
--    RAISERROR(@ErrMsg, 10, 1) WITH NOWAIT
--  END CATCH


/*+---------------------------------------------------------------------+*\.
  | Create User Permissions for Database User: DWJobOwner               |
\*+---------------------------------------------------------------------+*/


RAISERROR ('Create User Permissions for Database User: DWJobOwner', 10,1) WITH NOWAIT
  BEGIN TRY
 
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'DWJobOwner')
CREATE USER [DWJobOwner] FOR LOGIN [DWJobOwner] WITH DEFAULT_SCHEMA=[dbo]


  END TRY
  BEGIN CATCH
    SET @ErrMsg = REPLICATE(' ',4) + ERROR_MESSAGE() + ISNULL(' ' + ERROR_PROCEDURE(),'') + ISNULL(' LINE:' + LTRIM(STR(ERROR_LINE())),'')
    RAISERROR(@ErrMsg, 10, 1) WITH NOWAIT
  END CATCH


  /*+---------------------------------------------------------------------+*\.
    | Add DWJobOwner to Role db_owner                                     |
  \*+---------------------------------------------------------------------+*/

  RAISERROR ('Add DWJobOwner to Role db_owner', 10,1) WITH NOWAIT
  BEGIN TRY
    IF NOT IS_ROLEMEMBER(N'db_owner', N'DWJobOwner') = 1
      EXEC sp_addrolemember
          @rolename   = N'db_owner'
        , @membername = N'DWJobOwner'
  END TRY
  BEGIN CATCH
    SET @ErrMsg = REPLICATE(' ',4) + ERROR_MESSAGE() + ISNULL(' ' + ERROR_PROCEDURE(),'') + ISNULL(' LINE:' + LTRIM(STR(ERROR_LINE())),'')
    RAISERROR(@ErrMsg, 10, 1) WITH NOWAIT
  END CATCH
 

  /*+---------------------------------------------------------------------+*\.
    | Granting CONNECT to DbPrincipal DWJobOwner on AdventureWorks_0007                   |
  \*+---------------------------------------------------------------------+*/

 
  RAISERROR ('Granting CONNECT to DbPrincipal DWJobOwner on AdventureWorks_0007', 10,1) WITH NOWAIT
 
  BEGIN TRY
    IF NOT EXISTS
      (
        SELECT TOP 1
          *
        FROM
          sys.database_permissions perm
          JOIN
          sys.database_principals grantee
             ON perm.grantee_principal_id = grantee.principal_id
          JOIN
          sys.database_principals grantor
             ON perm.grantor_principal_id = grantor.principal_id
        WHERE
          perm.[permission_name]  = 'CONNECT'
          AND perm.state_desc     = 'Grant'
          AND grantee.name        = 'DWJobOwner'
      )
    GRANT
      CONNECT
    TO
      DWJobOwner
  END TRY
  BEGIN CATCH
    SET @ErrMsg = REPLICATE(' ',4) + ERROR_MESSAGE() + ISNULL(' ' + ERROR_PROCEDURE(),'') + ISNULL(' LINE:' + LTRIM(STR(ERROR_LINE())),'')
    RAISERROR(@ErrMsg, 10, 1) WITH NOWAIT
  END CATCH


/*+---------------------------------------------------------------------+*\.
  | Create User Permissions for Database User: Tableau                  |
\*+---------------------------------------------------------------------+*/


RAISERROR ('Create User Permissions for Database User: Tableau', 10,1) WITH NOWAIT
  BEGIN TRY
 
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Tableau')
CREATE USER [Tableau] FOR LOGIN [Tableau] WITH DEFAULT_SCHEMA=[dbo]


  END TRY
  BEGIN CATCH
    SET @ErrMsg = REPLICATE(' ',4) + ERROR_MESSAGE() + ISNULL(' ' + ERROR_PROCEDURE(),'') + ISNULL(' LINE:' + LTRIM(STR(ERROR_LINE())),'')
    RAISERROR(@ErrMsg, 10, 1) WITH NOWAIT
  END CATCH


  /*+---------------------------------------------------------------------+*\.
    | Add Tableau to Role db_owner                                        |
  \*+---------------------------------------------------------------------+*/

  RAISERROR ('Add Tableau to Role db_owner', 10,1) WITH NOWAIT
  BEGIN TRY
    IF NOT IS_ROLEMEMBER(N'db_owner', N'Tableau') = 1
      EXEC sp_addrolemember
          @rolename   = N'db_owner'
        , @membername = N'Tableau'
  END TRY
  BEGIN CATCH
    SET @ErrMsg = REPLICATE(' ',4) + ERROR_MESSAGE() + ISNULL(' ' + ERROR_PROCEDURE(),'') + ISNULL(' LINE:' + LTRIM(STR(ERROR_LINE())),'')
    RAISERROR(@ErrMsg, 10, 1) WITH NOWAIT
  END CATCH
 

  /*+---------------------------------------------------------------------+*\.
    | Granting CONNECT to DbPrincipal Tableau on AdventureWorks_0007                      |
  \*+---------------------------------------------------------------------+*/

 
  RAISERROR ('Granting CONNECT to DbPrincipal Tableau on AdventureWorks_0007', 10,1) WITH NOWAIT
 
  BEGIN TRY
    IF NOT EXISTS
      (
        SELECT TOP 1
          *
        FROM
          sys.database_permissions perm
          JOIN
          sys.database_principals grantee
             ON perm.grantee_principal_id = grantee.principal_id
          JOIN
          sys.database_principals grantor
             ON perm.grantor_principal_id = grantor.principal_id
        WHERE
          perm.[permission_name]  = 'CONNECT'
          AND perm.state_desc     = 'Grant'
          AND grantee.name        = 'Tableau'
      )
    GRANT
      CONNECT
    TO
      Tableau
  END TRY
  BEGIN CATCH
    SET @ErrMsg = REPLICATE(' ',4) + ERROR_MESSAGE() + ISNULL(' ' + ERROR_PROCEDURE(),'') + ISNULL(' LINE:' + LTRIM(STR(ERROR_LINE())),'')
    RAISERROR(@ErrMsg, 10, 1) WITH NOWAIT
  END CATCH







