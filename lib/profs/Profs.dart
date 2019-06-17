import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:mine/profs/AddProf.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mine/profs/profs_class.dart';
import 'package:mine/profs/profs_view.dart';
class Profs extends StatefulWidget {
  @override
  _ProfsState createState() => _ProfsState();
}
class _ProfsState extends State<Profs> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String nodeName = "profs";
  List<Prof> profsList = <Prof>[];
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
        title: Text("Profs"),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Visibility(
              visible: profsList.isEmpty,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            Visibility(
              visible: profsList.isNotEmpty,
              child: Flexible(
                  child: FirebaseAnimatedList(
                      query: _database.reference().child('profs'),
                      itemBuilder: (_, DataSnapshot snap,
                          Animation<double> animation, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Card(
                            shape: RoundedRectangleBorder
                              (borderRadius: BorderRadius.all(Radius.circular(50))),                            child: ListTile(
                            title: ListTile(
                              onTap: (){ Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfView(
                                          profsList[index])));

                              },
                              title: Text(
                                profsList[index].name,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Text(""),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Text(
                                profsList[index].dob,
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
              context, MaterialPageRoute(builder: (context) => AddProf()));
        },
        child: Icon(
          Icons.add,
          color: Colors.grey[800],
        ),
        backgroundColor: Colors.teal[300],
        tooltip: "add a prof",
      ),
    );
  }
  _childAdded(Event event) {
    setState(() {
      profsList.add(Prof.fromSnapshot(event.snapshot));
    });
  }
  void _childRemoves(Event event) {
    var deletedProf = profsList.singleWhere((prof) {
      return prof.key == event.snapshot.key;
    });
    setState(() {
      profsList.removeAt(profsList.indexOf(deletedProf));
    });
  }
  void _childChanged(Event event) {
    var changedProf = profsList.singleWhere((prof) {
      return prof.key == event.snapshot.key;
    });
    setState(() {
      profsList[profsList.indexOf(changedProf)] =
          Prof.fromSnapshot(event.snapshot);
    },
    );
  }
}
