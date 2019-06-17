import 'package:flutter/material.dart';
import 'package:mine/Students.dart';
import 'package:mine/profs/Profs.dart';
import 'package:mine/sbjcts/sbjcts.dart';
void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
    theme: ThemeData.dark(),
    ),
  );
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("home"),
    backgroundColor: Theme.of(context).primaryColor,
    centerTitle: true,
        ),
      body:Column(
        children: <Widget>[
          Card(
            elevation: 30,

            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
            child: ListTile(
              title: Text("Profs"),
              onTap: (){
            Navigator.push(
            context, MaterialPageRoute(builder: (context) => Profs()));
            },
            ),
          ),
          Card(
            elevation: 30,

            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
            child: ListTile(
              title: Text("Subjects"),
              onTap: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Subjects()));
              },
            ),
          ),
          Card(
            elevation: 30,
            shape: RoundedRectangleBorder
              (borderRadius: BorderRadius.all(Radius.circular(50))),
            child: ListTile(
              title: Text("Students"),
              onTap: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Students()));
              },
            ),
          ),
        ],

      ),
    );
  }
}
