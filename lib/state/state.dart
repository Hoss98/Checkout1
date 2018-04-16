import 'package:flutter/material.dart';

import '../services/authentication.dart';

class AppState extends StatefulWidget {
  Widget child;
  UserData user;
  List orderList;
  AppState({this.child,this.user,this.orderList});
  @override
  _AppStateState createState() => new _AppStateState();
}

class _AppStateState extends State<AppState> {
  
  // UserAuth _auth;
  // UserData _user;
  @override
  initState(){
    super.initState();
    
    // _user = new UserData();
    // _auth = new UserAuth();
  }
  String text = "before update";
  void onTap() {
    setState(() {
      this.text = "update";
    });
  }
  // void userLogin(){
  //   _auth.firebaseAuth.currentUser().then((user){
  //     setState((){
  //       widget.user
  //       ..email=user.email
  //       ..uid=user.uid;
  //     });
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return new InheritedApp(
      user:widget.user,
      orderList:widget.orderList,
      text: text,
      onTap: onTap,
      child: widget.child,
    );
  }
}



class InheritedApp extends InheritedWidget {
  InheritedApp({
    Key key,
    this.text,
    this.onTap,
    this.userLogin,
    this.user,
    this.orderList,
    Widget child,
  }) : super(key: key, child: child);

  final String text;
  final Function onTap;
  final Function userLogin;
  final UserData user;
  final List orderList;
  
  void addOrder(order){
    this.orderList.add(order);
  }
  
  @override
  bool updateShouldNotify(InheritedApp oldWidget) {
    return text != oldWidget.text ||user !=oldWidget.user||orderList != oldWidget.orderList;
  }

  static InheritedApp of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(InheritedApp);
  }
}