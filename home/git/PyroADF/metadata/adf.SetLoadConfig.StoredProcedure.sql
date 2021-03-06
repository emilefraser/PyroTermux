/****** Object:  StoredProcedure [adf].[SetLoadConfig]    Script Date: 9/23/2020 00:05:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	Written by	: Emile Fraser	
	Date		: 2020-05-20
	Function	: Crud for Inserting/Updating/Deleting New LoadConfigs

*/
CREATE   PROCEDURE [adf].[SetLoadConfig] (
		@LoadConfigID INT = NULL,
		@LoadType NVARCHAR(128) = NULL,
		@SourceSystemName SYSNAME = NULL,
		@SourceEntityType SYSNAME = NULL,
		@SourceIntegrationRuntime SYSNAME = NULL,
		@SourceServerName SYSNAME = NULL,
		@SourceDatabaseInstanceName SYSNAME = NULL,
		@SourceDatabaseName SYSNAME = NULL,
		@SourceSchemaName SYSNAME = NULL,
		@SourceEntityName SYSNAME = NULL,
		@SourceStaticFieldList NVARCHAR(MAX) = NULL,
		@TargetSystemName SYSNAME = NULL,
		@TargetEntityType SYSNAME = NULL,
		@TargetIntegrationRuntime SYSNAME = DEFAULT,
		@TargetServerName SYSNAME = NULL,
		@TargetDatabaseInstanceName SYSNAME = DEFAULT,
		@TargetSchemaName SYSNAME = NULL,
		@TargetEntityName SYSNAME = NULL,	
		@PrimaryKeyColumn  SYSNAME = NULL,
		@CdcCreatedDtColumn SYSNAME = NULL,
		@CdcCreatedDtValue SYSNAME = NULL,
		@CdcUpdatedDtColumn SYSNAME = NULL,
		@CdcUpdatedDtValue SYSNAME = NULL,
		@IsUseExternalCdc BIT = NULL,
		@ExCdcSystemName SYSNAME = NULL,
		@ExCdcEntityType SYSNAME = NULL,
		@ExCdcServerName SYSNAME = NULL,
		@ExCdcDatabaseInstanceName SYSNAME = NULL,
		@ExCdcDatabaseName SYSNAME = NULL,
		@ExCdcSchemaName SYSNAME = NULL,
		@ExCdcJoinColumn SYSNAME = NULL,
		@SourceCdcJoinColumn NVARCHAR(MAX) = NULL,
		@IsDropAndRecreateTarget BIT = NULL,
		@IsActive BIT NULL
)
AS 
BEGIN

	DECLARE @MergeLog TABLE (
		MergeID INT,
		MergeAction SYSNAME
	)
		
	MERGE [adf].[LoadConfig] AS T
	USING (
		SELECT 
			[LoadConfigID]							= @LoadConfigID
		  ,	[LoadType]								= @LoadType
		  ,	[SourceSystemName]						= @SourceSystemName
		  ,	[SourceEntityType]						= @SourceEntityType
		  , [SourceIntegrationRuntime]				= @SourceIntegrationRuntime
		  ,	[SourceServerName]						= @SourceServerName
		  ,	[SourceDatabaseInstanceName]			= @SourceDatabaseInstanceName
		  ,	[SourceDatabaseName]					= @SourceDatabaseName
		  ,	[SourceSchemaName]						= @SourceSchemaName
		  ,	[SourceEntityName]						= @SourceEntityName
		  ,	[SourceStaticFieldList]					= @SourceStaticFieldList
		  ,	[TargetSystemName]						= @TargetSystemName
		  ,	[TargetIntegrationRuntime]				= @TargetIntegrationRuntime
		  ,	[TargetServerName]						= @TargetServerName
		  ,	[TargetDatabaseInstanceName]			= @TargetDatabaseInstanceName
		  ,	[TargetSchemaName]						= @TargetSchemaName
		  ,	[TargetEntityName]						= @TargetEntityName
		  ,	[CdcCreatedDtColumn]					= @CdcCreatedDtColumn
		  ,	[CdxCreatedDtValue]						= @CdcCreatedDtValue
		  ,	[CdcUpdatedDtValue]						= @CdcUpdatedDtValue
		  ,	[IsUseExternalCdc]						= @IsUseExternalCdc
		  ,	[ExCdcSystemName]						= @ExCdcSystemName
		  , [ExCdcEntityType]						= @ExCdcEntityType
		  , [ExCdcServerName]						= @ExCdcServerName
		  , [ExCdcDatabaseInstanceName]				= @ExCdcDatabaseInstanceName
		  , [ExCdcDatabaseName]						= @ExCdcDatabaseName
		  , [ExCdcSchemaName]						= @ExCdcSchemaName
		  , [ExCdcJoinColumn]						= @ExCdcJoinColumn
		  ,	[SourceCdcJoinColumn]					= @SourceCdcJoinColumn
		  ,	[IsDropAndRecreateTarget]				= @IsDropAndRecreateTarget
		  ,	[PrimaryKeyColumn]						= @PrimaryKeyColumn
		  ,	[IsActive]								= @IsActive
	) S
	ON (S.LoadConfigID = T.LoadConfigID)
	WHEN MATCHED
	THEN UPDATE
		 SET    
		  	[LoadType]								= COALESCE(@LoadType, T.LoadType)
		  ,	[SourceSystemName]						= COALESCE(@SourceSystemName, T.SourceSystemName)
		  ,	[SourceEntityType]						= COALESCE(@SourceEntityType, T.SourceEntityType)
		  , [SourceIntegrationRuntime]				= COALESCE(@SourceIntegrationRuntime, T.SourceIntegrationRuntime)
		  ,	[SourceServerName]						= COALESCE(@SourceServerName, T.SourceServerName )
		  ,	[SourceDatabaseInstanceName]			= COALESCE(@SourceDatabaseInstanceName, T.SourceDatabaseInstanceName )
		  ,	[SourceDatabaseName]					= COALESCE(@SourceDatabaseName, T.SourceDatabaseName )
		  ,	[SourceSchemaName]						= COALESCE(@SourceSchemaName, T.SourceSchemaName )
		  ,	[SourceEntityName]						= COALESCE(@SourceEntityName, T.SourceEntityName )
		  ,	[SourceStaticFieldList]					= COALESCE(@SourceStaticFieldList, T.SourceStaticFieldList )
		  ,	[TargetSystemName]						= COALESCE(@TargetSystemName, T.TargetSystemName )
		  ,	[TargetEntityType]						= COALESCE(@TargetEntityType, T.TargetEntityType )
		  , [TargetIntegrationRuntime]				= COALESCE(@TargetIntegrationRuntime, T.TargetIntegrationRuntime)
		  ,	[TargetServerName]						= COALESCE(@TargetServerName, T.TargetServerName )
		  ,	[TargetDatabaseInstanceName]			= COALESCE(@TargetDatabaseInstanceName, T.TargetDatabaseInstanceName )
		  ,	[TargetSchemaName]						= COALESCE(@TargetSchemaName, T.TargetSchemaName )
		  ,	[TargetEntityName]						= COALESCE(@TargetEntityName, T.TargetEntityName )	
		  ,	[PrimaryKeyColumn]						= COALESCE(@PrimaryKeyColumn, T.PrimaryKeyColumn )
		  ,	[CdcCreatedDtColumn]					= COALESCE(@CdcCreatedDtColumn, T.CdcCreatedDtColumn )
		  ,	[CdcCreatedDtValue]						= COALESCE(@CdcCreatedDtValue, T.CdcCreatedDtValue )
		  ,	[CdcUpdatedDtColumn]					= COALESCE(@CdcCreatedDtColumn, T.CdcCreatedDtColumn )
		  ,	[CdcUpdatedDtValue]						= COALESCE(@CdcUpdatedDtValue, T.CdcUpdatedDtValue )
		  ,	[IsUseExternalCdc]						= COALESCE(@IsUseExternalCdc, T.IsUseExternalCdc )
		  ,	[ExCdcSystemName]						= COALESCE(@ExCdcSystemName, T.[ExCdcSystemName])
		  , [ExCdcEntityType]						= COALESCE(@ExCdcEntityType, T.[ExCdcEntityType])
		  , [ExCdcServerName]						= COALESCE(@ExCdcServerName, T.[ExCdcServerName])
		  , [ExCdcDatabaseInstanceName]				= COALESCE(@ExCdcDatabaseInstanceName, T.[ExCdcDatabaseInstanceName])
		  , [ExCdcDatabaseName]						= COALESCE(@ExCdcDatabaseName, T.[ExCdcDatabaseName])
		  , [ExCdcSchemaName]						= COALESCE(@ExCdcSchemaName, T.[ExCdcSchemaName])
		  , [ExCdcJoinColumn]						= COALESCE(@ExCdcJoinColumn, T.[ExCdcJoinColumn])
		  ,	[SourceCdcJoinColumn]					= COALESCE(@SourceCdcJoinColumn, T.[SourceCdcJoinColumn])
		  ,	[IsDropAndRecreateTarget]				= COALESCE(@IsDropAndRecreateTarget, T.IsDropAndRecreateTarget )		
		  ,	[IsActive]								= COALESCE(@IsActive, T.IsActive )
		  ,	[UpdatedDT]								= GETDATE()
	WHEN NOT MATCHED BY TARGET
	THEN INSERT (
			[LoadType]
		  ,	[SourceSystemName]
		  ,	[SourceEntityType]
		  , [SourceIntegrationRuntime]
		  ,	[SourceServerName]
		  ,	[SourceDatabaseInstanceName]
		  ,	[SourceDatabaseName]
		  ,	[SourceSchemaName]
		  ,	[SourceEntityName]
		  ,	[TargetSystemName]
		  ,	[TargetEntityType]
		  , [TargetIntegrationRuntime]
		  ,	[TargetServerName]
		  ,	[TargetDatabaseInstanceName]
		  ,	[TargetSchemaName]
		  ,	[TargetEntityName]
		  ,	[SourceStaticFieldList]
		  , [PrimaryKeyColumn]
		  , [CdcCreatedDtColumn]
		  , [CdcCreatedDtValue]
		  , [CdcUpdatedDtColumn]
		  , [CdcUpdatedDtValue]
		  , [IsUseExternalCdc]
		  , [ExCdcSystemName]
		  , [ExCdcEntityType]
		  , [ExCdcServerName]
		  , [ExCdcDatabaseInstanceName]
		  , [ExCdcDatabaseName]
		  , [ExCdcSchemaName]
		  , [ExCdcJoinColumn]
		  , [SourceCdcJoinColumn]
		  ,	[IsActive]
		  ,	[CreatedDT]
	)
	VALUES (
		@LoadType
	,	@SourceSystemName
	,	@SourceEntityType
	,   @SourceIntegrationRuntime
	,	@SourceServerName
	,	@SourceDatabaseInstanceName
	,	@SourceDatabaseName
	,	@SourceSchemaName
	,	@SourceEntityName
	,	@TargetSystemName
	,	@TargetEntityType
	,   @TargetIntegrationRuntime
	,	@TargetServerName
	,	@TargetDatabaseInstanceName
	,	@TargetSchemaName
	,	@TargetEntityName
	,	@SourceStaticFieldList
	,   @PrimaryKeyColumn
	,   @CdcCreatedDtColumn
	,   @CdcCreatedDtValue
	,   @CdcUpdatedDtColumn
	,   @CdcUpdatedDtValue
	,   @IsUseExternalCdc
	,   @ExCdcSystemName
	,   @ExCdcEntityType
	,	@ExCdcServerName
	,   @ExCdcDatabaseInstanceName
	,   @ExCdcDatabaseName
	,   @ExCdcSchemaName
	,   @ExCdcJoinColumn
	,   @SourceCdcJoinColumn
	,	@IsActive
	,	GETDATE()
	)
	OUTPUT S.LoadConfigID, $action into @MergeLog;

	SELECT MergeAction, COUNT(*) AS CNT
	FROM   @MergeLog
	GROUP BY MergeAction


END
GO
