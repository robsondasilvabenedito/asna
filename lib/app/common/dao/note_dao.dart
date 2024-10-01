import 'package:asna/app/common/model/note.dart';
import 'package:asna/app/common/model/tag.dart';

abstract class NoteDAO {
  Future<List<Note>> getAll();

  Future<List<Note>> getAllByTag(Tag tag);

  Future<List<Note>> getAllWithoutTag();

  Future<Note?> getOne(int id);

  Future<Note> getLast();

  Future<void> add(Note note);

  Future<void> update(Note note);

  Future<void> remove(int id);
}
