import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mine/profs/Profs.dart';
import 'profs_class.dart';
import 'profs_details.dart';

class EditProf extends StatefulWidget {
 final Prof prof;
 EditProf(this.prof);
  @override
  _EditProfState createState() => _EditProfState();
}

class _EditProfState extends State<EditProf> {
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
        title: Text("edit Prof"),
        elevation: 0.0,
      ),
      body: Form(
          key: formkey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: widget.prof.name,
                  decoration: InputDecoration(
                      labelText: "Prof name",
                      border: OutlineInputBorder()
                  ),
                  onSaved: (val) => widget.prof.name = val,
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
                  initialValue: widget.prof.name,
                  decoration: InputDecoration(
                      labelText: "Prof name",
                      border: OutlineInputBorder()
                  ),
                  onSaved: (val) => widget.prof.name = val,
                  validator: (val){
                    if(val.isEmpty){
                      return "name field cant be empty";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: widget.prof.email,
                  decoration: InputDecoration(
                      labelText: "Prof email",
                      border: OutlineInputBorder()
                  ),
                  onSaved: (val) => widget.prof.email = val,
                  validator: (val){
                    if(val.isEmpty){
                      return "email field cant be empty";
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
//        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Profs()));
      },
        child: Icon(Icons.edit, color: Colors.white,),
        backgroundColor: Colors.red,
        tooltip: "exit a Prof",),
    );
  }

  void enter() {
    final FormState form = formkey.currentState;
    if(form.validate()){
      form.save();
      form.reset();
      ProfDetails profDetails = ProfDetails(widget.prof.toMap());
      profDetails.updateProf();
    }
  }


}