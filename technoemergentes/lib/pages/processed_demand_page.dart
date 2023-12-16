import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProcessedDemandPage extends StatefulWidget {
  @override
  _ProcessedDemandPageState createState() => _ProcessedDemandPageState();
}

class _ProcessedDemandPageState extends State<ProcessedDemandPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> _loadProcessedDemands() async {
    QuerySnapshot processedDemands = await _firestore
        .collection('demandes') 
        .where('demandeTraitee', isEqualTo: true)
        .get();

    // Extrait les données des demandes traitées
    List<Map<String, dynamic>> processedDemandData = processedDemands.docs
        .map((demandSnapshot) => demandSnapshot.data() as Map<String, dynamic>)
        .toList();

    return processedDemandData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demandes traitées'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _loadProcessedDemands(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading processed demands.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No processed demands available.'));
          } else {
            List<Map<String, dynamic>> processedDemands = snapshot.data!;

            return ListView.builder(
              itemCount: processedDemands.length,
              itemBuilder: (context, index) {
                final processedDemand = processedDemands[index];
                final inputText = processedDemand['demande'];
                final importanceLevel = processedDemand['typeUrgence'];

                return Card(
                  child: ListTile(
                    title: Text('Demande traitée ${index + 1}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$inputText'),
                        Text('Niveau d\'importance: $importanceLevel'),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
