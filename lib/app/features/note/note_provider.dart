import 'package:flutter/material.dart';
import 'package:asna/app/common/model/note.dart';
import 'package:asna/app/common/model/tag.dart';
import 'package:asna/app/common/services/note_service.dart';
import 'package:asna/app/common/services/tag_service.dart';

class NoteProvider extends ChangeNotifier {
  final NoteService _noteService = NoteService();
  final TagService _tagService = TagService();

  late final Note _note;
  late final List<Tag> _tags;

  bool textHasChanged = false;
  bool tagsHasChanged = false;

  final TextEditingController controller = TextEditingController();
  List<Tag> tempTags = [];

  int _previousLen = 0;

  NoteProvider(Note note, List<Tag> tags) {
    _note = note;
    _tags = tags;

    _previousLen = _note.text.length;

    controller.text = _note.text;
    controller.addListener(_listenText);

    tempTags = _tags.map((tag) => tag).toList();
  }

  Future<void> updateNote() async {
    _note.text = controller.text;

    _noteService.update(_note);
  }

  void tagsChanged() {
    tagsHasChanged = true;
    notifyListeners();
  }

  void _listenText() {
    if (_previousLen == controller.text.length) {
      return;
    }

    textHasChanged = true;
    notifyListeners();
  }

  Future<void> updateAll() async {
    if (textHasChanged) {
      _note.text = controller.text;

      if (_note.id == null) {
        await _noteService.add(_note);
        _note.id = (await _noteService.getLast()).id;
      } else {
        await _noteService.update(_note);
      }

      textHasChanged = false;
    }

    if (tagsHasChanged) {
      await _tagService.updateNoteTags(_note.id!, tempTags!);

      tagsHasChanged = false;
    }

    notifyListeners();
  }

  void resetAll() {
    controller.text = _note.text;
    textHasChanged = false;

    tempTags = _tags;
    tagsHasChanged = false;

    notifyListeners();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
