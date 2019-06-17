import 'package:firebase_database/firebase_database.dart';
class Subject {
  static const NAME= "name";
  static const PROFS = "profs";
  static const KEY= "key";
  static const YEAR= "year";

  String name;
  String profs;
  String key;
  String year;

  Subject(this.key,this.name, this.profs, this.year);

  Subject.fromSnapshot (DataSnapshot snap):
        this.name=snap.value[NAME],
        this.profs=snap.value[PROFS],
        this.year=snap.value[YEAR];

  toMap(){
    return
      {NAME:name, PROFS: profs,YEAR: year,KEY: key };
  }

}