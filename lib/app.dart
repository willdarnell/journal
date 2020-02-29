import 'package:flutter/material.dart';
import 'package:journal/screens/home_page.dart';
import 'package:journal/screens/journal_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatefulWidget {
  
  static final routes = {
    HomePage.routeName: (context) => HomePage(),
    JournalEntry.routeName: (context) => JournalEntry()
  };

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool _dark = false;

  @override
  void initState() {
    super.initState();
    _getTheme();
  }

  _getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _dark = (prefs.getBool('dark') ?? true);
    });
  }
  _setTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _dark = (prefs.getBool('dark') ? true: false);
      prefs.setBool('dark', _dark);
    });
  }
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: App.routes, 
      );
  }
}



  
