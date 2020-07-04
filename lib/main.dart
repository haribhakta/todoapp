import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './model/notes.dart';
import './widgets/noteslist.dart';
import './widgets/newnote.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          backgroundColor: Colors.black,
          accentColor: Colors.blue,
          primaryColor: Colors.red,
          dividerColor: Colors.yellow,
          cardColor: Colors.orange[50],
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Georgia',
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline2: TextStyle(fontSize: 50.0, fontStyle: FontStyle.italic),
            headline3: TextStyle(fontSize: 36.0, fontFamily: 'Hind'),
          )),
      home: ToDoApp(),
    );
  }
}

class ToDoApp extends StatefulWidget {
  @override
  _ToDoAppState createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  //creating variable for model
  List<ModelNotes> _notes = [];

  //delete transaction
  void _deletenotes(String id) {
    setState(() {
      _notes.removeWhere((nt) => nt.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaConst = MediaQuery.of(context);

    // appbar variable
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text("ToDo App "),
            trailing: Icon(Icons.add),
          )
        : AppBar(
            title: Text("ToDo App "),
          );

    final notesListWidget = Container(
        height: mediaConst.size.height * 0.7 -
            appBar.preferredSize.height -
            mediaConst.padding.top,
        child: NotesList(_notes, _deletenotes));

    void _showaddnotes(BuildContext bctx) {
      showBottomSheet(context: bctx, builder: (ctx) => NewNote(_addnewnote));
    }

    void _addnewnote(
        String notename, String notedescription, DateTime notedate) {
      setState(() {
        _notes.add(ModelNotes(
            notename: notename,
            notedescription: notedescription,
            notedate: notedate,
            id: DateTime.now().toString()));
      });
    }

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: notesListWidget,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: notesListWidget,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _showaddnotes(context);
              },
              child: Icon(Icons.add),
            ),
          );
  }
}
