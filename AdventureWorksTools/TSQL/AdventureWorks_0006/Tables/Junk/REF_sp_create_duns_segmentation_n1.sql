USE [AdventureWorks_0007]
GO

/****** Object:  StoredProcedure [dbo].[sp_create_duns_segmentation_n1]    Script Date: 12/19/2018 3:11:34 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_create_duns_segmentation_n1]
AS 

	IF OBJECT_ID('tempdb..#tmp') IS NOT NULL
		DROP TABLE #tmp

	-- ID Business Type
	SELECT 
		[a].[Duns Number],
		CASE WHEN [l].[DUNS_Number__c] IS NULL THEN 'nl' ELSE 'pl' END AS [nl_pl],
		CASE WHEN [a].[Year Started] >= 2011 THEN '2011+'
			 WHEN [a].[Year Started] >= 2007 THEN '2007 - 2010'
			 WHEN [a].[Year Started] >= 2003 THEN '2003 - 2006'
			 WHEN [a].[Year Started] >= 1997 THEN '1997 - 2002'
			 WHEN [a].[Year Started] < 1997 THEN '<=1996'
			 ELSE 'Other'
		END AS [year_segment],
		[sr].[region],
		CASE WHEN [a].[Paydex Range Code] IN ( '1','2','3' ) THEN '1' ELSE '0' END AS has_paydex_flag,
		[sdx].[sic_division],
		[esx].[emp_segment_name]
	INTO
		#tmp
	FROM
		[AdventureWorks_0007].[dbo].[OverallDnbBusinesses_current] AS [a]
		JOIN [AdventureWorks_0002].[OM].[sic_division_xmap] AS [sdx]
			ON [sdx].[two_digit_sic] = LEFT([a].[Primary SIC 8 Digit], 2)
		JOIN [AdventureWorks_0002].[OM].[state_to_region_xmap] AS [sr]
			ON [sr].[state_full_name] = [a].[State - Province]
		LEFT JOIN [AdventureWorks_0002].[OM].[emp_segment_xmap] AS [esx]
			ON [a].[Emp Total] BETWEEN [esx].[min_emp_size] AND [esx].[max_emp_size]
		LEFT JOIN (
			SELECT DISTINCT [DUNS_Number__c] FROM [AdventureWorks_0022].[dbo].[Lead]
		) AS [l]
			ON [l].[DUNS_Number__c] = [a].[Duns Number]

	IF OBJECT_ID('tempdb..[#tmp3]') IS NOT NULL
		DROP TABLE [#tmp3]
		
	SELECT
		[t].[Duns Number]
		,[t].[Response_Rate] AS [actual_rr]
		,[t].[LTF_perc] AS [actual_ltf]
		,[lsnt].[Median_RR_perc] AS [threshold_rr]
		,[lsnt].[RR_1_perc] AS threshold_rr3
		,[lsnt].[RR_2_perc] AS threshold_rr2
		,[lsnt].[LTF_perc] AS [threshold_ltf]
		,t.segments
		,[lsnt].[SIC_Division]
	INTO
		[#tmp3]
	FROM
		(
			SELECT
				[t].*
				,[lsnt].[Number_of_Records]
				,[lsnt].[Response_Rate]
				,[lsnt].[LTF_perc]
				,[lsnt].[AdventureWorks_0007_Mailable_Population]
				,[lsnt].[AdventureWorks_0007_Current_Month_Count]
				,[lsnt].[Segments]
			FROM
				[#tmp] AS [t]
				LEFT JOIN [AdventureWorks_0002].[OM].[list_segmentation_n1] AS [lsnt]
					ON [lsnt].[has_paydex_flag] = [t].[has_paydex_flag]
					   AND [lsnt].[NL_PL] = [t].[nl_pl]
					   AND [lsnt].[region] = [t].[region]
					   AND [lsnt].[year_segment] = [t].[year_segment]
					   AND [lsnt].[SIC_Division] = [t].[sic_division]
					   AND [lsnt].[Empl_Segment] = [t].[emp_segment_name]
		) AS [t]
		LEFT JOIN [AdventureWorks_0002].[OM].[list_segmentation_n1_thresholds] AS [lsnt]
			ON [lsnt].[SIC_Division] = [t].[SIC_Division]
			AND [lsnt].[NL_PL] = [t].[NL_PL]

	IF OBJECT_ID('[AdventureWorks_0007].[dbo].duns_segmentation_n1') IS NOT NULL
		DROP TABLE [AdventureWorks_0007].[dbo].duns_segmentation_n1

	SELECT
		[t].[Duns Number]
		,CASE WHEN [t].[actual_rr] > [t].[threshold_rr] AND [t].[actual_ltf] > [t].[threshold_ltf] THEN 'Growth'
			  WHEN [t].[actual_rr] > [t].[threshold_rr] THEN 'Unknown Growth'
			  WHEN [t].[actual_ltf] > [t].[threshold_ltf] THEN 'Vintage'
			  ELSE 'Mainstream'
		END AS segment_n1
		,CASE WHEN [t].[actual_rr] > [t].threshold_rr3 AND [t].[actual_ltf] > [t].[threshold_ltf] THEN 'Growth'
			  WHEN [t].[actual_rr] > [t].threshold_rr3 THEN 'Unknown Growth'
			  WHEN [t].[actual_ltf] > [t].[threshold_ltf] THEN 'Vintage'
			  ELSE 'Mainstream'
		END AS segment_n2
		,CASE WHEN [t].[actual_rr] > [t].threshold_rr2 AND [t].[actual_ltf] > [t].[threshold_ltf] THEN 'Growth'
			  WHEN [t].[actual_rr] > [t].threshold_rr2 THEN 'Unknown Growth'
			  WHEN [t].[actual_ltf] > [t].[threshold_ltf] THEN 'Vintage'
			  ELSE 'Mainstream'
		END AS segment_n3
		,segments AS n1_segment_string
		,[t].[SIC_Division]
	INTO
		[AdventureWorks_0007].[dbo].duns_segmentation_n1
	FROM
		[#tmp3] AS [t]

	CREATE UNIQUE CLUSTERED INDEX cInd ON [AdventureWorks_0007].[dbo].duns_segmentation_n1 ([Duns Number])
GO

/*
[AdventureWorks_0002].[OM].[sic_division_xmap]
[AdventureWorks_0002].[OM].[state_to_region_xmap]
[AdventureWorks_0002].[OM].[emp_segment_xmap]
[AdventureWorks_0002].[OM].[list_segmentation_n1]
[AdventureWorks_0002].[OM].[list_segmentation_n1_thresholds]
*/


SELECT TOP 1000 *
--INTO
--  dbo.sic_division_xmap
FROM
  AdventureWorks_0002.OM.sic_division_xmap


SELECT TOP 1000 *
--INTO
--  dbo.state_to_region_xmap
FROM
  AdventureWorks_0002.OM.state_to_region_xmap


SELECT TOP 1000 *
--INTO
--  dbo.emp_segment_xmap
FROM
  AdventureWorks_0002.OM.emp_segment_xmap


SELECT TOP 1000 *
--INTO
--  dbo.list_segmentation_n1
FROM
  AdventureWorks_0002.OM.list_segmentation_n1


SELECT TOP 1000 *
--INTO
--  dbo.list_segmentation_n1_thresholds
FROM
  AdventureWorks_0002.OM.list_segmentation_n1_thresholds




