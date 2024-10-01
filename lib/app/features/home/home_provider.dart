import 'package:flutter/material.dart';
import 'package:asna/app/app.dart';
import 'package:asna/app/common/model/args.dart';
import 'package:asna/app/common/model/note.dart';
import 'package:asna/app/common/model/tag.dart';
import 'package:asna/app/common/services/note_service.dart';
import 'package:asna/app/common/services/tag_service.dart';

class HomeProvider extends ChangeNotifier {
  final TagService _tagService = TagService();
  final NoteService _noteService = NoteService();

  final TextEditingController tagController = TextEditingController();

  final List<int> selectedId = [];

  bool _isNoteView = true;

  bool get isNoteView => _isNoteView;
  void set isNoteView(bool isNoteView) {
    _isNoteView = isNoteView;
    notifyListeners();
  }

  @override
  void dispose() {
    tagController.dispose();

    super.dispose();
  }

  Future<void> newTag() async {
    await _tagService.add(Tag(name: tagController.text));
  }

  Future<void> deleteSelectedId() async {
    if (isNoteView) {
      for (int id in selectedId) {
        await _noteService.remove(id);
      }
    } else {
      for (int id in selectedId) {
        await _tagService.remove(id);
      }
    }
  }

  void toggleSelectedId(int id) {
    if (!selectedId.contains(id)) {
      selectedId.add(id);
    } else {
      selectedId.remove(id);
    }

    notifyListeners();
  }

  void goToNote(BuildContext context, Note note, List<Tag> tags) {
    Navigator.of(context).pushNamed(
      App.routeNote,
      arguments: Args(
        note: note,
        tags: tags,
      ),
    );
  }

  void goToTag(BuildContext context, Tag tag) {
    Navigator.of(context).pushNamed(
      App.routeTag,
      arguments: Args(
        tag: tag,
      ),
    );
  }
}
