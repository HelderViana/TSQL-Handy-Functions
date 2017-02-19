USE [master]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Helder S. Viana
-- Create date: 2016.01.11
-- Description:	Clean special characters from a string
-- =============================================
CREATE FUNCTION [dbo].[CleanString] 
(	
	@string varchar(100)
	,@validchar varchar(255)=null
)
RETURNS nvarchar(20)
AS
BEGIN
	-- Declare the return variable here:
	DECLARE @Result nvarchar(200)
	
	Declare @fromNumber int=1,
	  @toNumber int=100,
	  @byStep int=1
	 
	-- List of allowed characters:
	if @validchar is null
		begin		
			set @validchar='[-a-z0-9 ]'
		end

	-- CTE with the calculation of string's length:
	;WITH CTE AS (
	  SELECT @fromNumber AS i
	  UNION ALL
	  SELECT i + @byStep
	  FROM CTE
	  WHERE
	  (i + @byStep) <= @toNumber
	)
	
	-- Cleans the string:
	select @Result=cast(cast((select substring(@string,CTE.i,1)
	from CTE
	where CTE.i <= len(@string)	
		and substring(@string,CTE.i,1) like @validchar for xml path('')) as xml)as varchar(max))

	return @Result
END




GO


