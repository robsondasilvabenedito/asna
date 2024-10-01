import 'package:flutter/material.dart';
import 'package:asna/app/common/model/tag.dart';

class TagCard extends StatelessWidget {
  const TagCard({
    super.key,
    required this.tag,
    this.onTap,
    this.background,
    this.longPress,
  });

  /// Tag
  ///
  /// This [Tag].
  final Tag tag;

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
              tag.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 25,
                color: Color(0xFF322C2B),
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
