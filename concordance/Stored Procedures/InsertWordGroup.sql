-- Insert a new word group into the WordGroup table.
CREATE PROCEDURE [dbo].[InsertWordGroup](
  -- The name of the word group.
  @WordGroupName VARCHAR(MAX),
  -- A table-valued parameter that contains the word group words.
  @Words [WordGroupWords] READONLY,
  -- The ID of the book that the word group belongs to.
  @BookID INT
)

AS
BEGIN

  -- Insert the word group into the WordGroup table.
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
      [WGW].[Word] = [W].[Value];

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