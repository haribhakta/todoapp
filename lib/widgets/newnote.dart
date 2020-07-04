import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewNote extends StatefulWidget {
  final Function addnewnote;
  NewNote(this.addnewnote);

  @override
  _NewNoteState createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  final notenamecontroller = TextEditingController();
  final notedescriptioncontroller = TextEditingController();
  DateTime _selecteddate;

  //submitting notes
  void submitnote() {
    final notename = notenamecontroller.text;
    final notedescription = notedescriptioncontroller.text;
    if (notename.isEmpty || notedescription.isEmpty || _selecteddate == null) {
      return;
    }
    notenamecontroller.clear();
    notedescriptioncontroller.clear();
    widget.addnewnote(notename, notedescription, _selecteddate);
    Navigator.pop(context);
  }

  //to pick date
  void _pickdate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((picdate) {
      setState(() {
        _selecteddate = picdate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(
                top: 10.0,
                left: 10.0,
                right: 10.0,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: "Note Name"),
                  controller: notenamecontroller,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Note Description"),
                  controller: notedescriptioncontroller,
                  // keyboardType: TextInputType.number, // allows only number
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selecteddate == null
                            ? "No date Choosen"
                            : "Trans Date :${DateFormat.yMEd().format(_selecteddate)}",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(children: <Widget>[
                      FlatButton(
                        child: Text(
                          "Choose date",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          _pickdate();
                        },
                      ),
                      Icon(Icons.calendar_today),
                    ]),
                  ],
                ),
                RaisedButton(
                  onPressed: submitnote,
                  color: Colors.blue,
                  child: Text("Add Transaction"),
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
