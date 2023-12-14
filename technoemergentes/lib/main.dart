import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:technoemergentes/firebase_options.dart';
import 'package:technoemergentes/pages/classification_page.dart';
import 'package:technoemergentes/pages/customer_section.dart';
import 'package:technoemergentes/pages/processed_demand_page.dart';



Future<void> main() async {
  //Initialisation de Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); 

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CityMobis',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    CustomerSupportPage(),
    ClassificationPage(),
    ProcessedDemandPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CityMobis'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('CityMobis'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Section utilisateur'),
              onTap: () {
                _selectNavigationItem(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.rate_review),
              title: Text('Classification des demandes'),
              onTap: () {
                _selectNavigationItem(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.done),
              title: Text('Demandes traitées'),
              onTap: () {
                _selectNavigationItem(2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }

  void _selectNavigationItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}