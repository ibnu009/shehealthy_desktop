import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../data/response/classification_response.dart';
import '../network/network_service.dart';

class ClassificationRepository extends NetworkService {
  ClassificationRepository();

  final storage = const FlutterSecureStorage();

  ClassificationRepository._privateConstructor();

  static final ClassificationRepository _instance = ClassificationRepository._privateConstructor();

  static ClassificationRepository get instance => _instance;

  Map<String, String> header = {};
  final String contentType = "Content-Type";
  final String applicationJson = "application/json";
  final String token = "token";

  Future<ClassificationResponse> uploadClassification(
      File file) async {
    String? readData = await storage.read(key: 'token') ?? "";

    var header = {contentType: applicationJson, token: readData};
    var map = await createClassificationPost(
        "$BASE_URL/uploadfile/",
        file: file,
        header: header);

    return ClassificationResponse.fromJson(map);
  }
}
