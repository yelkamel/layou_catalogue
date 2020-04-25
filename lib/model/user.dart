class User {
  String uid;
  String email;
  String name;
  String status;

  User({
    this.uid,
    this.email,
    this.name,
    this.status,
  });

  factory User.fromMap(Map<String, dynamic> data, String uid) {
    if (data == null) {
      return null;
    }

    return User(
      uid: uid,
      email: data['email'],
      name: data['name'],
      status: data['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'status': status,
    };
  }
}
