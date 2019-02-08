/*┌─────────────────────────────────────────────────────────────────────────────────────────────┐*\
  │ TITLE: Index DDL AdventureWorks_0006.stage.MenuUniverse.idx_stage_MenuUniverse_PriSIC
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ DESCRIPTION:                                                                                │
      
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ REVISION HISTORY:                                                                           │
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │   DATE       AUTHOR          CHANGE DESCRIPTION                                             │
  │   ────────── ─────────────── ────────────────────────────────────────────────────────────── │
      2018.10.08 bwarner         Initial Draft
  ├─────────────────────────────────────────────────────────────────────────────────────────────┤
  │ INDEX NAMING CONVENTION:                                                                    │

    PREFIX DESIGNATIONS:

      CI = Primary Key Index (Clustered): A clustered index acting as a primary key
      NI = Non-Clustered, Non-Unique Index
      UI = Unique Non-Clulstered Index

    FORM:
      <PrefixDesignation>_<TableSchema>_<TableName>_<Descriptor>

      <PrefixDesignation> : Pick the appropriate Prefix Designations listed above
      <TableSchema>       : The name of the schema of the table this index is on (if not dbo)
      <TableName>         : The name of the table this index is on
      <Descriptor>        : If the index is on one or two columns, just put the column names
                            separated by and underscore, if the index name is too long doing 
                            this or there are more than a couple columns just put a brief 
                            description of the purpose of the index

\*└─────────────────────────────────────────────────────────────────────────────────────────────┘*/
USE AdventureWorks_0006
GO

IF EXISTS (SELECT *
           FROM sys.indexes
           WHERE object_id = OBJECT_ID(N'stage.MenuUniverse')
                 AND name = N'idx_stage_MenuUniverse_PriSIC')
  DROP INDEX 
    idx_stage_MenuUniverse_PriSIC
  ON 
    stage.MenuUniverse
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT *
               FROM sys.indexes
               WHERE object_id = OBJECT_ID(N'stage.MenuUniverse')
                     AND name = N'idx_stage_MenuUniverse_PriSIC')
  CREATE NONCLUSTERED INDEX 
    idx_stage_MenuUniverse_PriSIC
  ON 
    stage.MenuUniverse
      (
          PriSIC
      ) 
  WITH 
    (
        PAD_INDEX               = OFF
      , STATISTICS_NORECOMPUTE  = OFF
      , SORT_IN_TEMPDB          = OFF
      , IGNORE_DUP_KEY          = OFF
      , DROP_EXISTING           = OFF
      , ONLINE                  = OFF
      , ALLOW_ROW_LOCKS         = ON
      , ALLOW_PAGE_LOCKS        = ON
    )






