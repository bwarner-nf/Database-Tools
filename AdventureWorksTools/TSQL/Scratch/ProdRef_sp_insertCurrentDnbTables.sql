USE [AdventureWorks_0007]
GO

/****** Object:  StoredProcedure [dbo].[sp_insertCurrentDnbTables]    Script Date: 11/27/2018 9:26:44 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_insertCurrentDnbTables]
(
    @YYYYMM CHAR(6),
    @doClass2 BIT = 0
)
AS
BEGIN

    EXEC [sp_createCurrentDnbTables]

    DECLARE @dir VARCHAR(MAX) = '\\mynetwork\share\Departments\BusinessIntelligence\D&B\MI Data Exports\'+@YYYYMM+'\'

    EXEC [sp_bulkInsertTables]
            @DIRECTORY = @dir
        , @DBNAME = 'dnb'
        , @TBLNAME = 'DnbHotList_current'
        , @FILENAME = 'HotListFinal'
        , @extension = 'txt'
        , @delimiter = ','

    ALTER TABLE [dbo].[DnbHotList_current] ADD AutoId INT IDENTITY(1,1)

    EXEC [sp_bulkInsertTables]
            @DIRECTORY = @dir
        , @DBNAME = 'dnb'
        , @TBLNAME = 'DnbNoNames_current'
        , @FILENAME = 'Q3 MI Data Extract_NoName - Obay'
        , @extension = 'txt'
        , @delimiter = '|'

    ALTER TABLE [dbo].DnbNoNames_current ADD AutoId INT IDENTITY(1,1)

    EXEC [sp_bulkInsertTables]
            @DIRECTORY = @dir
        , @DBNAME = 'dnb'
        , @TBLNAME = 'LicensedDnbBusinesses_current'
        , @FILENAME = 'Q2 MI Data Extract_LicensedNames 2'
        , @extension = 'txt'
        , @delimiter = '|'

    ALTER TABLE [dbo].LicensedDnbBusinesses_current ADD AutoId INT IDENTITY(1,1)

    EXEC [sp_bulkInsertTables]
            @DIRECTORY = @dir
        , @DBNAME = 'dnb'
        , @TBLNAME = 'OverallDnbBusinesses_current'
        , @FILENAME = 'Q1 MI Data Extract 2'
        , @extension = 'txt'
        , @delimiter = '|'

    IF @doClass2 = 1
    BEGIN 
	    EXEC [sp_bulkInsertTables]
		    @DIRECTORY = @dir,
		    @DBNAME = 'dnb',
		    @TBLNAME = 'DnbClass2_current',
		    @FILENAME = 'MI Data Extract_Class2_NoSIC',
		    @extension = 'txt',
		    @delimiter = '|'
			
	    EXEC [sp_bulkInsertTables]
		    @DIRECTORY = '\\mynetwork\share\Departments\BusinessIntelligence\D&B\MI Data Exports\201802\',
		    @DBNAME = 'dnb',
		    @TBLNAME = 'AdventureWorks_0007Class2Deliverability_current',
		    @FILENAME = 'Deliverability Score',
		    @extension = 'txt',
		    @delimiter = '|'

		UPDATE 
			[AdventureWorks_0007].[dbo].AdventureWorks_0007Class2Deliverability_current
		SET
			[Physical Address Accuracy] = NULL
		WHERE
			[Physical Address Accuracy] = 'N/A'
			OR [Physical Address Accuracy] = 'Unclassified'
			OR [Physical Address Accuracy] = ' !'
			OR [Physical Address Accuracy] = '99'
			OR ISNUMERIC([Physical Address Accuracy]) = 0
			
		ALTER TABLE [dnb].[dbo].AdventureWorks_0007Class2Deliverability_current ALTER COLUMN [Physical Address Accuracy] DECIMAL(18, 0)
    END 

    UPDATE [AdventureWorks_0007].[dbo].[OverallDnbBusinesses_current]
    SET
        [Custom Funded Model Score] = NULL
    WHERE
        [Custom Funded Model Score] = 'N/A'
        OR [Custom Funded Model Score] = 'Unclassified'
        OR [Custom Funded Model Score] = ' !'
        OR [Custom Funded Model Score] = '99'
        OR ISNUMERIC([Custom Funded Model Score]) = 0


    UPDATE [AdventureWorks_0007].[dbo].[OverallDnbBusinesses_current]
    SET
        [Custom Response Model Score] = NULL
    WHERE
        [Custom Response Model Score] = 'N/A'
        OR [Custom Response Model Score] = 'Unclassified'
        OR [Custom Response Model Score] = ' !'
        OR [Custom Response Model Score] = '99'
        OR ISNUMERIC([Custom Response Model Score]) = 0

    ALTER TABLE [dnb].[dbo].[OverallDnbBusinesses_current] ALTER COLUMN [Custom Response Model Score] DECIMAL(18, 0)
    ALTER TABLE [dnb].[dbo].[OverallDnbBusinesses_current] ALTER COLUMN [Custom Funded Model Score] DECIMAL(18, 0)
    ALTER TABLE [dnb].[dbo].[OverallDnbBusinesses_current] ALTER COLUMN [Emp Total] [BIGINT]
    ALTER TABLE [dnb].[dbo].[OverallDnbBusinesses_current] ALTER COLUMN [Sales Volume US] [BIGINT]

    ALTER TABLE [dbo].[OverallDnbBusinesses_current] ADD AutoId INT IDENTITY(1,1)

END
GO





