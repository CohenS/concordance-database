
-- search words by value
CREATE  PROCEDURE SearchByValue
(
    @wordValue varchar(50)
)
AS
BEGIN
  SELECT [WordInfo].*, [Book].[BookName]
  FROM [WordInfo]
  LEFT JOIN [Word]
    ON [WordInfo].[WordID] = [Word].[WordID]
  LEFT JOIN [Book]
  ON [WordInfo].[BookID] = [Book].[BookID]
  WHERE 
    [Word].[Length] = LEN(@wordValue) AND
    [Word].[Value] = @wordValue  AND 
    [WordInfo].[WordID] = [Word].[WordID]

END;

GO;


-- search words by location
CREATE PROCEDURE SearchByLocation
(
    @Line   INT,
    @Paragrath INT,
    @Chapter VARCHAR(max),
    @WordID varchar(max)
)
AS
BEGIN
  SELECT *
  FROM [WordInfo] AS [W]
  WHERE 
      [W].[Line] = @Line AND
      [W].[Chapter] = @Chapter AND
      [W].[WordID] = @WordID

END;
GO;

-- search words by book
CREATE  PROCEDURE SearchBybook
(
    @BookName varchar(50)
)
AS
BEGIN
  SELECT [W].*
  FROM [WordInfo] AS [W]
  LEFT JOIN [Book] AS [B]
  ON
    [B].[BookName] = @BookName

END;
GO;

-- search words by value
CREATE  PROCEDURE SearchByPhrase
(
    @Words [Phrase] READONLY
)
AS
BEGIN
  
    SELECT 
	    [W].[Value] AS [Word],
	    [W].[WordID] AS [WordID]
    INTO #TempTable
    FROM 
	    @Words AS [Phrase]
    LEFT JOIN 
	    [Word] AS W
    ON
	    LEN([Phrase].[Word]) = [W].[Length] AND
	    [Phrase].[Word] = [W].[Value]
	
    SELECT *
    FROM #TempTable AS [TT]
    INNER JOIN 
	    [WordInfo] AS [Info]
    ON
	    [Info].[WordID] = [TT].[WordID]

END;
GO;

-- search words by value
CREATE  PROCEDURE GetBookByName
(
    @BookName varchar(255)
)
AS
BEGIN
  
    SELECT 
	    [B].[BookContent] AS [BookContent],
	    [B].[BookId] AS [BookId],
        [B].[BookName] AS [BookName],
        [B].[BookContent] AS [BookContent]
    FROM 
        [Book] AS [B]
    WHERE 
        [B].[BookName] = @BookName
    
END;
GO;


-- search words by value
CREATE  PROCEDURE GetWordsByWordGroup
(
    @WordGroupName varchar(255)
)
AS
BEGIN
  
    SELECT WI.[WordID], WI.[Line], WI.[Paragraph], WI.[Chapter], WI.[WordNumber], WI.BookID, B.BookName, W.*
    FROM WordGroup
    LEFT JOIN WordInfo AS WI
    ON
        WI.WordID = WordGroup.WordID AND
        WordGroup.WordGroupName = @WordGroupName
    LEFT JOIN Word AS W
    ON
        W.WordID = WI.WordID
    LEFT JOIN Book AS B
    ON 
        B.BookID = WI.BookID
END;
GO;


-- search words by value
CREATE  PROCEDURE GetWordsByLocation
(
   @Chapter INT,
   @Paragraph INT,
   @Line INT,
   @WordNumber INT
)
AS
BEGIN

    SELECT WI.[WordID], WI.[Line], WI.[Paragraph], WI.[Chapter], WI.[WordNumber], WI.BookID, B.BookName, W.*, B.BookID, B.BookName
	FROM WordInfo AS WI
    LEFT JOIN Word AS W
    ON
        W.WordID = WI.WordID
    LEFT JOIN Book AS B
    ON 
        B.BookID = WI.BookID
	WHERE
		WI.Chapter = @Chapter AND
        WI.Paragraph = @Paragraph AND
        WI.Line = @Line AND
        WI.WordNumber = @WordNumber
END;
GO;

CREATE  PROCEDURE GetWordGroupsByBookName
(
   @BookName VARCHAR(256)
)
AS
BEGIN
    SELECT WG.WordGroupName, B.BookName, WG.BookID, W.[Value]

	FROM WordGroup AS WG    
    LEFT JOIN Book AS B
	ON
		B.BookName = @BookName
    LEFT JOIN Word AS W
    ON
        W.WordID = WG.WordID

END;
GO;

CREATE  PROCEDURE UpdateWordGroup
(
   DECLARE @BookID INT = 134010
   DECLARE @WordGroupName VARCHAR(256) = 'names'
   @Words [WordGroupWords] READONLY
)

AS
BEGIN
    
    DELETE FROM
        [WordGroup]
    WHERE 
      [BookID] = @BookID AND
      [WordGroupName] = @WordGroupName

    EXEC [dbo].[InsertWordGroup] @WordGroupName, @Words, @BookID

END;
GO;