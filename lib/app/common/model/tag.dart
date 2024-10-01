/// Tag
///
/// A tag class.
class Tag {
  int? id;
  String name;

  Tag({this.id, required this.name});

  @override
  String toString() {
    return "Tag(id: $id, name: \"$name\")";
  }

  @override
  bool operator ==(Object other) {
    if (other is Tag) {
      if (other.name == name && other.id == id) {
        return true;
      }
    }

    return false;
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode;
}
