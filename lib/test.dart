import 'package:flutter/material.dart';

class AppTest extends StatelessWidget {
  String user = "user";
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Test"),backgroundColor: Colors.red,),
      body: new Center(
        child: new RaisedButton(
          onPressed: ()=>Navigator.of(context).push(new MaterialPageRoute(builder: (_)=>new SecondPage(user:this.user ,)))
        ),
      ),
    );
  
  }
}

class SecondPage extends StatelessWidget {
  String user;
  SecondPage({this.user});


  @override
  Widget build(BuildContext context) {
    return new Container();
  }
}
