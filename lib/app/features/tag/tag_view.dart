import 'package:flutter/material.dart';
import 'package:asna/app/common/model/tag.dart';
import 'package:asna/app/common/provider/app_provider.dart';
import 'package:asna/app/features/tag/tag_provider.dart';
import 'package:provider/provider.dart';

class TagView extends StatelessWidget {
  const TagView({
    super.key,
    required this.tag,
  });

  /// Tag
  ///
  /// View [Tag].
  final Tag tag;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TagProvider(tag),
      child: Consumer2<AppProvider, TagProvider>(
          builder: (context, pApp, pTag, child) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(
              size: 30,
              color: Color(0xFF322C2B),
            ),
            centerTitle: true,
            actions: [
              GestureDetector(
                  onTap: pTag.tagHasChanged
                      ? () async {
                          await pTag.updateTag();
                          await pApp.updateData();
                        }
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Icon(Icons.check_sharp,
                        color: pTag.tagHasChanged
                            ? const Color(0xFF322C2B)
                            : const Color(0xFF8B8584)),
                  )),
              GestureDetector(
                  onTap: pTag.tagHasChanged
                      ? () {
                          pTag.resetTag();
                        }
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Icon(Icons.close_sharp,
                        color: pTag.tagHasChanged
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
                Expanded(
                  child: ListView(
                    children: [
                      TextField(
                        controller: pTag.controller,
                        minLines: 2,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: "Tag name...",
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
