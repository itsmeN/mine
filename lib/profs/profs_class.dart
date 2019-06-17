import 'package:firebase_database/firebase_database.dart';
class Prof {
  static const NAME= "name";
  static const EMAIL = "email";
  static const KEY= "key";
  static const DOB = "dob";

  String name;
  String email;
  String key;
  String dob;

  Prof(this.key,this.name, this.email, this.dob);

  Prof.fromSnapshot (DataSnapshot snap):
        this.dob=snap.value[DOB],
        this.name=snap.value[NAME],
        this.email=snap.value[EMAIL];

  toMap(){
    return
      {NAME:name, EMAIL: email,DOB: dob,KEY: key };
  }

}