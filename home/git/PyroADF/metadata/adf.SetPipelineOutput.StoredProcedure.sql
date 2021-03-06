/****** Object:  StoredProcedure [adf].[SetPipelineOutput]    Script Date: 9/23/2020 00:05:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Writes the results of a pipeline to the PipelineOutput Table
CREATE PROCEDURE [adf].[SetPipelineOutput] (
	@PipelineRunID UNIQUEIDENTIFIER = NULL
,	@DataFactoryName SYSNAME = NULL
,	@PipelineName SYSNAME = NULL
,	@PipelineTriggerID UNIQUEIDENTIFIER = NULL
,	@PipelineTriggerName SYSNAME = NULL
,	@PipelineTriggerTime DATETIME2(7) = NULL
,	@PipelineTriggerType VARCHAR(100) = NULL
,	@OutputJSON VARCHAR(MAX) = NULL
)
AS
BEGIN

	INSERT INTO adf.PipelineOutput (
	   [PipelineRunID]
      ,[DataFactoryName]
      ,[PipelineName]
      ,[PipelineTriggerID]
      ,[PipelineTriggerName]
      ,[PipelineTriggerTime]
      ,[PipelineTriggerType]
      ,[OutputJSON]
     )
	 VALUES (
	   @PipelineRunID
      ,@DataFactoryName
      ,@PipelineName
      ,@PipelineTriggerID
      ,@PipelineTriggerName
      ,@PipelineTriggerTime
      ,@PipelineTriggerType
      ,@OutputJSON
	 )

END
GO
