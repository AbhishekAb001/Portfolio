import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreservice {
  Future<List<Map<String, dynamic>>> getProjectBySubject(String subject) async {
    log(subject);
    List<Map<String, dynamic>> projects = [];
    QuerySnapshot docs = await FirebaseFirestore.instance
        .collection(subject.toLowerCase())
        .get();
    List<QueryDocumentSnapshot> docRef = docs.docs;
    for (var doc in docRef) {
      projects.add(doc.data() as Map<String, dynamic>);
    }
    return projects;
  }
}
