import 'package:flutter/material.dart';
import 'package:asna/app/common/model/note.dart';
import 'package:asna/app/common/model/tag.dart';

class NoteList extends StatelessWidget {
  const NoteList({
    super.key,
    required this.note,
    required this.tags,
    this.onTap,
    this.background,
    this.longPress,
  });

  /// Note
  ///
  /// This [Note].
  final Note note;

  /// Tags
  ///
  /// List of [Tag] for if this [Note].
  final List<Tag> tags;

  /// OnTap
  ///
  /// OnTap function.
  final void Function()? onTap;

  /// LongPress
  ///
  /// LongPress function.
  final void Function()? longPress;

  /// Background
  ///
  /// Brackground color.
  final Color? background;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: longPress,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(
          minHeight: 80,
        ),
        margin: const EdgeInsets.only(
          bottom: 5,
          top: 5,
          left: 10,
          right: 10,
        ),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFF666262),
              blurRadius: 2.5,
              offset: Offset(0.0, 0.5),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.text.split("\n").first,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 25,
                color: Color(0xFF322C2B),
              ),
              textAlign: TextAlign.left,
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: tags
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
                              offset: Offset(0.0, 0.5),
                            )
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
                            color: Color(0xFF322C2B),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
