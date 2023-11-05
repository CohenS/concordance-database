-- Create a table type to store chapter statistics.
CREATE TYPE [ChapterStatistics] AS TABLE
(
  -- The chapter number.
  ChapterNumber INT,
  -- The character count of the chapter.
  CharacterCount INT
);
GO;

-- Create a table type to store paragraph statistics.
CREATE TYPE ParagraphStatistics AS TABLE
(
  -- The paragraph number.
  ParagraphNumber INT,
  -- The character count of the paragraph.
  CharacterCount INT
);
GO;

-- Create a table type to store line statistics.
CREATE TYPE LineStatistics AS TABLE
(
  -- The line number.
  LineNumber INT,
  -- The character count of the line.
  CharacterCount INT
);
GO;

-- Create a table type to store words.
CREATE TYPE [Words] AS TABLE
(
  -- The word value.
  WordValue VARCHAR(MAX),
  -- The paragraph number that the word belongs to.
  Paragraph INT,
  -- The chapter number that the word belongs to.
  Chapter INT,
  -- The line number that the word belongs to.
  Line INT,
  -- The word number within the line.
  WordNumber INT
);
GO;

-- Create a table type to store phrases.
CREATE TYPE [Phrase] AS TABLE
(
  -- The word value of the phrase.
  Word VARCHAR(MAX)
);
GO;

-- Create a table type to store word group words.
CREATE TYPE [WordGroupWords] AS TABLE
(
  -- The word value of the word group word.
  Word VARCHAR(MAX)
);
GO;
