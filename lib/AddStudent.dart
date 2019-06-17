import 'package:mine/class.dart';
import 'details.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class AddStudent extends StatefulWidget {
  @override
  _AddStudentState createState() => _AddStudentState();
}
class _AddStudentState extends State<AddStudent> {
  final GlobalKey<FormState> formkey = new GlobalKey();
  Student student = Student("","","","");
  final _genders = ['male','female'];
  String _gender = 'male';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add Student"),
        elevation: 0.0,
      ),
      floatingActionButton:FloatingActionButton(onPressed: (){
        enter();
        Navigator.pop(context);
//        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.red,
        tooltip: "add a Student",),
      body: Form(
          key: formkey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Student name",
                      border: OutlineInputBorder()
                  ),
                  onSaved: (val) => student.name = val,
                  validator: (val){
                    if(val.isEmpty ){
                      return "name field cant be empty";
                    }else if(val.length > 50){
                      return "name cannot have more than 50 characters ";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Student email",
                      border: OutlineInputBorder()
                  ),
                  onSaved: (val) => student.email = val,
                  validator: (val){
                    if(val.isEmpty ){
                      return "emai field cant be empty";
                    }else if(val.length > 50){
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
                      onSaved: (val) => student.dob = val,
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
              FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
            decoration: InputDecoration(
              icon: const Icon(Icons.person_outline),
              labelText: 'gender',
            ),
            isEmpty: _gender == '',
            child:  DropdownButtonHideUnderline(
              child:  DropdownButton<String>(
                value: _gender,
                isDense: true,
                onChanged: (String newValue) {
                  setState(() {
                   student.gender = newValue;
                    _gender = newValue;
                    state.didChange(newValue);
                  });
                },
                items: _genders.map((String value) {
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
    ]),
      ),

    );
  }

  void enter() {
    final FormState form = formkey.currentState;
    if(form.validate()){
      form.save();
      form.reset();
      Details details = Details (student.toMap());
      details.addStudent();
    }
  }
}
