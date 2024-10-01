/// SqlUtils
///
/// All sqlite utils.
class SqlUtils {
  static final sqlScripts = SqlScripts();
}

/// SqlScripts
///
/// All sqlite scripts used by [SqlConnection].
class SqlScripts {
  final String noteTable = "notes";
  final String noteId = "id";
  final String noteText = "text";

  final String tagTable = "tags";
  final String tagId = "id";
  final String tagName = "name";

  final String noteTagTable = "tags_note";
  final String noteTagNoteId = "note_id";
  final String noteTagTagId = "tag_id";

  late final String definitionNote;
  late final String definitionTag;
  late final String definitionNoteTag;

  SqlScripts() {
    definitionNote = """
      CREATE TABLE IF NOT EXISTS $noteTable (
        $noteId INTEGER PRIMARY KEY AUTOINCREMENT,
        $noteText VARCHAR(255) NOT NULL
      );
    """;

    definitionTag = """
      CREATE TABLE IF NOT EXISTS $tagTable (
        $tagId INTEGER PRIMARY KEY AUTOINCREMENT,
        $tagName VARCHAR(20) NOT NULL,
        UNIQUE ($tagName)
      );
    """;

    definitionNoteTag = """
      CREATE TABLE IF NOT EXISTS $noteTagTable (
        $noteTagNoteId INTEGER NOT NULL,
        $noteTagTagId INTEGER NOT NULL,
        FOREIGN KEY ($noteTagNoteId) REFERENCES $noteTable($noteId)
          ON DELETE CASCADE
          ON UPDATE CASCADE,
        FOREIGN KEY ($noteTagTagId) REFERENCES $tagTable($tagId)
          ON DELETE CASCADE
          ON UPDATE CASCADE
      );
    """;
  }
}
