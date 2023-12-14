import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:technoemergentes/services/firestoreService.dart';

class ClassificationPage extends StatefulWidget {
  @override
  _ClassificationPageState createState() => _ClassificationPageState();
}

class _ClassificationPageState extends State<ClassificationPage> {
  final FirestoreService _firestoreService = FirestoreService();
  late Map<String, List<DocumentSnapshot>> _complaintsByLabel = {};
  late String _selectedLabel;

  @override
  void initState() {
    super.initState();
    _loadComplaints();
    _selectedLabel = 'signalement urbain';
  }

  Future<void> _loadComplaints() async {
    List<DocumentSnapshot> complaints = await _firestoreService.getDocuments();

    // Group complaints by label
    _complaintsByLabel = {};
    for (var complaint in complaints) {
      final label = complaint['label'];
      if (!_complaintsByLabel.containsKey(label)) {
        _complaintsByLabel[label] = [];
      }
      _complaintsByLabel[label]!.add(complaint);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Classification des demandes'),
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: _selectedLabel,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedLabel = newValue;
                });
              }
            },
            items: [
              'signalement urbain',
              'proposition d\'idée',
              'signalement sur la chaussée',
            ].map<DropdownMenuItem<String>>((String label) {
              return DropdownMenuItem<String>(
                value: label,
                child: Text(label),
              );
            }).toList(),
            hint: Text('Select Label'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _selectedLabel.isEmpty
                  ? _complaintsByLabel.length
                  : (_complaintsByLabel[_selectedLabel]?.length ?? 0),
              itemBuilder: (context, index) {
                final label = _selectedLabel.isEmpty
                    ? _complaintsByLabel.keys.toList()[index]
                    : _selectedLabel;
                final complaints = _complaintsByLabel[label] ?? [];
                final complaint = complaints[index].data() as Map<String, dynamic>;
                final inputText = complaint['demande'];
                final prediction = complaint['label'];

                return Card(
                  child: ListTile(
                    title: Text('Demande ${index + 1}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Text: $inputText'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}