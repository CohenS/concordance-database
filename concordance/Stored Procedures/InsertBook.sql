CREATE PROCEDURE [dbo].[InsertBook](
   @BookName VARCHAR(MAX),
   @Author VARCHAR(MAX),
   @PublishedDate VARCHAR(250),
   @Words [Words] READONLY,
   @BookContent VARCHAR(MAX)
)

AS
BEGIN
-- check if book already exists
    BEGIN TRANSACTION
    SAVE TRANSACTION MySavePoint;
    BEGIN TRY
        DECLARE @BookIDFromInsert INT;
        DECLARE @BookCharacterCount INT;
        SELECT @BookCharacterCount = SUM(LEN(WordValue)) FROM @Words;

        -- insert values to book table
        INSERT INTO Book (BookName,Author,PublishDate,BookCharacterCount, BookContent)
        VALUES (@BookName, @Author, @PublishedDate, @BookCharacterCount, @BookContent);
        
        SET @BookIDFromInsert = SCOPE_IDENTITY()

    -- insert values to word table
        INSERT INTO Word ([Value],[Length])
        SELECT DISTINCT [WordInput].[WordValue], LEN([WordInput].[WordValue])
        FROM @Words AS [WordInput]
        WHERE NOT EXISTS (Select [Value] From [Word] WHERE [Word].[Length] = LEN([WordInput].[WordValue]) AND [Value] = [WordInput].[WordValue])

    --  insert values to wordinfo table 
        INSERT INTO WordInfo (BookID, Line, WordID, Paragraph, WordNumber, Chapter)
        SELECT @BookIDFromInsert, [WordInsert].[Line], [W].[WordID], [WordInsert].[Paragraph], [WordInsert].[WordNumber], [WordInsert].[Chapter]
        FROM @Words AS [WordInsert]
        LEFT JOIN Word AS [W]
            ON [W].[Length] = LEN([WordInsert].[WordValue]) 
            AND [W].[Value] = [WordInsert].[WordValue]


        -- calculate word statistics 

        DECLARE @WordCharAvg INT
        SELECT @WordCharAvg = 
        (
            SELECT AVG(CharacterCountInWord) AS AverageCharacterCountInWord
                FROM 
                (
                    SELECT LEN(WordValue) AS CharacterCountInWord FROM @Words
                )
                AS a
        )

        DECLARE @LineCharAvg INT
        DECLARE @TotalLines INT

        SELECT 
            @LineCharAvg = Average,
            @TotalLines = TotalLines
        FROM
        (
            SELECT AVG(CharacterCount) AS Average, COUNT(*) AS TotalLines
                FROM 
                (
                    SELECT SUM(LEN(WordValue)) AS CharacterCount FROM @Words
                    GROUP BY Line, Paragraph, Chapter
                )
                AS a
        ) AS b

        DECLARE @ChapterCharAvg INT
        DECLARE @TotalChapters INT

        SELECT 
            @ChapterCharAvg = CharacterCountAverage,
            @TotalChapters = TotalChapters
        FROM
        (
            SELECT AVG(CharacterCount) AS CharacterCountAverage, COUNT(*) AS TotalChapters
                FROM 
                (
                    SELECT SUM(LEN(WordValue)) AS CharacterCount 
                    FROM @Words
                    GROUP BY Chapter
                )
                AS a
        ) AS b

    
        DECLARE @ParagraphCharAvg INT
        DECLARE @TotalParagraphs INT

        SELECT 
            @ParagraphCharAvg = CharacterCountAverage,
            @TotalParagraphs = TotalParagraphs
        FROM
        (
            SELECT AVG(CharacterCount) AS CharacterCountAverage, COUNT(*) AS TotalParagraphs
                FROM 
                (
                    SELECT SUM(LEN(WordValue)) AS CharacterCount FROM @Words
                    GROUP BY Paragraph, Chapter
                )
                AS a
        ) AS b

        DECLARE @TotalWords INT = 
        (
            SELECT COUNT(*)
            FROM @Words
        )


    -- insert Stat data 
        INSERT INTO BookStat (BookID,AvgCharWord,AvgCharLine, AvgCharParagraph, AvgCharChapter, AvgCharBook, TotalWords, TotalLines, TotalParagraphs, TotalChapters)
        VALUES (@BookIDFromInsert, @WordCharAvg, @LineCharAvg, @ParagraphCharAvg, @ChapterCharAvg, @BookCharacterCount, @TotalWords, @TotalLines, @TotalParagraphs, @TotalChapters )

        SELECT @BookIDFromInsert AS Output;

        COMMIT TRANSACTION 
    END TRY
    BEGIN CATCH
        if @@trancount > 0 rollback transaction;
        throw; --allows capture of useful info when an exception happens within the transaction
    END CATCH
END;
GO;