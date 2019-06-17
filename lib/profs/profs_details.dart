import 'package:firebase_database/firebase_database.dart';


class ProfDetails{
  String nodeName = "Profs";
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference _databaseReference;
  Map prof;

  ProfDetails(this.prof);

  addProf(){
//    this is going to give a reference to the Profs node
    database.reference().child(nodeName).push().set(prof);
  }

  deleteProf(){
    database.reference().child('$nodeName/${prof['key']}').remove();
  }

  updateProf(){
    database.reference().child('$nodeName/${prof['key']}').update(
        {"name": prof['name'], "age": prof['age'], "email":prof['email']}
    );
  }
}