class EvoPackage {
  String id;
  String name;
  List<dynamic> list;
  List<String> tags;

  EvoPackage({this.id, this.name, this.tags, this.list});

  factory EvoPackage.fromMap(Map<String, dynamic> data, String moodId) {
    if (data == null) {
      return null;
    }

    return EvoPackage(
      id: moodId,
      name: data['name'],
      tags: data['tags'],
      list: data['list'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'tags': tags,
      'list': list,
    };
  }
}
