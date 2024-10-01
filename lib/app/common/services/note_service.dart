import 'package:asna/app/common/dao/note_dao.dart';
import 'package:asna/app/common/dao/note_sql.dart';
import 'package:asna/app/common/model/note.dart';
import 'package:asna/app/common/model/tag.dart';

class NoteService {
  final NoteDAO noteDao = NoteSql();

  Future<void> add(Note note) async {
    await noteDao.add(note);
  }

  Future<void> update(Note note) async {
    await noteDao.update(note);
  }

  Future<void> remove(int id) async {
    await noteDao.remove(id);
  }

  Future<List<Note>> getAllByTags(List<Tag> tags) async {
    final List<Note> notes = [];

    for (Tag tag in tags) {
      for (Note note in await noteDao.getAllByTag(tag)) {
        if (!notes.contains(note)) {
          notes.add(note);
        }
      }
    }

    return notes;
  }

  Future<List<Note>> getAllWithoutTag() async {
    return await noteDao.getAllWithoutTag();
  }

  Future<List<Note>> getAll() async {
    final notes = await noteDao.getAll();

    return notes;
  }

  Future<Note> getLast() async {
    return await noteDao.getLast();
  }
}
