import 'package:flutter/material.dart';
import 'package:asna/app/common/model/tag.dart';
import 'package:asna/app/common/services/tag_service.dart';

class TagProvider extends ChangeNotifier {
  final TagService _tagService = TagService();

  late final Tag _tag;

  final TextEditingController controller = TextEditingController();

  bool tagHasChanged = false;

  int _previousLen = 0;

  TagProvider(Tag tag) {
    _tag = tag;

    controller.text = _tag.name;
    controller.addListener(_listenTagContoller);
  }

  void _listenTagContoller() {
    if (_previousLen == controller.text.length) {
      return;
    }

    tagHasChanged = true;
    notifyListeners();
  }

  Future<void> updateTag() async {
    if (tagHasChanged) {
      _tag.name = controller.text;

      if (_tag.id == null) {
        await _tagService.add(_tag);
        _tag.id = (await _tagService.getLast()).id;
      } else {
        await _tagService.update(_tag);
      }

      tagHasChanged = false;
    }

    notifyListeners();
  }

  void resetTag() {
    controller.text = _tag.name;
    notifyListeners();
  }
}
