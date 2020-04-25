class EvoTag {
  String id;
  String name;
  List<dynamic> list;

  EvoTag({this.id, this.name, this.list});

  factory EvoTag.fromMap(Map<String, dynamic> data, String id) {
    print("data :$data");

    if (data == null) {
      return null;
    }

    return EvoTag(
      id: id,
      name: data['name'],
      list: data['list'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'list': list,
    };
  }
}
