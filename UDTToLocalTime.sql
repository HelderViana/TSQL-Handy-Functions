USE [master]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Bobman
-- Create date: 2012.01.12
-- Description:	Converts UTC DateTime to local Daylight Saving Time, dynamiclly
-- Source Post: http://stackoverflow.com/questions/3404646/how-to-calculate-the-local-datetime-from-a-utc-datetime-in-tsql-sql-2005/8842966#8842966
-- =============================================
CREATE FUNCTION [dbo].[UDTToLocalTime](@UDT AS DATETIME)  
RETURNS DATETIME
AS
BEGIN 	
	--Set the Timezone Offset (NOT During DST [Daylight Saving Time])	
	DECLARE @Offset AS SMALLINT
	SET @Offset = 0
	
	--Figure out the Offset Datetime:
	DECLARE @LocalDate AS DATETIME
	SET @LocalDate = DATEADD(hh, @Offset, @UDT)
	
	--Figure out the DST Offset for the UDT Datetime:
	DECLARE @DaylightSavingOffset AS SMALLINT
	DECLARE @Year as SMALLINT
	DECLARE @DSTStartDate AS DATETIME
	DECLARE @DSTEndDate AS DATETIME

	--Get Year:
	SET @Year = YEAR(@LocalDate)

	--Get First Possible DST StartDay:
	IF (@Year > 2006) SET @DSTStartDate = CAST(@Year AS CHAR(4)) + '-04-01 01:00:00' -- '-03-08 02:00:00'
	ELSE              SET @DSTStartDate = CAST(@Year AS CHAR(4)) + '-03-08 01:00:00' -- '-04-01 02:00:00'

	--Get DST StartDate:
	WHILE (DATENAME(dw, @DSTStartDate) <> 'sunday') SET @DSTStartDate = DATEADD(day, -1,@DSTStartDate)

	--Get First Possible DST EndDate
	IF (@Year > 2006) SET @DSTEndDate = CAST(@Year AS CHAR(4)) + '-11-01 02:00:00'
	ELSE              SET @DSTEndDate = CAST(@Year AS CHAR(4)) + '-10-25 02:00:00'
	--Get DST EndDate:
	WHILE (DATENAME(dw, @DSTEndDate) <> 'sunday') SET @DSTEndDate = DATEADD(day,-1,@DSTEndDate)

	--Get DaylightSavingOffset:
	SET @DaylightSavingOffset = CASE WHEN @LocalDate BETWEEN @DSTStartDate AND @DSTEndDate THEN 1 ELSE 0 END

	--Finally add the DST Offset:
	RETURN DATEADD(hh, @DaylightSavingOffset, @LocalDate)
END

GO
