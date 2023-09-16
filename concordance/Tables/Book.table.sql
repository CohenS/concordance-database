
CREATE TABLE Book
 (
    BookID        INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    BookName      VARCHAR(250) UNIQUE NOT NULL,
    Author        VARCHAR(250) NOT NULL,
    PublishDate   VARCHAR(250) NOT NULL,
    [BookCharacterCount]   INT NOT NULL,
    BookGenre     VARCHAR (max),
    [BookContent] NVARCHAR(MAX) NOT NULL, 
    UNIQUE(BookName, Author),
);
