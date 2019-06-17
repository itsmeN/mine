import 'package:flutter/material.dart';
import 'package:mine/sbjcts/edit_sbjct.dart';
import 'package:mine/sbjcts/sbjcts_class.dart';
import 'package:mine/sbjcts/sbjcts_details.dart';

class SubjectView extends StatefulWidget {
  final Subject subject;
  SubjectView(this.subject);
  @override
  _SubjectViewState createState() => _SubjectViewState();
}

class _SubjectViewState extends State<SubjectView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subject.name),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(widget.subject.name),

                ),),
              IconButton(icon: Icon(Icons.delete),
                onPressed: (){
                  SubDetails subDetails = SubDetails(widget.subject.toMap());
                  subDetails.deleteSubject();
                  Navigator.pop(context);

                },),
              IconButton(icon: Icon(Icons.edit),
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditSubject(widget.subject)));
                },),
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.subject.year),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.subject.profs,style: TextStyle(color: Color.fromRGBO(50, 50, 100, 80)),),
          ),
        ],
      ),
    );
  }
}