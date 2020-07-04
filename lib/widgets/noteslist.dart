import 'package:flutter/material.dart';
import '../model/notes.dart';
import 'package:intl/intl.dart';

class NotesList extends StatelessWidget {
  final List<ModelNotes> _notes;
  final Function deletenotes;
  NotesList(this._notes, this.deletenotes);

  @override
  Widget build(BuildContext context) {
    return _notes.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) => Column(
              children: <Widget>[
                Text("No notes has been added yet."),
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  "assets/blanknote.png",
                  height: constraints.maxHeight * 0.6,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: _notes.length,
            itemBuilder: (ctx, index) => Card(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: FittedBox(
                      child: Text(
                        DateFormat.yMMMEd().format(_notes[index].notedate),
                      ),
                    ),
                  ),
                ),
                title: Text(_notes[index].notename),
                subtitle: Text(_notes[index].notedescription),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.red,
                  onPressed: () {
                    deletenotes(_notes[index].id);
                  },
                ),
              ),
            ),
          );
  }
}
