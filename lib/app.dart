import 'package:flutter/material.dart';
import 'package:journal/screens/home_page.dart';
import 'package:journal/screens/journal_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:journal/screens/journal_form.dart';



class App extends StatefulWidget {
  
  static final routes = {
    HomePage.routeName: (context) => HomePage(),
    JournalEntry.routeName: (context) => JournalEntry(),
    JournalForm.routeName: (context) => JournalForm()
  };

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool _dark = false;

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



  
