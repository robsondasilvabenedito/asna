import 'package:asna/app/common/dao/tag_dao.dart';
import 'package:asna/app/common/dao/tag_sql.dart';
import 'package:asna/app/common/model/tag.dart';
import 'package:asna/app/common/services/note_service.dart';

class TagService {
  final TagDAO _tagDAO = TagSql();
  final NoteService _noteService = NoteService();

  Future<void> add(Tag tag) async {
    await _tagDAO.add(tag);
  }

  Future<void> remove(int id) async {
    await _tagDAO.remove(id);
  }

  Future<void> update(Tag tag) async {
    await _tagDAO.update(tag);
  }

  Future<Tag> getLast() async {
    return await _tagDAO.getLast();
  }

  Future<List<Tag>> getAll() async {
    return await _tagDAO.getAll();
  }

  Future<List<Tag>> getAllFromNote(int noteId) async {
    return await _tagDAO.getAllFromNote(noteId);
  }

  Future<void> updateNoteTags(int noteId, List<Tag> tags) async {
    final List<Tag> currentTags = await _tagDAO.getAllFromNote(noteId);

    final List<Tag> tagsToRemove =
        currentTags.where((tag) => !tags.contains(tag)).toList();
    final List<Tag> tagsToAdd =
        tags.where((tag) => !currentTags.contains(tag)).toList();

    for (Tag tag in tagsToRemove) {
      await _tagDAO.removeFromNote(noteId, tag.id!);
    }

    for (Tag tag in tagsToAdd) {
      await _tagDAO.addToNote(noteId, tag.id!);
    }
  }
}
