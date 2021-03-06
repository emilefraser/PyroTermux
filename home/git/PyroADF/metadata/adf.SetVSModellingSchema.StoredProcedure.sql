/****** Object:  StoredProcedure [adf].[SetVSModellingSchema]    Script Date: 9/23/2020 00:05:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- CREATES OR EXTENDS THE MODELLING SCHEMA DATABASE
-- EXEC adf.SetVSModellingSchema	
CREATE   PROCEDURE [adf].[SetVSModellingSchema]	
AS
BEGIN
	
	DECLARE 
		@sql_statement	NVARCHAR(MAX)
	,	@sql_message	NVARCHAR(MAX)
	,	@sql_parameter	NVARCHAR(MAX)
	,	@sql_crlf		NVARCHAR(2) = CHAR(13) + CHAR(10)
	,	@sql_tab		NVARCHAR(1) = CHAR(9)
	,	@sql_execute	BIT = 1	
	,	@sql_debug		BIT = 0

	DECLARE 
		@LoadType						NVARCHAR(128) = 'FULL'
	,	@SourceSystemName				SYSNAME = 'SAP S4 HANA'
	,	@SourceEntityType				SYSNAME = 'TABLE'
	,	@SourceIntegrationRuntime		SYSNAME = 'SAWCC-P-BI01'
	,	@SourceServerName				SYSNAME = 'SAAZS-V-SAP13:31341'
	,	@SourceDatabaseName				SYSNAME = 'SAPHANADB'
	,	@TargetSystemName				SYSNAME = 'SAEC DW'
	,	@TargetEntityType				SYSNAME = 'TABLE'
	,	@TargetIntegrationRuntime		SYSNAME = 'AutoResolveIntegrationRunTime'
	,	@TargetServerName				SYSNAME = 'saec-powerbi-dev.database.windows.net'
	,	@TargetSchemaName				SYSNAME = 'lnd'
	,	@IsActive						BIT = 1
	
	
	DECLARE 
		@SourceEntityName SYSNAME
	,	@TargetEntityName SYSNAME

	DECLARE 
		@entity_cursor CURSOR

	SET 
		@entity_cursor = CURSOR FOR 
		SELECT 
			TableName = TABNAME
		,	TableDescription = ISNULL([dm].[RemovePatternFromString](DDTEXT), sle.[SourceEntityTechnicalName] + '_' + 'UNKNOWN')
		FROM 
			[adf].[SourceLoadEntity] AS sle
		LEFT JOIN 
			dm.SapTables AS sap
		ON 
			sap.TABNAME = sle.SourceEntityTechnicalName
		WHERE NOT EXISTS (
			SELECT 
				1
			FROM 
				adf.LoadConfig AS lc
			WHERE
				lc.SourceEntityName = sle.[SourceEntityTechnicalName]
		)
		
	OPEN @entity_cursor

	FETCH NEXT FROM @entity_cursor
	INTO @SourceEntityName, @TargetEntityName
	
	WHILE (@@FETCH_STATUS = 0)
	BEGIN 
	
		SET @sql_statement = N'
			 [adf].[SetLoadConfig] 
				   @LoadType =					@LoadType
				  ,@SourceSystemName =			@SourceSystemName
				  ,@SourceEntityType =			@SourceEntityType
				  ,@SourceIntegrationRuntime =	@SourceIntegrationRuntime
				  ,@SourceServerName =			@SourceServerName
				  ,@SourceDatabaseName =		@SourceDatabaseName
				  ,@SourceEntityName =			@SourceEntityName
				  ,@TargetSystemName =			@TargetSystemName
				  ,@TargetEntityType =			@TargetEntityType
				  ,@TargetIntegrationRuntime =	@TargetIntegrationRuntime
				  ,@TargetServerName =			@TargetServerName
				  ,@TargetSchemaName =			@TargetSchemaName
				  ,@TargetEntityName =			@TargetEntityName
				  ,@IsActive =					@IsActive'

		SET @sql_parameter  = N'
				@LoadType						NVARCHAR(128)
			,	@SourceSystemName				SYSNAME
			,	@SourceEntityType				SYSNAME
			,	@SourceIntegrationRuntime		SYSNAME 
			,	@SourceServerName				SYSNAME
			,	@SourceDatabaseName				SYSNAME 
			,	@TargetSystemName				SYSNAME
			,	@SourceEntityName				SYSNAME
			,	@TargetEntityType				SYSNAME
			,	@TargetIntegrationRuntime		SYSNAME
			,	@TargetServerName				SYSNAME
			,	@TargetSchemaName				SYSNAME
			,	@TargetEntityName				SYSNAME
			,	@IsActive =						BIT'

		IF(@sql_debug = 1)
		BEGIN
			SET @sql_message = @sql_statement
			RAISERROR(@sql_statement, 0, 1) WITH NOWAIT
		END

		IF(@sql_execute = 1)
		BEGIN
			EXEC sp_executesql
						@stmt =						@sql_statement
					,	@param =					@sql_parameter
					,	@LoadType =					@LoadType
					,	@SourceSystemName =			@SourceSystemName
					,	@SourceEntityType =			@SourceEntityType
					,	@SourceIntegrationRuntime =	@SourceIntegrationRuntime
					,	@SourceServerName =			@SourceServerName
					,	@SourceDatabaseName =		@SourceDatabaseName
					,	@SourceEntityName =			@SourceEntityName
					,	@TargetSystemName =			@TargetSystemName
					,	@TargetEntityType =			@TargetEntityType
					,	@TargetIntegrationRuntime =	@TargetIntegrationRuntime
					,	@TargetServerName =			@TargetServerName
					,	@TargetSchemaName =			@TargetSchemaName
					,	@TargetEntityName =			@TargetEntityName
					,	@IsActive =					@IsActive

		END

	FETCH NEXT FROM @entity_cursor
	INTO @SourceEntityName, @TargetEntityName

	END
END

				
GO
