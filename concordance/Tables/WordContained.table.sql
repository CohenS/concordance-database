CREATE TABLE WordContained
 (
    BookID           INT NOT NULL,
    WordID           INT NOT NULL,
    Line             INT NOT NULL,
	PRIMARY KEY(BookID,WordID,Line),
	FOREIGN KEY  (BookID) REFERENCES Book (BookID),
	FOREIGN KEY  (WordID) REFERENCES Word (WordID)
);
