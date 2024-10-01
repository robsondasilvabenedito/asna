import 'package:asna/app/common/dao/note_dao.dart';
import 'package:asna/app/common/database/sql.dart';
import 'package:asna/app/common/database/sql_utils.dart';
import 'package:asna/app/common/model/note.dart';
import 'package:asna/app/common/model/tag.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class NoteSql implements NoteDAO {
  Database? _db;

  final _noteTable = SqlUtils.sqlScripts.noteTable;

  final _noteId = SqlUtils.sqlScripts.noteId;
  final _noteText = SqlUtils.sqlScripts.noteText;

  final _manyTable = SqlUtils.sqlScripts.noteTagTable;

  final _manynoteId = SqlUtils.sqlScripts.noteTagNoteId;
  final _manytagId = SqlUtils.sqlScripts.noteTagTagId;

  @override
  Future<void> add(Note note) async {
    _db = await SqlConnection.get();

    await _db!.rawInsert(
        "INSERT INTO $_noteTable ($_noteText) VALUES (?)", [note.text]);
  }

  @override
  Future<List<Note>> getAll() async {
    _db = await SqlConnection.get();

    final List<Map<String, dynamic>> result =
        await _db!.rawQuery("SELECT * FROM $_noteTable");

    final List<Note> notes = List.generate(
      result.length,
      (index) {
        final Map<String, dynamic> map = result[index];

        return Note(id: map[_noteId], text: map[_noteText]);
      },
    );

    return notes;
  }

  @override
  Future<List<Note>> getAllByTag(Tag tag) async {
    _db = await SqlConnection.get();

    final List<Map<String, dynamic>> result = await _db!.rawQuery(
        "SELECT n.$_noteId, n.$_noteText FROM $_noteTable as n INNER JOIN $_manyTable as m ON m.$_manynoteId = n.$_noteId WHERE m.$_manytagId = ?",
        [tag.id]);

    List<Note> notes = List.generate(
      result.length,
      (index) {
        Map<String, dynamic> map = result[index];

        return Note(id: map[_noteId], text: map[_noteText]);
      },
    );

    return notes;
  }

  @override
  Future<List<Note>> getAllWithoutTag() async {
    _db = await SqlConnection.get();

    final List<Map<String, dynamic>> result = await _db!.rawQuery(
        "SELECT n.$_noteId, n.$_noteText FROM $_noteTable AS n WHERE NOT EXISTS (SELECT 1 FROM $_manyTable AS m WHERE m.$_manynoteId = n.$_noteId)");

    List<Note> notes = List.generate(
      result.length,
      (index) {
        Map<String, dynamic> map = result[index];

        return Note(id: map[_noteId], text: map[_noteText]);
      },
    );

    return notes;
  }

  @override
  Future<Note?> getOne(int id) {
    // TODO: implement getOne
    throw UnimplementedError();
  }

  @override
  Future<Note> getLast() async {
    _db = await SqlConnection.get();

    final List<Map<String, dynamic>> result = await _db!
        .rawQuery("SELECT * FROM $_noteTable ORDER BY $_noteId DESC LIMIT 1");

    final List<Note> notes = List.generate(
      result.length,
      (index) {
        final Map<String, dynamic> map = result[index];

        return Note(id: map[_noteId], text: map[_noteText]);
      },
    );

    return notes[0];
  }

  @override
  Future<void> remove(int id) async {
    _db = await SqlConnection.get();

    await _db!.rawDelete("DELETE FROM $_noteTable WHERE $_noteId = ?", [id]);
  }

  @override
  Future<void> update(Note note) async {
    _db = await SqlConnection.get();

    _db!.rawUpdate("UPDATE $_noteTable SET $_noteText = ? WHERE $_noteId = ?",
        [note.text, note.id!]);
  }
}
