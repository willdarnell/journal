import 'package:flutter/material.dart';
import 'package:journal/widgets/drawer.dart';


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
                onSaved: (value) {

                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()){
                    _formKey.currentState.save();
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Save Entry'),
                )
            ],
          ),
        ),
      ),
    );
  }
}
