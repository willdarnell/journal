import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journal/screens/journal_entry.dart';
import 'package:journal/screens/journal_form.dart';
import 'package:journal/widgets/drawer.dart';
import 'package:journal/models/journal.dart';
import 'dart:core';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';


const CREATE_TABLE_PATH = 'lib/assets/schema_1.sql.txt';

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
    String schema = await rootBundle.loadString(CREATE_TABLE_PATH);
    final Database database = await createDatabase(schema);
    List<Map> journalRecords = await journalRecordsFunction(database);
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
  @override
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
    loadJournal();
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: journal.journalEntries.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(journal.journalEntries[index].title),
          subtitle: Text(DateFormat.yMMMMEEEEd().format(journal.journalEntries[index].date)),
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
        onPressed: () async{ 
         await deleteDatabase('journal.db');

          displayAlpha(context); }
      );
  }

  void displayAlpha(BuildContext context) {
    Navigator.pushNamed(context, JournalForm.routeName);
  }

  void displayEntry(BuildContext context, Journal journal, index) {
    Navigator.pushNamed(context, JournalEntryView.routeName, arguments: JournalDetails(journal.journalEntries, index));
  } 

  Future<Database> createDatabase(String query) async {
    final Database database = await openDatabase(
      'journal.db', version: 1, onCreate: (Database db, int version) async {
        await db.execute(query);
      }
    );
    return database;
  }
  Future<List<Map>> journalRecordsFunction (database) async{
    List<Map> query = await database.rawQuery('SELECT * FROM journal_entries');
    return query;
  }
}
