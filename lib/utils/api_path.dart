class APIPath {
  static String evo(String id) => 'evo/$id';
  static String allEvo() => 'evo/';
  static String getPackage(String packageId) => 'package/$packageId';

  static String tagStream() => 'tag/initial';
  static String user(String uid) => 'user/$uid';

  static String evolist(String evoListId) => 'list/$evoListId';
  static String allEvolist() => 'list/';
}
