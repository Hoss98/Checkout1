import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/authentication.dart';
import '../home/index.dart';
import '../login/index.dart';

class SplashScreen extends StatefulWidget {
  final Widget child;
  const SplashScreen({this.child});
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserAuth _auth;
  UserData userData;
  bool _load = false;
  List orderList = [];
  bool _exist = false;
  @override
  initState() {
    
    super.initState();
    _auth = new UserAuth();
    _auth = new UserAuth();
    userData = new UserData();
    
    _auth.firebaseAuth.currentUser().then((user) {
      var fs = Firestore.instance.collection('profiles').document(user.uid).snapshots;
     // print (fs.da)
      if (user!=null){
          this._exist=true;
        
       userData
      ..email = user.email
      ..uid = user.uid;
      //..displayName = 
    Firestore.instance.collection("profiles").document("${user.uid}").get().then((onValue){
        userData.displayName = onValue.data["displayName"];
      });
      Firestore.instance.collection("profiles").document("${user.uid}").get().then((onValue){
        userData.phoneNumber = onValue.data["phoneNumber"];
        new Future.delayed(const Duration(seconds: 2)).then((_){
        Navigator.of(context).push(
          new MaterialPageRoute(builder: (_)=>new StateInheritedWidget(
          user: userData,
          orderList: new List(),
          child: new HomePage(),
        ))
        );
      });
      });
      

      //Firestore.instance.collection("meals").add(data)      

      
  }
  else{
    new Future.delayed(const Duration(seconds: 2)).then((_){
        Navigator.of(context).push(
          new MaterialPageRoute(builder: (_)=>new StateInheritedWidget(
          user: userData,
          orderList: new List(),
          child: new LoginPage(),
        ))
        );
      });
  }}
  );}
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text("Splash"),
      ),
    );
  //   final stateContext = StateInheritedWidget.of(context);
    
  //   new Future.delayed(const Duration(seconds: 2)).
  //      then((_) {
  //       setState((){
  //          _load=true;
  //       });
  //        //Navigator.of(context).pushReplacementNamed(this.widget.child);
         
  //   });
  //  // _checkAuth(stateContext);
  //   return _exist?
  //   // new Scaffold(
  //   //   body: new Center(
  //   //     child: new Text('Splash'),
  //   //   ),
  //   new HomePage():new LoginPage();
  // }
}}

