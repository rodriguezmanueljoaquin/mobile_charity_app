import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class SerManosStorage {
  static final SerManosStorage _serManosStorage = SerManosStorage._internal();
  static FirebaseStorage _storage = FirebaseStorage.instance;

  factory SerManosStorage() {
    return _serManosStorage;
  }

  void setStorage(FirebaseStorage storage) {
    // method for testing purposes
    _storage = storage;
  }

  SerManosStorage._internal();

  Future<void> uploadFile({
    required String key,
    required File file,
  }) async {
    await _storage.ref(key).putFile(file);
  }

  Future<String> getDownloadURL({
    required String key,
  }) async {
    return await _storage.ref(key).getDownloadURL();
  }
}
