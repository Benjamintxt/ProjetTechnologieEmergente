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
  bool _sortAscending = true; // true for ascending, false for descending


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

  // Sort complaints within each label group
  _complaintsByLabel.forEach((label, complaints) {
    complaints.sort((a, b) {
      final importanceA = a['typeUrgence'];
      final importanceB = b['typeUrgence'];
      int result = _compareImportance(importanceA, importanceB);
      return _sortAscending ? result : -result;
    });
  });

  setState(() {});
}


  int _compareImportance(String levelA, String levelB) {
    // Define the order of importance levels
    final order = {
      'Très urgent': 0,
      'Urgent': 1,
      'Peu urgent': 2,
    };

    return order[levelA]!.compareTo(order[levelB]!);
  }
  
  Future<void> _markComplaintAsProcessed(DocumentSnapshot complaint) async {
    // Set 'demandeTraitee' field to true in Firestore
    await _firestoreService.demandeTraitee(complaint.id);
    // Reload complaints after updating Firestore
    await _loadComplaints();
  }

  Color _getLabelColor(String label) {
    switch (label) {
      case 'Très urgent':
        return Colors.red;
      case 'Urgent':
        return Colors.orange;
      case 'Peu urgent':
        return Colors.green;
      
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Classification des demandes'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("niveau d'urgence"),
              IconButton(
                icon: Icon(_sortAscending ? Icons.arrow_upward : Icons.arrow_downward),
                onPressed: () {
                  setState(() {
                    _sortAscending = !_sortAscending;
                    _loadComplaints();
                  });
                },
              ),
            ],
          ),
          DropdownButton<String>(
            value: _selectedLabel,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedLabel = newValue;
                  _loadComplaints();
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
                final importanceLevel = complaint['typeUrgence'];
                final demandeTraitee = complaint['demandeTraitee'] ?? false;

                if (demandeTraitee) {
                  return SizedBox.shrink();
                }

                return Card(
                  color: _getLabelColor(importanceLevel),
                  child: ListTile(
                    key: ValueKey(complaints[index].id),
                    title: Text('Demande ${index + 1}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$inputText'),
                      ],
                    ),
                     onTap: () async {
                      // Show a popup to ask if the complaint has been processed
                      bool isProcessed = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('La demande a-t-elle été traitée ?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: Text('Non'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                                child: Text('Oui'),
                              ),
                            ],
                          );
                        },
                      );
                      if (isProcessed) {
                        await _markComplaintAsProcessed(complaints[index]);
                      }
                     }
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