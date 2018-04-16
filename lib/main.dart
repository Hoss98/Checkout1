import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'screens/home/HomeScreen.dart';
import 'screens/landing/LandingScreen.dart';
import 'screens/login/LoginScreen.dart';
import 'screens/signup/SignupScreen.dart';
import 'services/authentication.dart';
import 'services/validations.dart';
import 'state/state.dart';
import 'test.dart';
import 'theme/theme.dart';
import 'widgets/inputField.dart';

void main() => runApp(
  
  //  new MaterialApp(home: new AppState())
  new FoodApp()
    // new MaterialApp(
    //   builder: (context,child){
    //     return new AppState(
    //       child: child,
    //     );
    //   },
    //   home: new  HomeScreen(),
    // )
    );


class FoodApp extends StatefulWidget {
  @override
  _FoodAppState createState() => new _FoodAppState();
}

class _FoodAppState extends State<FoodApp> {
  List _list;
  UserAuth _auth;
  UserData _user;
  bool _authChecks;
  Widget _buildWidget;
  bool _visitedBefore;
  @override
  initState() {
    super.initState();
    this._auth = new UserAuth();
    this._user = new UserData();
    this._list = new List();
    this._visitedBefore = false;
    this._buildWidget = new Container(
      // color: Colors.red,
      decoration: new BoxDecoration(
          image: new DecorationImage(
              fit: BoxFit.cover,
              image: new AssetImage("assets/imgs/splash.jpg"))),
    );
    this._auth.firebaseAuth.currentUser().then((user) {
      if (user != null) {
         print (user.uid);
        this._user
          ..uid = user.uid
          ..email = user.email;
           Firestore.instance.collection("profiles").document("${user.uid}").get().then((onValue){
        if (onValue.data["phoneNumber"]!=null){
          this._visitedBefore = true;
          Firestore.instance.collection("profiles").document("${user.uid}").get().then((onValue){
        this._user.displayName = onValue.data["displayName"];
      });
      Firestore.instance.collection("profiles").document("${user.uid}").get().then((onValue){
        this._user.phoneNumber = onValue.data["phoneNumber"];
      });

        }
    
      });

        this._authChecks = true;
        
      } else {
      
       this._authChecks = false;
      }
      new Future.delayed(const Duration(seconds: 3)).then((_) {
        setState(() {
          this._buildWidget = new MaterialApp(
            routes: <String, WidgetBuilder>{
              "/Signup": (BuildContext context)=>new SignupScreen()
            },
              builder: (context, child) {
                return new MaterialApp(
                
                  builder: (context, child) {
                    return new AppState(
                      orderList:_list,
                      user : _user,
                      child: child,
                    );
                  },
                  home: 
                  // const HomeScreen()
                  this._authChecks && this._visitedBefore? const HomeScreen(): !this._visitedBefore&&this._authChecks? const FirstTimeLogin():const LandingScreen(),
                );
              },
              home: const HomeScreen());
        });
      });
    });
  }

  String testedData = "before test";
  void createUser() {
    setState(() {
      testedData = "data has changed";
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return _buildWidget;
  }
}



class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myState = InheritedApp.of(context);
    return new Text(myState.text);
  }
}

class FirstTimeLogin extends StatefulWidget {
 const FirstTimeLogin();
  @override
  _FirstTimeLoginState createState() => new _FirstTimeLoginState();
}

class _FirstTimeLoginState extends State<FirstTimeLogin> {
  bool autovalidate = false;
   final GlobalKey<FormState> formFirstTimeKey = new GlobalKey<FormState>();
 
   Validations validations = new Validations();
  @override
  Widget build(BuildContext context) {
    final appState = InheritedApp.of(context);
    return new Scaffold(
      backgroundColor: Colors.grey[200],
      body: new Center(
      child: new Container(
        padding: const EdgeInsets.all(35.0),
              child: new Form(
                key:formFirstTimeKey,
                autovalidate: autovalidate,
                              child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new InputField(
                            hintText: "Phone Number",
                            hintStyle: textStyle,
                            obscureText: false,
                            textInputType: TextInputType.number,
                            textStyle: textStyle,
                            textFieldColor: textFieldColor,
                            icon: FontAwesomeIcons.phone,
                            iconColor: primaryColor,
                            bottomMargin: 20.0,
                            validateFunction: validations.validateNumber,
                            onSaved: (String phoneNumber) {
                                Firestore.instance.collection('profiles').document('${appState.user.uid}').updateData({"phoneNumber":phoneNumber});
                           Firestore.instance.collection('profiles').document('${appState.user.uid}').updateData({"type":"customer"});


                            }),
                        new InputField(
                            hintText: "User Name",
                            hintStyle: textStyle,
                            obscureText: false,
                            textInputType: TextInputType.text,
                            textStyle: textStyle,
                            textFieldColor: textFieldColor,
                            icon: FontAwesomeIcons.user,
                            iconColor: primaryColor,
                            bottomMargin: 20.0,
                            validateFunction: validations.validateName,
                            onSaved: (String username) {
                                              Firestore.instance.collection('profiles').document('${appState.user.uid}').updateData({"displayName":username});
                
                            }),
                          new   RaisedButton(onPressed: _handleSubmitted,)
                            
          ],
        ),
              ),
      ),
      ),
    );

  }
  _handleSubmitted(){
     final FormState form = formFirstTimeKey.currentState;
    if (!form.validate()) {
      autovalidate = true; // Start validating on every change.
      //showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (_)=>new FoodApp()));
      }
  }
}