import 'package:flutter/material.dart';
import 'package:asna/app/common/model/tag.dart';
import 'package:asna/app/common/provider/app_provider.dart';
import 'package:asna/app/common/widget/button.dart';
import 'package:provider/provider.dart';

class TagListProvider extends ChangeNotifier {
  List<Tag> selectedTags = [];

  void setSelected(List<Tag> tags) {
    selectedTags = tags.map((tag) => tag).toList();
    notifyListeners();
  }

  bool hasAll(List<Tag> tags) {
    if (selectedTags.length == tags.length) {
      return true;
    }

    return false;
  }

  void toggleAll(List<Tag> tags) {
    if (selectedTags.length == tags.length) {
      selectedTags.clear();
    } else {
      selectedTags = tags.map((tag) => tag).toList();
    }

    notifyListeners();
  }

  bool hasTag(Tag tag) {
    return selectedTags.contains(tag);
  }

  void toggleTag(Tag tag) {
    if (selectedTags.contains(tag)) {
      selectedTags.remove(tag);
    } else {
      selectedTags.add(tag);
    }

    notifyListeners();
  }
}

class TagList extends StatelessWidget {
  const TagList({
    super.key,
    required this.title,
    required this.onConfirm,
  });

  /// Title
  ///
  /// Dialog title.
  final String title;

  /// OnConfirm
  ///
  /// Function called when the confirm button is pressed.
  final void Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFFE4C59E),
      titlePadding: const EdgeInsets.only(bottom: 10),
      title: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFBD743D),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
        ),
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF322C2B),
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: const EdgeInsets.all(10),
      content: Consumer2<AppProvider, TagListProvider>(
          builder: (context, pApp, pTagList, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Button(
              text: "all",
              minWidth: 40,
              background: pTagList.hasAll(pApp.tagList)
                  ? const Color(0xFFBD743D)
                  : const Color(0xFFE4C59E),
              onTap: () {
                pTagList.toggleAll(pApp.tagList);
              },
            ),
            const Divider(
              height: 20,
              thickness: 1,
              color: Color(0xFF322C2B),
            ),
            Wrap(
              children: [
                ...pApp.tagList.map(
                  (tag) {
                    bool hasTag = pTagList.hasTag(tag);

                    return Button(
                      text: tag.name,
                      background: hasTag
                          ? const Color(0xFFBD743D)
                          : const Color(0xFFE4C59E),
                      marginRight: 5,
                      onTap: () {
                        pTagList.toggleTag(tag);
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        );
      }),
      actionsPadding: const EdgeInsets.all(10),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Padding(
                padding: EdgeInsets.all(5),
                child: Icon(
                  Icons.close_sharp,
                  color: Color(0xFF322C2B),
                ))),
        Consumer2<AppProvider, TagListProvider>(
            builder: (context, pApp, pTagList, child) {
          return GestureDetector(
              onTap: onConfirm,
              child: const Padding(
                padding: EdgeInsets.all(5),
                child: Icon(
                  Icons.check_sharp,
                  color: Color(0xFF322C2B),
                ),
              ));
        }),
      ],
    );
  }
}
