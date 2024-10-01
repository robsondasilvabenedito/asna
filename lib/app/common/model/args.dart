import 'package:asna/app/common/model/note.dart';
import 'package:asna/app/common/model/tag.dart';

/// Args
///
/// Possibles arguments.
class Args {
  Note? note;
  Tag? tag;
  List<Tag>? tags;

  Args({
    this.note,
    this.tags,
    this.tag,
  });
}
