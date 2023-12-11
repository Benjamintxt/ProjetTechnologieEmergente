import 'package:flutter/material.dart';

class ClassificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaints Classification'),
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text('Issue 1'),
              subtitle: Text('Complaint 1 from main.dart'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Issue 2'),
              subtitle: Text('Complaint 2 from main.dart'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Issue 3'),
              subtitle: Text('Complaint 3 from main.dart'),
            ),
          ),
          // Add more cards for other complaints from main.dart
        ],
      ),
    );
  }
}
