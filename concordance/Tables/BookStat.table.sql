

CREATE TABLE BookStat
 (
    BookID           INT NOT NULL PRIMARY KEY,
    AvgCharLine  INT NOT NULL,
    AvgCharChapter   INT NOT NULL,
    AvgCharParagraph      INT NOT NULL,
    AvgCharBook      INT NOT NULL,
	[AvgCharWord] NCHAR(10) NOT NULL, 
    [TotalWords] INT NOT NULL, 
    [TotalLines] INT NOT NULL, 
    [TotalParagraphs] INT NOT NULL, 
    [TotalChapters] INT NOT NULL, 
    FOREIGN KEY  (BookID) REFERENCES Book (BookID)
);
