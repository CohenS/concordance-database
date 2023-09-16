
CREATE TRIGGER WordUpdate 
   ON Word
   INSTEAD OF INSERT
   AS
     BEGIN
        INSERT INTO Word
        SELECT [I].[WordID],
                [I].[Value],
                LEN([I].[Value]) as [Length]
        FROM  Inserted as I
     END 