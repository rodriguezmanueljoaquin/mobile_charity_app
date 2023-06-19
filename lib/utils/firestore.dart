import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

Map<String, dynamic> buildProperties(DocumentSnapshot<Object?> doc) {
  Map<String, dynamic> properties = doc.data() as Map<String, dynamic>;
  properties['id'] = doc.id;
  return properties;
}

Future<void> uploadFile({
  required String key,
  required File file,
}) async {
  await FirebaseStorage.instance.ref(key).putFile(file);
}

Future<String> getDownloadURL({
  required String key,
}) async {
  return await FirebaseStorage.instance.ref(key).getDownloadURL();
}
