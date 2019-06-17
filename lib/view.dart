import 'package:flutter/material.dart';
import 'package:mine/class.dart';
import 'package:mine/edit.dart';
import 'details.dart';

class StudentView extends StatefulWidget {
  final Student student;

  StudentView(this.student);

  @override
  _StudentViewState createState() => _StudentViewState();
}

class _StudentViewState extends State<StudentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.student.name),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(widget.student.name),

                ),),
              IconButton(icon: Icon(Icons.delete),
                onPressed: (){
                  Details details = Details(widget.student.toMap());
                  details.deleteStudent();
                  Navigator.pop(context);

                },),
              IconButton(icon: Icon(Icons.edit),
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
                  => EditStudent(widget.student)));
                },),
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.student.dob),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.student.email,style: TextStyle(color: Color.fromRGBO(255, 255, 100, 80)),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.student.gender,style: TextStyle(color: Color.fromRGBO(255, 255, 100, 80)),),
          ),
        ],
      ),
    );
  }
}