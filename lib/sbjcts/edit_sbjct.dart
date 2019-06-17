import 'package:flutter/material.dart';
import 'package:mine/Students.dart';
import 'package:mine/sbjcts/sbjcts.dart';
import 'package:mine/sbjcts/sbjcts_class.dart';
import 'sbjcts_details.dart';
class EditSubject extends StatefulWidget {
 final Subject subject;
 EditSubject(this.subject);
  @override
  _EditSubjectState createState() => _EditSubjectState();
}

class _EditSubjectState extends State<EditSubject> {
  final GlobalKey<FormState> formkey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("edit Subject"),
        elevation: 0.0,
      ),
      body: Form(
          key: formkey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: widget.subject.name,
                  decoration: InputDecoration(
                      labelText: "Subject name",
                      border: OutlineInputBorder()
                  ),
                  onSaved: (val) => widget.subject.name = val,
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
                  initialValue: widget.subject.profs,
                  decoration: InputDecoration(
                      labelText: "Subject profs",
                      border: OutlineInputBorder()
                  ),
                  onSaved: (val) => widget.subject.profs = val,
                  validator: (val){
                    if(val.isEmpty){
                      return "profs field cant be empty";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: widget.subject.year,
                  decoration: InputDecoration(
                      labelText: "Subject year",
                      border: OutlineInputBorder()),
                  onSaved: (val) => widget.subject.year = val,
                  validator: (val){
                    if(val.isEmpty){
                      return "year field cant be empty";
                    }
                    },
                ),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(onPressed: (){
        enter();
//        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Subjects()));
      },
        child: Icon(Icons.edit, color: Colors.white,),
        backgroundColor: Colors.red,
        tooltip: "exit a Subject",),
    );
  }

  void enter() {
    final FormState form = formkey.currentState;
    if(form.validate()){
      form.save();
      form.reset();
      SubDetails subDetails = SubDetails(widget.subject.toMap());
      subDetails.updateSubject();
    }
  }


}