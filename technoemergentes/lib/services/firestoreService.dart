import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<DocumentSnapshot>> getDocuments() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('demandes').get();
    return querySnapshot.docs;
  }
  //ajoute une demande dans la base de données
  Future<void> addDocument(String inputText, dynamic prediction, String importanceLevel) async {
    String id = _firestore.collection('demandes').doc().id;
    Map<String, dynamic> data = {
      'id' : id,
      'demande': inputText,
      'label': prediction,
      'typeUrgence': importanceLevel,
      'demandeTraitee': false,
    };

    await _firestore.collection('demandes').doc(id).set(data);
  }
  //marque une demande comme traitée
  Future<void> demandeTraitee(String documentId) async {
    await _firestore.collection('demandes').doc(documentId).update({
      'demandeTraitee': true,
    });
  }

}
