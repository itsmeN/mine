import 'package:mine/profs/profs_class.dart';
import 'profs_details.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
class AddProf extends StatefulWidget {
  @override
  _AddProfState createState() => _AddProfState();
}

class _AddProfState extends State<AddProf> {
  final GlobalKey<FormState> formkey = new GlobalKey();
  Prof prof = Prof("", " ", " ","");
  final TextEditingController _controller = new TextEditingController();
  Future _chooseDate(BuildContext context, String initialDateString) async {
    var now = new DateTime.now();
    var initialDate = convertToDate(initialDateString) ?? now;
    initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now) ? initialDate : now);

    var result = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: new DateTime(1920),
        lastDate: new DateTime.now());

    if (result == null) return;

    setState(() {
      _controller.text = new DateFormat.yMd().format(result);
    });
  }

  DateTime convertToDate(String input) {
    try
    {
      var d = new DateFormat.yMd().parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add Prof"),
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
                      labelText: "Prof name",
                      border: OutlineInputBorder()
                  ),
                  onSaved: (val) => prof.name = val,
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
                      labelText: "Prof email",
                      border: OutlineInputBorder()
                  ),
                  onSaved: (val) => prof.email = val,
                  validator: (val){
                    if(val.isEmpty ){
                      return "emai field cant be empty";
                    }else if(val.length > 16){
                      return "email cannot have more than 50 characters ";
                    }
                  },
                ),
              ),
              Row(children: <Widget>[
                Expanded(
                    child: new TextFormField(
                      decoration: new InputDecoration(
                        icon: const Icon(Icons.calendar_today),
                        hintText: 'Enter your date of birth',
                        labelText: 'Dob',
                      ),
                      controller: _controller,
                      keyboardType: TextInputType.datetime,
                      onSaved: (val) => prof.dob = val,
                    )),
                new IconButton(
                  icon:
                  Icon(Icons.more_horiz),
                  tooltip: 'Choose date',
                  onPressed: (() {
                    _chooseDate(context, _controller.text);
                  }),
                )
              ]),
            ],
          )),
      floatingActionButton: FloatingActionButton(onPressed: (){
        enter();
        Navigator.pop(context);
//        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      },
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.red,
        tooltip: "add a Prof",),
    );
  }
  void enter() {
    final FormState form = formkey.currentState;
    if(form.validate()){
      form.save();
      form.reset();
      ProfDetails profDetails = ProfDetails(prof.toMap());
      profDetails.addProf();
    }
  }
}
