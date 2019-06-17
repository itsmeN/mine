import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:mine/AddStudent.dart';
import 'view.dart';
import 'class.dart';
import 'package:firebase_database/firebase_database.dart';
class Students extends StatefulWidget {
  @override
  _StudentsState createState() => _StudentsState();
}
class _StudentsState extends State<Students> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String nodeName = "students";
  List<Student> studentsList = <Student>[];
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
        title: Text("Students"),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Visibility(
              visible: studentsList.isEmpty,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            Visibility(
              visible: studentsList.isNotEmpty,
              child: Flexible(
                  child: FirebaseAnimatedList(
                      query: _database.reference().child('students'),
                      itemBuilder: (_, DataSnapshot snap,
                          Animation<double> animation, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),                            child: ListTile(
                              title: ListTile(
                                onTap: (){ Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StudentView(
                                            studentsList[index])));

                                },
                                title: Text(
                                  studentsList[index].name,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: Text(""),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(
                                  studentsList[index].dob,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            ),
                          ),

                        );
                      }
                      )
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddStudent()));
        },
        child: Icon(
          Icons.add,
          color: Colors.grey[800],
        ),
        backgroundColor: Colors.teal[300],
        tooltip: "add a student",
      ),
    );
  }
  _childAdded(Event event) {
    setState(() {
      studentsList.add(Student.fromSnapshot(event.snapshot));
    });
  }
  void _childRemoves(Event event) {
    var deletedStudent = studentsList.singleWhere((student) {
      return student.key == event.snapshot.key;
    });
    setState(() {
      studentsList.removeAt(studentsList.indexOf(deletedStudent));
    });
  }
  void _childChanged(Event event) {
    var changedStudent = studentsList.singleWhere((student) {
      return student.key == event.snapshot.key;
    });
    setState(() {
      studentsList[studentsList.indexOf(changedStudent)] =
          Student.fromSnapshot(event.snapshot);
    },
    );
  }
}
