CREATE TABLE Word 
(
    WordID       INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Value        VARCHAR(256) UNIQUE NOT NULL,
    Length       INT DEFAULT 0,
);
GO

CREATE INDEX [IX_Word_LENGTH_VALUE_INDEX] ON [dbo].[Word] ([Length], [Value])
