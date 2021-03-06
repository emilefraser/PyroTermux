/****** Object:  StoredProcedure [adf].[SetEventLog]    Script Date: 9/23/2020 00:05:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Writes the results of a pipeline to the PipelineOutput Table
CREATE PROCEDURE [adf].[SetEventLog] (
	@PipelineRunID UNIQUEIDENTIFIER = NULL
,	@LoadConfigID INT = NULL
,	@EventType VARCHAR(20)
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

	INSERT INTO adf.EventLog (
	   [PipelineRunID]
	  ,[LoadConfigID]
	  ,[EventType]
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
	  ,@LoadConfigID
	  ,@EventType
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
