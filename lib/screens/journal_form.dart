import 'package:flutter/material.dart';
import 'package:journal/widgets/drawer.dart';


class JournalForm extends StatelessWidget {
  
  static final routeName = 'alpha';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MyDrawer(),
      appBar: AppBar(),
      body: Center(
        child: Text('Notice the Back Button in the App Bar\n'
                    'We get this for free!\n'
                    'Managed by the Navigator.\n',
        ),
      ));
  }
}