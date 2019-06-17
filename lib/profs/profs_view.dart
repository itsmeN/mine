import 'package:flutter/material.dart';
import 'package:mine/profs/profs_class.dart';
import 'package:mine/profs/edit_prof.dart';
import 'package:mine/profs/profs_details.dart';

class ProfView extends StatefulWidget {
  final Prof prof;
  ProfView(this.prof);
  @override
  _ProfViewState createState() => _ProfViewState();
}

class _ProfViewState extends State<ProfView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.prof.name),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(widget.prof.name),

                ),),
              IconButton(icon: Icon(Icons.delete),
                onPressed: (){
                  ProfDetails profDetails = ProfDetails(widget.prof.toMap());
                  profDetails.deleteProf();
                  Navigator.pop(context);

                },),
              IconButton(icon: Icon(Icons.edit),
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditProf(widget.prof)));
                },),
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.prof.dob),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.prof.email,style: TextStyle(color: Color.fromRGBO(50, 50, 100, 80)),),
          ),
        ],
      ),
    );
  }
}