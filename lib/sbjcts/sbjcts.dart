import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mine/sbjcts/AddSbjct.dart';
import 'package:mine/sbjcts/sbjcts_class.dart';
import 'package:mine/sbjcts/sbjcts_view.dart';

class Subjects extends StatefulWidget {

  @override
  _SubjectsState createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String nodeName = "Subjects";
  List<Subject> subjectsList = <Subject>[];
  @override
  // ignore: must_call_super
  void initState() {
    _database.reference().child(nodeName).onChildAdded.listen(_childAdded);
    _database.reference().child(nodeName).onChildRemoved.listen(_childRemoves);
    _database.reference().child(nodeName).onChildChanged.listen(_childChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Subjects"),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,

      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Visibility(
              visible: subjectsList.isEmpty,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            Visibility(
              visible: subjectsList.isNotEmpty,
              child: Flexible(
                  child: FirebaseAnimatedList(
                      query: _database.reference().child('Subjects'),
                      itemBuilder: (_, DataSnapshot snap,
                          Animation<double> animation, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Card(
                            child: ListTile(
                              title: ListTile(
                                onTap: (){ Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SubjectView(
                                            subjectsList[index])));

                                },
                                title: Text(
                                  subjectsList[index].name,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: Text(""),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  subjectsList[index].year,
                                  style: TextStyle(fontSize: 14.0),
                                ),
                              ),
                            ),
                          ),
                        );
                      })),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddSubject()));
        },
        child: Icon(
          Icons.add,
          color: Colors.grey[800],
        ),
        backgroundColor: Colors.teal[300],
        tooltip: "add a Subject",
      ),
    );
  }

  _childAdded(Event event) {
    setState(() {
      subjectsList.add(Subject.fromSnapshot(event.snapshot));
    });
  }

  void _childRemoves(Event event) {
    var deletedSubject = subjectsList.singleWhere((subject) {
      return subject.key == event.snapshot.key;
    });

    setState(() {
      subjectsList.removeAt(subjectsList.indexOf(deletedSubject));
    });
  }

  void _childChanged(Event event) {
    var changedSubject = subjectsList.singleWhere((subject) {
      return subject.key == event.snapshot.key;
    });

    setState(() {
      subjectsList[subjectsList.indexOf(changedSubject)] =
          Subject.fromSnapshot(event.snapshot);
    });
  }
}
