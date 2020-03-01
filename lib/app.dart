import 'package:flutter/material.dart';
import 'package:journal/screens/home_page.dart';
import 'package:journal/screens/journal_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:journal/screens/journal_form.dart';
import 'package:journal/models/journal.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';




class App extends StatefulWidget {
  
  static final routes = {
    HomePage.routeName: (context) => HomePage(),
    JournalEntryView.routeName: (context) => JournalEntryView(),
    JournalForm.routeName: (context) => JournalForm()
  };

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  void initState() {
    super.initState();

  }

  
  Widget build(BuildContext context) {
    return new DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => new ThemeData(
        primarySwatch: Colors.indigo,
        brightness: brightness,
      ),
      themedWidgetBuilder: (context, theme) {
        return new MaterialApp(
          title: 'Flutter Demo',
          theme: theme,
          routes: App.routes,
        );
      }
    );
  }
}






  
