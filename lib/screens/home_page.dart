import 'package:flutter/material.dart';
import 'package:journal/screens/journal_entry.dart';
import 'package:journal/screens/journal_form.dart';
import 'package:journal/widgets/drawer.dart';
import 'package:journal/models/journal.dart';
import 'dart:core';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class HomePage extends StatefulWidget {
  
 
  static final routeName = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Journal journal;

  

  @override
  void initState() {
    super.initState();
    loadJournal();
  }

  void loadJournal() async {
    final Database database = await openDatabase(
      'journal.db', version: 1, onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE IF NOT EXISTS journal_entries(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, body TEXT NOT NULL, rating INTEGER NOT NULL, date TEXT NOT NULL)');
      }
    );
    List<Map> journalRecords = await database.rawQuery('SELECT * FROM journal_entries');
    final journalEntries = journalRecords.map( (record) {
      return JournalEntry(
        record['id'],
        record['title'],
        record['body'],
        record['rating'],
        DateTime.parse(record['date'])
      );
    }).toList();
    setState(() {
      journal = Journal(journalEntries);
    });
  }
  Text _getTitle(object) {
    if (object.journalEntries.isEmpty){
      return Text('Welcome');
    }
    else {
      return Text("Journal Entries");
    }
  }

  Widget build(BuildContext context) {
    if (journal == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()));
    }
    else{
    return Scaffold(
      endDrawer: MyDrawer(),
      appBar: AppBar(title: _getTitle(journal),),
      body: listView(context),
      floatingActionButton: button(context),
    );}
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
