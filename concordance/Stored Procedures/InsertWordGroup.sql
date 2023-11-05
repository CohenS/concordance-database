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

CREATE PROCEDURE [dbo].[InsertWordGroupByBookName](
   @WordGroupName VARCHAR(MAX),
   @Words [WordGroupWords] READONLY,
   @BookName VARCHAR(256)
)

AS
BEGIN

    DECLARE @BookID INT;
    SELECT TOP 1 @BookID = BookID
    FROM Book b
    WHERE b.BookName = @BookName

    IF @BookID IS NOT NULL
        EXEC [dbo].[InsertWordGroup] @BookID = @BookID, @WordGroupName = @WordGroupName, @Words = @Words;

END;
GO;