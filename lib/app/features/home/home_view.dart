import 'package:flutter/material.dart';
import 'package:asna/app/common/model/note.dart';
import 'package:asna/app/common/model/tag.dart';
import 'package:asna/app/common/provider/app_provider.dart';
import 'package:asna/app/common/widget/tag_list.dart';
import 'package:asna/app/features/home/home_provider.dart';
import 'package:asna/app/features/home/widgets/note_list.dart';
import 'package:asna/app/features/home/widgets/tag_card.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("ASNA"),
          centerTitle: true,
          backgroundColor: const Color(0xFFBD743D),
        ),
        backgroundColor: const Color(0xFFE4C59E),
        body: Consumer3<AppProvider, TagListProvider, HomeProvider>(
            builder: (context, pApp, pTagList, pHome, child) {
          if (pApp.isLoading) {
            return const Center(
                child: SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ));
          }

          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...pHome.isNoteView
                    ? [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                            left: 10,
                            right: 10,
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: pHome.selectedId.isNotEmpty
                                    ? null
                                    : () {
                                        pTagList.setSelected(pApp.tagFilters);

                                        showDialog(
                                            context: context,
                                            builder: (context) => TagList(
                                                  title: "Filter",
                                                  onConfirm: () async {
                                                    pApp.tagFilters =
                                                        pTagList.selectedTags;

                                                    await pApp.updateData();

                                                    if (context.mounted) {
                                                      Navigator.of(context)
                                                          .pop();
                                                    }
                                                  },
                                                ));
                                      },
                                child: const Icon(Icons.filter_alt_sharp),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                            left: 10,
                            right: 10,
                          ),
                          child: Wrap(
                            children: pApp.tagFilters.length ==
                                        pApp.tagList.length ||
                                    pApp.tagFilters.isEmpty
                                ? [
                                    Container(
                                      constraints: const BoxConstraints(
                                        minWidth: 50,
                                      ),
                                      decoration: BoxDecoration(
                                          color: pApp.tagFilters.isEmpty
                                              ? const Color(0xFFE4C59E)
                                              : const Color(0xFFBD743D),
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                            fontSize: 15,
                                            color: Color(0xFF322C2B)),
                                      ),
                                    )
                                  ]
                                : pApp.tagFilters
                                    .map(
                                      (tag) => Container(
                                        constraints: const BoxConstraints(
                                          minWidth: 50,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFBD743D),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Color(0xFF666262),
                                                blurRadius: 2.5,
                                                offset: Offset(0.0, 0.5))
                                          ],
                                        ),
                                        padding: const EdgeInsets.only(
                                          top: 3,
                                          bottom: 3,
                                          left: 5,
                                          right: 5,
                                        ),
                                        margin: const EdgeInsets.only(right: 3),
                                        child: Text(
                                          tag.name,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Color(0xFF322C2B)),
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                        )
                      ]
                    : [
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 5,
                          ),
                        ),
                      ],
                Expanded(
                  child: Stack(
                    children: [
                      ListView(
                        children: [
                          ...pHome.isNoteView
                              ? pApp.noteList.asMap().entries.map(
                                  (entry) {
                                    int index = entry.key;

                                    Note note = entry.value;
                                    List<Tag> tags = pApp.nodeTagsList[index];

                                    return NoteList(
                                      note: note,
                                      tags: tags,
                                      background:
                                          pHome.selectedId.contains(note.id!)
                                              ? const Color(0xFF9A3B3B)
                                              : const Color(0xFFE4C59E),
                                      onTap: () {
                                        if (pHome.selectedId.isEmpty) {
                                          pHome.goToNote(context, note, tags);
                                        } else {
                                          pHome.toggleSelectedId(note.id!);
                                        }
                                      },
                                      longPress: () {
                                        pHome.toggleSelectedId(note.id!);
                                      },
                                    );
                                  },
                                ).toList()
                              : pApp.tagList.asMap().entries.map(
                                  (entry) {
                                    Tag tag = entry.value;

                                    return TagCard(
                                      tag: tag,
                                      background:
                                          pHome.selectedId.contains(tag.id!)
                                              ? const Color(0xFF9A3B3B)
                                              : const Color(0xFFE4C59E),
                                      onTap: () {
                                        if (pHome.selectedId.isEmpty) {
                                          pHome.goToTag(context, tag);
                                        } else {
                                          pHome.toggleSelectedId(tag.id!);
                                        }
                                      },
                                      longPress: () {
                                        pHome.toggleSelectedId(tag.id!);
                                      },
                                    );
                                  },
                                ).toList(),
                        ],
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: pHome.selectedId.isEmpty
                              ? [
                                  GestureDetector(
                                    onTap: () {
                                      pHome.isNoteView = !pHome.isNoteView;
                                    },
                                    child: Icon(
                                      pHome.isNoteView
                                          ? Icons.label_sharp
                                          : Icons.note_sharp,
                                      size: 50,
                                      color: const Color(0xFF322C2B),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (pHome.isNoteView) {
                                        pHome.goToNote(
                                            context, Note(text: ""), []);
                                      } else {
                                        pHome.goToTag(context, Tag(name: ""));
                                      }
                                    },
                                    child: const Icon(
                                      Icons.add_circle_outline_sharp,
                                      size: 50,
                                      color: Color(0xFF322C2B),
                                    ),
                                  ),
                                ]
                              : [
                                  GestureDetector(
                                    onTap: () async {
                                      await pHome.deleteSelectedId();

                                      if (!pHome.isNoteView) {
                                        pApp.tagFilters.removeWhere(
                                          (tag) =>
                                              pHome.selectedId.contains(tag.id),
                                        );
                                      }

                                      pHome.selectedId.clear();
                                      await pApp.updateData();
                                    },
                                    child: const Icon(
                                      Icons.delete_forever_sharp,
                                      size: 50,
                                      color: Color(0xFF322C2B),
                                    ),
                                  ),
                                ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]);
        }),
      ),
    );
  }
}
