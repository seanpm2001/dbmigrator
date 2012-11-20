CREATE OR REPLACE FUNCTION ItemsIncRepliesCount(
		ItemURIs TEXT[]
	) RETURNS INTEGER AS $$
DECLARE
	rec RECORD;
BEGIN
	SELECT ItemRepliesCount INTO rec FROM Items WHERE ItemURI = ANY(ItemURIs) FOR UPDATE;
	UPDATE Items SET ItemRepliesCount = ItemRepliesCount + 1 WHERE ItemURI = ANY(ItemURIs);
	RETURN 0;
END;
$$ LANGUAGE PLPGSQL
SECURITY DEFINER;

GRANT EXECUTE ON FUNCTION ItemsIncRepliesCount(
	TEXT[]
) TO PUBLIC;

