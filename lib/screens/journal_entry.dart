import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:journal/models/journal.dart';
import 'package:journal/widgets/drawer.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



class JournalDetails {
    List<JournalEntry> journalEntries;
    int index;
    JournalDetails(this.journalEntries, this.index);
  }
class JournalEntryView extends StatelessWidget {
  
  static final routeName = 'beta';
  
  @override
  Widget build(BuildContext context) {
    final JournalDetails journal = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      endDrawer: MyDrawer(),
      appBar: AppBar(
        title: Text(DateFormat.yMMMMEEEEd().format(journal.journalEntries[journal.index].date)),
      ),
      body: details(context, journal.journalEntries, journal.index));
  }
}

Container details(BuildContext context, List<JournalEntry> list, int index){
  return Container(
    child: ListTile(
      title: Text(list[index].title),
      subtitle: Row(children: <Widget> [Text(list[index].body, textAlign: TextAlign.left,), Spacer(), Text('Rating: ' + list[index].rating.toString(), textAlign: TextAlign.right,)]),

    )
  );
}

