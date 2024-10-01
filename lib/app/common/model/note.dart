/// Note
///
/// A note class.
class Note {
  int? id;
  String text;

  Note({this.id, required this.text});

  @override
  bool operator ==(Object other) {
    if (other is Note) {
      if (other.id == id && other.text == text) {
        return true;
      }
    }

    return false;
  }

  @override
  int get hashCode => id.hashCode ^ text.hashCode;
}
