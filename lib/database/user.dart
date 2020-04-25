import 'dart:async';

import '../model/user.dart';
import '../service/firestore_service.dart';
import '../utils/api_path.dart';

class UserDatabase {
  UserDatabase();

  final _service = FirestoreService.instance;

  Future<void> setUser(User user) async => await _service.setData(
        path: APIPath.user(user.uid),
        data: user.toMap(),
      );

  Stream<User> userStream(String uid) => _service.documentStream(
        builder: (data, documentId) => User.fromMap(data, documentId),
        path: APIPath.user(uid),
      );

  Future<User> getUser(String uid) => _service.getDocument(
        builder: (data, uid) => User.fromMap(data, uid),
        path: APIPath.user(uid),
      );
}
