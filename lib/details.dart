import 'package:firebase_database/firebase_database.dart';


class Details{
  String nodeName = "students";
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference _databaseReference;
  Map student;

  Details(this.student);

  addStudent(){
//    this is going to give a reference to the students node
    database.reference().child(nodeName).push().set(student);
  }

  deleteStudent(){
    database.reference().child('$nodeName/${student['key']}').remove();
  }

  updateStudent(){
    database.reference().child('$nodeName/${student['key']}').update(
        {"name": student['name'], "age": student['age'] , "gender": student['gender'], "email":student['email']}
    );
  }
}
