/****** Object:  View [adf].[vw_LoadConfig]    Script Date: 9/23/2020 00:05:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE view [adf].[vw_LoadConfig]
AS
SELECT [LoadConfigID]
      ,[LoadType]
      ,[SourceSystemName]
      ,[SourceEntityType]
      ,[SourceIntegrationRuntime]
      ,[SourceServerName]
      ,[SourceDatabaseInstanceName]
      ,[SourceDatabaseName]
      ,[SourceSchemaName]
      ,[SourceEntityName]
      ,[SourceStaticFieldList]
      ,[TargetSystemName]
      ,[TargetEntityType]
      ,[TargetIntegrationRuntime]
      ,[TargetServerName]
      ,[TargetDatabaseInstanceName]
	  ,[TargetDatabaseName]
      ,[TargetSchemaName]
      ,CONCAT_WS('_', [TargetEntityName], [TargetEntityNameExtension]) AS [TargetEntityName]
      ,[PrimaryKeyColumn]
      ,[CdcCreatedDtColumn]
      ,[CdcCreatedDtValue]
      ,[CdcUpdatedDtColumn]
      ,[CdcUpdatedDtValue]
      ,[IsUseExternalCdc]
      ,[ExCdcSystemName]
      ,[ExCdcEntityType]
      ,[ExCdcServerName]
      ,[ExCdcDatabaseInstanceName]
      ,[ExCdcDatabaseName]
      ,[ExCdcSchemaName]
      ,[ExCdcEntityName]
      ,[ExCdcJoinColumn]
      ,[SourceCdcJoinColumn]
      ,[IsActive]
      ,[IsDropAndRecreateTarget]
      ,[CreatedDT]
      ,[UpdatedDT]
  FROM [adf].[LoadConfig]
 -- WHERE LoadConfigID BETWEEN 7 and 9
 


GO
