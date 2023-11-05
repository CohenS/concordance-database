CREATE PROCEDURE GetBookStatisticsByBookId
(
   @BookID int
)
AS
BEGIN
    SELECT *
    FROM [dbo].[BookStat] AS [B]
    WHERE [B].[BookID] = @BookID

END;

GO;

CREATE PROCEDURE GeAveragetBooksStatistics
AS
BEGIN

    SELECT 
        AvgLineCharsPerBook,
        AvgChapterCharsPerBook,
        AvgParagraphCharsPerBook,
        AvgBookCharsPerBook,
        TotalBooks,
        AvgWordsPerBook,
        TotalWords,
        AvgLinesPerBook,
        TotalParagraphs,
        AvgTotalChapters,
        TotalChapters
        FROM 
        (
            SELECT
                AVG(AvgCharLine) AS AvgLineCharsPerBook,
                AVG(AvgCharChapter) AS AvgChapterCharsPerBook,
                AVG(AvgCharParagraph) AS AvgParagraphCharsPerBook,
                AVG(AvgCharBook) AS AvgBookCharsPerBook,
                SUM([BookStat].[BookID]) AS TotalBooks,
                AVG(TotalWords) AS AvgWordsPerBook,
                SUM(TotalWords) AS TotalWords,
                AVG(TotalLines) AS AvgLinesPerBook,
                SUM(TotalLines) AS TotalLines,
                AVG(TotalParagraphs) AS AvgParagraphsPerBook,
                SUM(TotalParagraphs) AS TotalParagraphs,
                AVG(TotalChapters) AS AvgTotalChapters,
                SUM(TotalChapters) AS TotalChapters
            FROM [dbo].[BookStat]
            GROUP BY [dbo].[BookStat].[BookID] 
        )
        AS a

END;

GO;