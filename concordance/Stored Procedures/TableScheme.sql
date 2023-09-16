
--CREATE TABLE Book
-- (
--    BookID        INT NOT NULL PRIMARY KEY IDENTITY(1,1),
--    BookName      VARCHAR(max) NOT NULL,
--    Author        VARCHAR(max) NOT NULL,
--    PublishDate   DATETIME DEFAULT CURRENT_TIMESTAMP,
--    BookNumChar   INT NOT NULL,
--    BookGener     VARCHAR (max),
--    UNIQUE(BookName, Author),
--);

--CREATE TABLE  Word 
--(
--    WordID       INT NOT NULL PRIMARY KEY IDENTITY(1,1),
--    Value        VARCHAR(max) NOT NULL,
--    Length       INT DEFAULT 0,
--);

--CREATE TABLE  WordGroup
-- (
--    GroupID      INT NOT NULL PRIMARY KEY IDENTITY(1,1),
--    GroupName    VARCHAR(max) NOT NULL,
--    WordID       INT NOT NULL,
--    FOREIGN KEY  (WordID) REFERENCES Word (WordID)
--);

--CREATE TABLE WordPhrase
-- (
--    PhraseID     INT NOT NULL PRIMARY KEY IDENTITY(1,1),
--    WordID       INT NOT NULL,
--    IndexInPhrase INT NOT NULL,
--    FOREIGN KEY  (WordID) REFERENCES Word (WordID)
--);

--CREATE TABLE Paragrath
-- (
--    ParagrathID     INT NOT NULL PRIMARY KEY IDENTITY(1,1),
--    BookID       INT NOT NULL,
--    ParagarthValue NVARCHAR(MAX) NOT NULL,
--    FOREIGN KEY  (BookID) REFERENCES Book (BookID)
--);

--CREATE TABLE BookStat
-- (
--    BookID           INT NOT NULL PRIMARY KEY,
--    AvgCharSentence  INT NOT NULL,
--    AvgCharChapter   INT NOT NULL,
--    AvgCharPage      INT NOT NULL,
--    AvgCharBook      INT NOT NULL,
--	FOREIGN KEY  (BookID) REFERENCES Book (BookID)
--);

--CREATE TABLE WordInfo
--(
--	ID 				             INT NOT NULL PRIMARY KEY IDENTITY(1,1),
--    BookID                       INT NOT NULL,
--    Line                         INT NOT NULL,
--    WordID                       INT NOT NULL,
--    ParagrathNumberInBook        INT NOT NULL,
--	FOREIGN KEY  (BookID) REFERENCES Book (BookID),
--	FOREIGN KEY  (WordID) REFERENCES Word (WordID)
--);

--CREATE TABLE WordContained
-- (
--    BookID           INT NOT NULL,
--    WordID           INT NOT NULL,
--    Line             INT NOT NULL,
--	PRIMARY KEY(BookID,WordID,Line),
--	FOREIGN KEY  (BookID) REFERENCES Book (BookID),
--	FOREIGN KEY  (WordID) REFERENCES Word (WordID)
--);