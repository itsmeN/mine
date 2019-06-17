import 'package:firebase_database/firebase_database.dart';


class SubDetails{
  String nodeName = "Subjects";
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference _databaseReference;
  Map subject;

  SubDetails(this.subject);

  addSubject(){
//    this is going to give a reference to the Subjects node
    database.reference().child(nodeName).push().set(subject);
  }

  deleteSubject(){
    database.reference().child('$nodeName/${subject['key']}').remove();
  }

  updateSubject(){
    database.reference().child('$nodeName/${subject['key']}').update(
        {"name": subject['name'], "age": subject['age'], "email":subject['email']}
    );
  }
}