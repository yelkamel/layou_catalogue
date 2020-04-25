import 'package:uuid/uuid.dart';

class UtilsDatabase {
  static String documentUniqueId() {
    String id = Uuid().v1();
    return id;
  }
}
