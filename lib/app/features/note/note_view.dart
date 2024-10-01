import 'package:flutter/material.dart';
import 'package:asna/app/common/model/note.dart';
import 'package:asna/app/common/model/tag.dart';
import 'package:asna/app/common/provider/app_provider.dart';
import 'package:asna/app/common/widget/tag_list.dart';
import 'package:asna/app/features/note/note_provider.dart';
import 'package:provider/provider.dart';

class NoteView extends StatelessWidget {
  const NoteView({
    super.key,
    required this.note,
    required this.tags,
  });

  /// Note
  ///
  /// The context [Note].
  final Note note;

  /// Tags
  ///
  /// List of [Tag] of the current [Note].
  final List<Tag> tags;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NoteProvider(note, tags),
      child: Consumer3<AppProvider, TagListProvider, NoteProvider>(
          builder: (context, pApp, pTagList, pNote, child) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(
              size: 30,
              color: Color(0xFF322C2B),
            ),
            centerTitle: true,
            actions: [
              GestureDetector(
                  onTap: (pNote.textHasChanged || pNote.tagsHasChanged)
                      ? () async {
                          await pNote.updateAll();
                          await pApp.updateData();
                        }
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Icon(Icons.check_sharp,
                        color: (pNote.textHasChanged || pNote.tagsHasChanged)
                            ? const Color(0xFF322C2B)
                            : const Color(0xFF8B8584)),
                  )),
              GestureDetector(
                  onTap: (pNote.textHasChanged || pNote.tagsHasChanged)
                      ? () {
                          pNote.resetAll();
                        }
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Icon(Icons.close_sharp,
                        color: (pNote.textHasChanged || pNote.tagsHasChanged)
                            ? const Color(0xFF322C2B)
                            : const Color(0xFF8B8584)),
                  ))
            ],
            backgroundColor: const Color(0xFFE4C59E),
          ),
          backgroundColor: const Color(0xFFE4C59E),
          body: Padding(
            padding:
                const EdgeInsets.only(top: 3, bottom: 3, left: 5, right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    ...pNote.tempTags.length == pApp.tagList.length
                        ? [
                            Container(
                              constraints: const BoxConstraints(
                                minWidth: 50,
                              ),
                              decoration: BoxDecoration(
                                  color: const Color(0xFFBD743D),
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color(0xFF666262),
                                        blurRadius: 2.5,
                                        offset: Offset(0.0, 0.5))
                                  ]),
                              padding: const EdgeInsets.only(
                                  top: 3, bottom: 3, left: 5, right: 5),
                              child: const Text(
                                "all",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15, color: Color(0xFF322C2B)),
                              ),
                            )
                          ]
                        : pNote.tempTags
                            .map((tag) => Container(
                                  constraints: const BoxConstraints(
                                    minWidth: 50,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFBD743D),
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Color(0xFF666262),
                                          blurRadius: 2.5,
                                          offset: Offset(0.0, 0.5))
                                    ],
                                  ),
                                  padding: const EdgeInsets.only(
                                      top: 3, bottom: 3, left: 5, right: 5),
                                  margin: const EdgeInsets.only(right: 3),
                                  child: Text(
                                    tag.name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 15, color: Color(0xFF322C2B)),
                                  ),
                                ))
                            .toList(),
                    GestureDetector(
                      onTap: () {
                        pTagList.setSelected(pNote.tempTags);

                        showDialog(
                            context: context,
                            builder: (_) => TagList(
                                  title: "Tag",
                                  onConfirm: () async {
                                    pNote.tempTags = pTagList.selectedTags;

                                    pNote.tagsChanged();

                                    if (context.mounted) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ));
                      },
                      child: const Icon(
                        Icons.add_circle_outline_sharp,
                        size: 35,
                        color: Color(0xFF322C2B),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: [
                      TextField(
                        controller: pNote.controller,
                        minLines: 2,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: "Type here...",
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        style: const TextStyle(
                            fontSize: 25, color: Color(0xFF322C2B)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
