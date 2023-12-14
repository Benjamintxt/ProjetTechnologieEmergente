import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:technoemergentes/services/firestoreService.dart';


class ClassificationPage extends StatefulWidget {
  @override
  _ClassificationPageState createState() => _ClassificationPageState();
}

class _ClassificationPageState extends State<ClassificationPage> {
  final FirestoreService _firestoreService = FirestoreService();
  late List<DocumentSnapshot> _complaints = [];

  @override
  void initState() {
    super.initState();
    _loadComplaints();
  }
  
  Future<void> _loadComplaints() async {
    List<DocumentSnapshot> complaints = await _firestoreService.getDocuments();
    setState(() {
      _complaints = complaints;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaints Classification'),
      ),
      body: ListView.builder(
        itemCount: _complaints.length,
        itemBuilder: (context, index) {
          final complaint = _complaints[index].data() as Map<String, dynamic>;
          final inputText = complaint['demande'];
          final prediction = complaint['label'];

          return Card(
            child: ListTile(
              title: Text('Demande ${index + 1}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Text: $inputText'),
                  Text('Prediction: $prediction'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
