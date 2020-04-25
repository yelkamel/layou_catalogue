class Evo {
  String id;
  String name;
  String type;
  int position;
  int duration;
  String url;
  List<dynamic> tags;
  List<dynamic> list;

  Evo(
      {this.id,
      this.name,
      this.type,
      this.position,
      this.duration,
      this.tags,
      this.url,
      this.list});

  factory Evo.fromMap(Map<String, dynamic> data, String evoId) {
    if (data == null) {
      return null;
    }

    return Evo(
      id: evoId,
      name: data['name'],
      type: data['type'],
      position: data['position'],
      duration: data['duration'],
      url: data['url'],
      tags: data['tags'],
      list: data['list'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'position': position,
      'tags': tags,
      'list': list,
      'url': url,
      'duration': duration
    };
  }
}
