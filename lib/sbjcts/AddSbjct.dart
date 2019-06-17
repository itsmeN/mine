import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:mine/sbjcts/sbjcts_class.dart';
import 'sbjcts_details.dart';
import 'package:flutter/material.dart';

class AddSubject extends StatefulWidget {

  @override
  _AddSubjectState createState() => _AddSubjectState();
}

class _AddSubjectState extends State<AddSubject> {

  final GlobalKey<FormState> formkey = new GlobalKey();
  Subject subject = Subject("", " ", " ","");
  // ignore: unused_field
  FirebaseDatabase _database = FirebaseDatabase.instance;
  final _years = ['FreshmanYear','Sophomore Year','Junior Year','Senior Year'];
  String _year = 'FreshmanYear';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add Subject"),
        elevation: 0.0,
      ),
      body: Form(
          key: formkey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Subject name",
                      border: OutlineInputBorder()
                  ),
                  onSaved: (val) => subject.name = val,
                  validator: (val){
                    if(val.isEmpty ){
                      return "name field cant be empty";
                    }else if(val.length > 16){
                      return "name cannot have more than 16 characters ";
                    }
                  },
                ),
              ),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Profs",
                      border: OutlineInputBorder()
                  ),
                  onSaved: (val) => subject.profs = val,
                  validator: (val){
                    if(val.isEmpty ){
                      return " field cant be empty";
                    }else if(val.length > 16){
                      return " cannot have more than 16 characters ";
                    }
                  },
                ),
              ),
              FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      icon: const Icon(Icons.person_outline),
                      labelText: 'year',
                    ),
                    isEmpty: _year == '',
                    child:  DropdownButtonHideUnderline(
                      child:  DropdownButton<String>(
                        value: _year,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {
                            subject.year = newValue;
                            _year = newValue;
                            state.didChange(newValue);
                          });
                        },
                        items: _years.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(onPressed: (){
        enter();
        Navigator.pop(context);
//        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      },
        child: Icon(Icons.add, color: Colors.black26),
        backgroundColor: Colors.green[200],
        tooltip: "add a Subject",),
    );
  }
  void enter() {
    final FormState form = formkey.currentState;
    if(form.validate()){
      form.save();
      form.reset();
      SubDetails subDetails = SubDetails (subject.toMap());
      subDetails.addSubject();
    }
  }

}
