import 'package:flutter/material.dart';
import 'package:journal/screens/journal_entry.dart';
import 'package:journal/widgets/drawer.dart';

class HomePage extends StatelessWidget {
  
 
  static final routeName = '/';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MyDrawer(),
      appBar: AppBar(title: Text('Welcome'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [label(context), button(context)]
        )
      )
    );
  }
  

 
  Widget label(BuildContext context) {
    return Text('Navigation HomePage',
    );
  }
  
  Widget button(BuildContext context) {
    return RaisedButton(
        child: Text('Click Me!'),
        onPressed: () { displayAlpha(context); }
      );
  }
  
  void displayAlpha(BuildContext context) {
    Navigator.pushNamed(context, JournalEntry.routeName);
  }
  
}

