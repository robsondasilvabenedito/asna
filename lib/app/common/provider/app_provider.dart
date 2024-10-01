import 'package:flutter/material.dart';
import 'package:asna/app/common/model/note.dart';
import 'package:asna/app/common/model/tag.dart';
import 'package:asna/app/common/services/note_service.dart';
import 'package:asna/app/common/services/tag_service.dart';

class AppProvider extends ChangeNotifier {
  final NoteService _noteService = NoteService();
  final TagService _tagService = TagService();

  bool isLoading = true;

  List<Note> noteList = [];
  List<Tag> tagList = [];

  List<List<Tag>> nodeTagsList = [];

  List<Tag> tagFilters = [];

  AppProvider() {
    _initialLoad();
  }

  Future<void> _initialLoad() async {
    await _loadData();
    tagFilters = tagList.map((tag) => tag).toList();
  }

  Future<void> updateData() async {
    await _loadData();
  }

  Future<void> _loadData() async {
    isLoading = true;
    notifyListeners();

    if (tagFilters.length == tagList.length) {
      noteList = await _noteService.getAll();
    } else {
      if (tagFilters.isEmpty) {
        noteList = await _noteService.getAllWithoutTag();
      } else {
        noteList = await _noteService.getAllByTags(tagFilters);
      }
    }

    tagList = await _tagService.getAll();

    nodeTagsList = [];

    for (Note note in noteList) {
      List<Tag> tags = await _tagService.getAllFromNote(note.id!);

      nodeTagsList.add(tags);
    }

    isLoading = false;
    notifyListeners();
  }
}
