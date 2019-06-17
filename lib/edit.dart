import 'package:flutter/material.dart';
import 'package:mine/class.dart';
import 'package:mine/Students.dart';
import 'class.dart';
import 'details.dart';
class EditStudent extends StatefulWidget {
 final Student student;
 EditStudent(this.student);
  @override
  _EditStudentState createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  final GlobalKey<FormState> formkey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("edit student"),
        elevation: 0.0,
      ),
      body: Form(
          key: formkey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: widget.student.name,
                  decoration: InputDecoration(
                      labelText: "Student name",
                      border: OutlineInputBorder()
                  ),
                  onSaved: (val) => widget.student.name = val,
                  validator: (val){
                    if(val.isEmpty ){
                      return "name field cant be empty";
                    }else if(val.length > 16){
                      return "name cannot have more than 50 characters ";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: widget.student.dob,
                  decoration: InputDecoration(
                      labelText: "Student age",
                      border: OutlineInputBorder()
                  ),
                  onSaved: (val) => widget.student.dob = val,
                  validator: (val){
                    if(val.isEmpty){
                      return "age field cant be empty";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: widget.student.email,
                  decoration: InputDecoration(
                      labelText: "Student email",
                      border: OutlineInputBorder()
                  ),
                  onSaved: (val) => widget.student.dob = val,
                  validator: (val){
                    if(val.isEmpty){
                      return "email field cant be empty";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: widget.student.dob,
                  decoration: InputDecoration(
                      labelText: "Student age",
                      border: OutlineInputBorder()),
                  onSaved: (val) => widget.student.dob = val,
                  validator: (val){
                    if(val.isEmpty){
                      return "age field cant be empty";
                    }
                    },
                ),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(onPressed: (){
        enter();
//        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Students()));
      },
        child: Icon(Icons.edit, color: Colors.white,),
        backgroundColor: Colors.red,
        tooltip: "exit a student",),
    );
  }

  void enter() {
    final FormState form = formkey.currentState;
    if(form.validate()){
      form.save();
      form.reset();
      Details details = Details(widget.student.toMap());
      details.updateStudent();
    }
  }


}