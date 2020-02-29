import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dynamic_theme/dynamic_theme.dart';




class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool _dark = false;
  
  @override 
  bool _getValue(){
    if (DynamicTheme.of(context).brightness == Brightness.dark) {
        _dark = true;
    }
    else {
      _dark = false;
    }
    return _dark;
  }
  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(Theme.of(context).brightness == Brightness.dark? Brightness.light: Brightness.dark);
    if (DynamicTheme.of(context).brightness == Brightness.dark) {
        _dark = true;
    }
    else {
      _dark = false;
    }
  }
  
  Widget build(BuildContext context) {
    return Drawer(
  // Add a ListView to the drawer. This ensures the user can scroll
  // through the options in the drawer if there isn't enough vertical
  // space to fit everything.
    child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: <Widget>[
      DrawerHeader(
        child: Text('Settings'),
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
      ),
      SwitchListTile(
        title: Text('Dark Mode'),
        value: _getValue(),
        onChanged: (value) { setState(() { changeBrightness();  } );},

      )]));
      }
}

