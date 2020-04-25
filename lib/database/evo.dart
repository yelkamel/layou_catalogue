import 'dart:async';
import 'package:layou_catalogue/model/evo_package.dart';
import 'package:layou_catalogue/model/evo_tag.dart';

import '../service/firestore_service.dart';
import '../model/evo.dart';
import '../utils/api_path.dart';

class EvoDatabase {
  EvoDatabase();

  final _service = FirestoreService.instance;

  Future<void> setEvo(Evo evo) async => await _service.setData(
        path: APIPath.evo(evo.id),
        data: evo.toMap(),
      );

  Future<Evo> getEvo(String evoId) => _service.getDocument(
        builder: (data, documentId) => Evo.fromMap(data, documentId),
        path: APIPath.evo(evoId),
      );

  @override
  Future<void> deleteEvo(Evo evo) async =>
      await _service.deleteData(path: APIPath.evo(evo.id));

  Stream<List<Evo>> evoStream(List<dynamic> tags) => _service.collectionStream(
        builder: (data, documentId) => Evo.fromMap(data, documentId),
        path: APIPath.allEvo(),
        queryBuilder: (query) {
          return query
              .orderBy('position')
              .where('tags', arrayContainsAny: tags);
        },
      );

  Stream<List<Evo>> allEvoStream() => _service.collectionStream(
        builder: (data, documentId) => Evo.fromMap(data, documentId),
        path: APIPath.allEvo(),
      );

  Future<List<Evo>> getPackageEvo(List<String> tags) => _service.getCollection(
        builder: (data, documentId) => Evo.fromMap(data, documentId),
        path: APIPath.allEvo(),
        queryBuilder: (query) {
          return query.where('tags', arrayContainsAny: tags);
        },
      );

  Stream<EvoPackage> evoPackageStream(String packageID) =>
      _service.documentStream(
        builder: (data, documentId) => EvoPackage.fromMap(data, documentId),
        path: APIPath.getPackage(packageID),
      );

  Stream<EvoTag> tagsStream() => _service.documentStream(
        builder: (data, documentId) => EvoTag.fromMap(data, documentId),
        path: APIPath.tagStream(),
      );
}
