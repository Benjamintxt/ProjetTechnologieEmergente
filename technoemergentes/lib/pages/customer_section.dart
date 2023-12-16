import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:technoemergentes/pages/classification_page.dart';
import 'package:technoemergentes/services/firestoreService.dart';

class CustomerSupportPage extends StatefulWidget {
  @override
  _CustomerSupportPageState createState() => _CustomerSupportPageState();
}

class _CustomerSupportPageState extends State<CustomerSupportPage> {
  final TextEditingController _textInputController = TextEditingController();
  List<Map<String, dynamic>> _results = [];
  late String importanceLevel = '';
  //fonction qui permet de classifier le type de demande
  Future<void> classifyText(String text) async {
    const apiKey = 'nWrwm3g8q4ZIWzDzCQZTbup9RCt87oFsu7yLt7XB'; 
    const apiUrl = 'https://api.cohere.ai/v1/classify';
    const model = 'embed-multilingual-light-v3.0';

    final examples = [
      {"text": "Dégradation des espaces publics dans le quartier", "label": "signalement urbain"},
      {"text": "Nids-de-poule dangereux sur la route principale", "label": "signalement sur la chaussée"},
      {"text": "Installation de bancs publics nécessaires dans le parc", "label": "proposition d'idée"},
      {"text": "Tags sur les murs du centre-ville", "label": "signalement urbain"},
      {"text": "Feux de signalisation défectueux à l'intersection", "label": "signalement sur la chaussée"},
      {"text": "Création d'une piste cyclable pour améliorer la sécurité", "label": "proposition d'idée"},
      {"text": "Dépôt illégal d'ordures près de la station de bus", "label": "signalement urbain"},
      {"text": "Trous dans le trottoir près de l'école", "label": "signalement sur la chaussée"},
      {"text": "Ajout de panneaux de signalisation pour la sécurité des piétons", "label": "proposition d'idée"},
      {"text": "Éclairage public insuffisant dans le quartier résidentiel", "label": "signalement urbain"},
      {"text": "Route glissante en raison de l'accumulation d'eau", "label": "signalement sur la chaussée"},
      {"text": "Création d'un jardin communautaire dans le parc", "label": "proposition d'idée"},
      {"text": "Défauts dans l'aménagement paysager du centre-ville", "label": "signalement urbain"},
      {"text": "Trous dans le revêtement de la chaussée près du marché", "label": "signalement sur la chaussée"},
      {"text": "Installation de stations de recharge pour véhicules électriques", "label": "proposition d'idée"},
      {"text": "Mauvaise gestion des déchets dans les espaces publics", "label": "signalement urbain"},
      {"text": "Marquages routiers effacés près de l'école primaire", "label": "signalement sur la chaussée"},
      {"text": "Création d'une aire de jeux pour enfants dans le parc", "label": "proposition d'idée"},
      {"text": "Éclairage défectueux dans le quartier commercial", "label": "signalement urbain"},
      {"text": "Route bloquée en raison de travaux de réparation", "label": "signalement sur la chaussée"},
      {"text": "Suggestions pour la rénovation du marché local", "label": "proposition d'idée"},
      {"text": "Décharge sauvage près de la rivière", "label": "signalement urbain"},
      {"text": "Manque de passages piétons sécurisés près des écoles", "label": "signalement sur la chaussée"},
      {"text": "Création d'un espace de loisirs pour les jeunes", "label": "proposition d'idée"},
      {"text": "Vandalisme sur les bancs publics du parc", "label": "signalement urbain"},
      {"text": "Signalisation inadéquate à l'entrée du quartier", "label": "signalement sur la chaussée"},
      {"text": "Aménagement d'un parc canin dans le quartier", "label": "proposition d'idée"},
      {"text": "Graffiti sur les arrêts de bus", "label": "signalement urbain"},
      {"text": "Réparation nécessaire des trottoirs dans le centre-ville", "label": "signalement sur la chaussée"},
      {"text": "Création d'un festival artistique annuel", "label": "proposition d'idée"},
    ];


    final requestBody = {
      "model": model,
      "inputs": [text],
      "examples": examples,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $apiKey',
      },
      body: (utf8.encode(jsonEncode(requestBody))),

    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data);
      final results = data['results'];
      setState(() {
      _results = List<Map<String, dynamic>>.from(data['classifications']);
    });
    } else {
      // Handle error
      print('Failed to classify text. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }
  //fonction qui permet de classifier le niveau d'importance de la demande
  Future<void> classifyImportance(String text) async {
    const apiKey = 'vHQrEVsnogMZoJpKjtVd0lIWoj3ctOqzvG2YownQ'; 
    const apiUrl = 'https://api.cohere.ai/v1/classify';
    const model = 'embed-multilingual-light-v3.0';

     final examples = [
      {"text": "Dégradation des espaces publics dans le quartier", "label": "Urgent"},
      {"text": "Nids-de-poule dangereux sur la route principale", "label": "Très urgent"},
      {"text": "Installation de bancs publics nécessaires dans le parc", "label": "Urgent"},
      {"text": "Tags sur les murs du centre-ville", "label": "Peu urgent"},
      {"text": "Feux de signalisation défectueux à l'intersection", "label": "Très urgent"},
      {"text": "Création d'une piste cyclable pour améliorer la sécurité", "label": "Urgent"},
      {"text": "Dépôt illégal d'ordures près de la station de bus", "label": "Peu urgent"},
      {"text": "Trous dans le trottoir près de l'école", "label": "Urgent"},
      {"text": "Ajout de panneaux de signalisation pour la sécurité des piétons", "label": "Urgent"},
      {"text": "Éclairage public insuffisant dans le quartier résidentiel", "label": "Peu urgent"},
      {"text": "Route glissante en raison de l'accumulation d'eau", "label": "Très urgent"},
      {"text": "Création d'un jardin communautaire dans le parc", "label": "Peu urgent"},
      {"text": "Défauts dans l'aménagement paysager du centre-ville", "label": "Peu urgent"},
      {"text": "Trous dans le revêtement de la chaussée près du marché", "label": "Urgent"},
      {"text": "Installation de stations de recharge pour véhicules électriques", "label": "Peu urgent"},
      {"text": "Mauvaise gestion des déchets dans les espaces publics", "label": "Peu urgent"},
      {"text": "Marquages routiers effacés près de l'école primaire", "label": "Très urgent"},
      {"text": "Création d'une aire de jeux pour enfants dans le parc", "label": "Peu urgent"},
      {"text": "Éclairage défectueux dans le quartier commercial", "label": "Urgent"},
      {"text": "Route bloquée en raison de travaux de réparation", "label": "Très urgent"},
      {"text": "Suggestions pour la rénovation du marché local", "label": "Peu urgent"},
      {"text": "Décharge sauvage près de la rivière", "label": "Peu urgent"},
      {"text": "Manque de passages piétons sécurisés près des écoles", "label": "Urgent"},
      {"text": "Création d'un espace de loisirs pour les jeunes", "label": "Peu urgent"},
      {"text": "Vandalisme sur les bancs publics du parc", "label": "Peu urgent"},
      {"text": "Signalisation inadéquate à l'entrée du quartier", "label": "Urgent"},
      {"text": "Aménagement d'un parc canin dans le quartier", "label": "Peu urgent"},
      {"text": "Graffiti sur les arrêts de bus", "label": "Peu urgent"},
      {"text": "Réparation nécessaire des trottoirs dans le centre-ville", "label": "Urgent"},
      {"text": "Création d'un festival artistique annuel", "label": "Peu urgent"},
    ];

    final requestBody = {
        "model": model,
        "inputs": [text],
        "examples": examples,
      };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode(requestBody),
    );

      if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

      if (data.containsKey('classifications') && data['classifications'].isNotEmpty) {
        final prediction = data['classifications'][0]['prediction'];

        setState(() {
          importanceLevel = prediction;
        });

        print(importanceLevel);
      } else {
        print('Error: Prediction not found or is null in the response.');
        print('Full response body: ${response.body}');
      }
    } else {
      // Handle error
      print('Failed to classify importance. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Support citoyen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textInputController,
              decoration: InputDecoration(labelText: 'Entrez votre requête...'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final inputText = _textInputController.text.trim();
                if (inputText.isNotEmpty) {
                  await classifyText(inputText);
                  await classifyImportance(inputText);
                }
                 FirestoreService().addDocument(inputText, _results[0]['prediction'], importanceLevel);
              },
              child: Text('Enregistrez votre requête'),
            ),
            SizedBox(height: 16.0),
            Text('Classification Results:'),
            Expanded(
              child: ListView.builder(
                itemCount: _results.length,
                itemBuilder: (context, index) {
                  final result = _results[index];
                  final inputText = result['input'];
                  return ListTile(
                    title: Text(inputText),
                    subtitle: Text('Prediction: ${result['prediction']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


void main() {
  runApp(MaterialApp(
    home: CustomerSupportPage(),
  ));
}

