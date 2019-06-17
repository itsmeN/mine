import 'package:firebase_database/firebase_database.dart';


class Student {
  static const KEY = "key";
  static const DOB = "dob";
  static const NAME = "name";
  static const EMAIL = "email";
  static const GENDER = "gender";

  String key;
  String dob;
  String name;
  String email;
  String gender;
  Student(this.name, this.email, this.dob,this.gender);

  Student.fromSnapshot (DataSnapshot snap):
        this.dob=snap.value[DOB],
        this.name=snap.value[NAME],
        this.email=snap.value[EMAIL],
        this.gender=snap.value[GENDER];


  toMap(){
    return {NAME:name, EMAIL: email,DOB: dob ,GENDER:gender };
  }
}