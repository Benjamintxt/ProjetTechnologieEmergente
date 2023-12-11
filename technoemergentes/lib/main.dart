import 'package:flutter/material.dart';
import 'package:technoemergentes/pages/classification_page.dart';
import 'package:technoemergentes/pages/customer_section.dart';


void main() {
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
              title: Text('Classification review'),
              onTap: () {
                _selectNavigationItem(1);
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