import 'package:flutter/material.dart';
import 'package:journal/widgets/drawer.dart';
import 'package:journal/models/journal.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:journal/screens/home_page.dart';
import 'package:flutter/services.dart';


const CREATE_TABLE_PATH = 'lib/assets/schema_1.sql.txt';

class JournalEntryFields {
  String title;
  String body;
  DateTime dateTime;
  int rating;
  String toString() {
    return 'Title: $title, Body: $body, Time: $dateTime, Rating: $rating';
  }
  }

class JournalForm extends StatefulWidget {
  
  static final routeName = 'alpha';

  @override
  _JournalFormState createState() => _JournalFormState();
}

class _JournalFormState extends State<JournalForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final journalEntryFields = JournalEntryFields();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar( title: Text('New Journal Entry')),
          body: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Title', border: OutlineInputBorder()
                ),
                onSaved: (value) {
                  journalEntryFields.title = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(height:10),
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Body', border: OutlineInputBorder()
                ),
                onSaved: (value) {
                  journalEntryFields.body = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Rating', border: OutlineInputBorder()
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  journalEntryFields.rating = int.parse(value);
                },
                validator: (value) {
                  if (int.parse(value) < 1 || int.parse(value) > 4) {
                    return 'Please enter a number between 1 and 4';
                  }
                  return null;
                },
              ),
              RaisedButton(
                onPressed: () async {

                  if (_formKey.currentState.validate()){
                    var now = new DateTime.now();
                    journalEntryFields.dateTime = now;
                    _formKey.currentState.save();
                    //need to save to database here
                      String schema = await rootBundle.loadString(CREATE_TABLE_PATH);

                    final Database database = await createDatabase(schema);


                    await database.transaction( (txn) async {
                      insert(txn);
                    });
                    await database.close();
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Save Entry'),
                ),
                
            ],
          ),
        ),
      ),
    );
  }
  Future<Database> createDatabase(String query) async {
    final Database database = await openDatabase(
      'journal.db', version: 1, onCreate: (Database db, int version) async {
        await db.execute(query);
      }
    );
    return database;
  }
  Future insert(txn) async {
    await txn.rawInsert('INSERT INTO journal_entries(title, body, rating, date) VALUES(?, ?, ?, ?)',
                      [journalEntryFields.title, journalEntryFields.body, journalEntryFields.rating, journalEntryFields.dateTime.toString()]
                      );
  }
}
