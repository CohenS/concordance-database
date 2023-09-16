CREATE TABLE Paragraph
 (
    ParagraphID     INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    BookID       INT NOT NULL,
    ParagraphValue NVARCHAR(MAX) NOT NULL,
    FOREIGN KEY  (BookID) REFERENCES Book (BookID)
);
