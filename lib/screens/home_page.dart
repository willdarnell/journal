import 'package:flutter/material.dart';
import 'package:journal/screens/journal_entry.dart';
import 'package:journal/screens/journal_form.dart';

import 'package:journal/widgets/drawer.dart';
import 'package:journal/models/journal.dart';
import 'dart:core';

class HomePage extends StatelessWidget {
  
 
  static final routeName = '/';
  Journal journal = Journal([JournalEntry(1, "Farting in your mouth", "doublefarts", 1, DateTime(2020, 2, 2)), JournalEntry(1, "Farting in your ass", "doublefarts", 1, DateTime(2020, 2, 2))]);
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
      body: listView(context),
      floatingActionButton: button(context),
    );
  }
  
  
  ListView listView(BuildContext context){
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: journal.journalEntries.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(journal.journalEntries[index].title),
          subtitle: Text((journal.journalEntries[index].date).toString()),
          onTap: () {
            displayEntry(context, journal, index);

          },
        );
      },
    );
  }
  
  FloatingActionButton button(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () { displayAlpha(context); }
      );
  }
  
  void displayAlpha(BuildContext context) {
    Navigator.pushNamed(context, JournalForm.routeName);
  }

  void displayEntry(BuildContext context, Journal journal, index) {
    Navigator.pushNamed(context, JournalEntryView.routeName, arguments: JournalDetails(journal.journalEntries, index));
  }
  
  
}
