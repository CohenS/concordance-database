CREATE PROCEDURE [dbo].[InsertWordGroup](
   @WordGroupName VARCHAR(MAX),
   @Words [WordGroupWords] READONLY,
   @BookID INT
)

AS
BEGIN

    INSERT INTO [WordGroup]
               (
               WordGroupName,
               WordID,
               BookID
               )
         SELECT 
                @WordGroupName,
                W.WordID,
                @BookID
    FROM Word W
    INNER JOIN @Words AS WGW
        ON
	        LEN([WGW].[Word]) = [W].[Length] AND
	        [WGW].[Word] = [W].[Value]

END;
GO;