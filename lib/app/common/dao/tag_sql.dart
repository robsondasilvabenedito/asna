import 'package:asna/app/common/dao/tag_dao.dart';
import 'package:asna/app/common/database/sql.dart';
import 'package:asna/app/common/database/sql_utils.dart';
import 'package:asna/app/common/model/tag.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class TagSql extends TagDAO {
  Database? _db;

  final _tagTable = SqlUtils.sqlScripts.tagTable;

  final _tagId = SqlUtils.sqlScripts.tagId;
  final _tagName = SqlUtils.sqlScripts.tagName;

  final _manyTable = SqlUtils.sqlScripts.noteTagTable;

  final _manynoteId = SqlUtils.sqlScripts.noteTagNoteId;
  final _manytagId = SqlUtils.sqlScripts.noteTagTagId;

  @override
  Future<void> add(Tag tag) async {
    _db = await SqlConnection.get();

    await _db!
        .rawInsert("INSERT INTO $_tagTable ($_tagName) VALUES (?)", [tag.name]);
  }

  @override
  Future<List<Tag>> getAll() async {
    _db = await SqlConnection.get();

    final List<Map<String, dynamic>> result =
        await _db!.rawQuery("SELECT * FROM $_tagTable", []);

    final List<Tag> tags = List.generate(result.length, (index) {
      final Map<String, dynamic> map = result[index];

      return Tag(id: map[_tagId], name: map[_tagName]);
    });

    return tags;
  }

  @override
  Future<List<Tag>> getAllFromNote(int noteId) async {
    _db = await SqlConnection.get();

    final List<Map<String, dynamic>> result = await _db!.rawQuery(
        "SELECT t.$_tagId, t.$_tagName FROM $_tagTable as t INNER JOIN $_manyTable as m ON m.$_manytagId = t.$_tagId WHERE m.$_manynoteId = ?",
        [noteId]);

    final List<Tag> tags = List.generate(
      result.length,
      (index) {
        final Map<String, dynamic> map = result[index];

        return Tag(
          id: map[_tagId],
          name: map[_tagName],
        );
      },
    );

    return tags;
  }

  @override
  Future<Tag> getLast() async {
    _db = await SqlConnection.get();

    final List<Map<String, dynamic>> result = await _db!
        .rawQuery("SELECT * FROM $_tagTable ORDER BY $_tagId DESC LIMIT 1");

    final List<Tag> tags = List.generate(
      result.length,
      (index) {
        final Map<String, dynamic> map = result[index];

        return Tag(
          id: map[_tagId],
          name: map[_tagName],
        );
      },
    );

    return tags[0];
  }

  @override
  Future<void> addToNote(int noteId, int tagId) async {
    _db = await SqlConnection.get();

    await _db!.rawInsert(
        "INSERT INTO $_manyTable ($_manynoteId, $_manytagId) VALUES (?, ?)",
        [noteId, tagId]);
  }

  @override
  Future<void> removeFromNote(int noteId, int tagId) async {
    _db = await SqlConnection.get();

    await _db!.rawDelete(
        "DELETE FROM $_manyTable WHERE $_manynoteId = ? AND $_manytagId = ?",
        [noteId, tagId]);
  }

  @override
  Future<Tag?> getOne(int id) {
    // TODO: implement getOne
    throw UnimplementedError();
  }

  @override
  Future<void> remove(int id) async {
    _db = await SqlConnection.get();

    await _db!.rawDelete("DELETE FROM $_tagTable WHERE $_tagId = ?", [id]);
  }

  @override
  Future<void> update(Tag tag) async {
    _db = await SqlConnection.get();

    _db!.rawUpdate("UPDATE $_tagTable SET $_tagName = ? WHERE $_tagId = ?",
        [tag.name, tag.id!]);
  }
}
