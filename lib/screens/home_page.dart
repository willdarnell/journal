import 'package:flutter/material.dart';
import 'package:journal/screens/journal_entry.dart';
import 'package:journal/widgets/drawer.dart';
import 'package:journal/models/journal.dart';
import 'dart:core';

class HomePage extends StatelessWidget {
  
 
  static final routeName = '/';
  Journal journal = Journal([JournalEntry(1, "farts", "doublefarts", 1, DateTime(2020, 2, 2))]);
  Text _getTitle(object) {
    if (object.journalEntries.isEmpty){
      return Text('Welcome');
    }
    else {
      return Text("Journal Entries");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MyDrawer(),
      appBar: AppBar(title: _getTitle(journal),),
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
    Navigator.pushNamed(context, JournalEntryView.routeName);
  }
  
}

