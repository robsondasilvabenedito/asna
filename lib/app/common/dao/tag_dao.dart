import 'package:asna/app/common/model/tag.dart';

abstract class TagDAO {
  Future<List<Tag>> getAll();

  Future<Tag?> getOne(int id);

  Future<List<Tag>> getAllFromNote(int noteId);

  Future<Tag> getLast();

  Future<void> addToNote(int noteId, int tagId);

  Future<void> removeFromNote(int noteId, int tagId);

  Future<void> add(Tag tag);

  Future<void> update(Tag tag);

  Future<void> remove(int id);
}
