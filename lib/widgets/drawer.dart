import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  getSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _dark = prefs.getBool('dark');
    return _dark;
  }
  _setTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bool _dark = (prefs.getBool('dark') ? true: false);
      prefs.setBool('dark', _dark);
    });
  }
  @override 
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
        value: getSharedPref(),
        onChanged: (value) { setState(() { _setTheme(); } );},

      )]));
      }
}

