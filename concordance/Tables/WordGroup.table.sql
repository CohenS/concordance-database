CREATE TABLE WordGroup
 (
    BookID       INT NOT NULL,
    WordGroupName VARCHAR(256) NOT NULL,
    WordID INT NOT NULL,
    FOREIGN KEY (WordID) REFERENCES Word (WordID)
);