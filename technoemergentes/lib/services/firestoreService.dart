import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<DocumentSnapshot>> getDocuments() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('demandes').get();
    return querySnapshot.docs;
  }

  Future<void> addDocument(String inputText, dynamic prediction) async {
    Map<String, dynamic> data = {
      'demande': inputText,
      'label': prediction,
    };

    await _firestore.collection('demandes').add(data);
  }

}
