import 'package:cloud_firestore/cloud_firestore.dart';

Map<String, dynamic> buildProperties(DocumentSnapshot<Object?> doc) {
  Map<String, dynamic> properties = doc.data() as Map<String, dynamic>;
  properties['id'] = doc.id;
  return properties;
}