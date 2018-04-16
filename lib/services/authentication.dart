import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';


class UserData {
  String displayName;
  String email;
  String uid;
  String password;
  String photoUrl;
  String phoneNumber;

  UserData({this.displayName, this.email, this.uid, this.password,this.photoUrl,this.phoneNumber});
}

class UserAuth {
  String statusMsg="Account Created Successfully";
   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  
  //To create new User
  Future<String> createUser(UserData userData) async{
   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
   
     firebaseAuth
        .createUserWithEmailAndPassword(
            email: userData.email, password: userData.password).then((user){
               user =user;
              Firestore.instance.collection('profiles').document('${user.uid}').updateData({"phoneNumber":userData.phoneNumber});
              Firestore.instance.collection('profiles').document('${user.uid}').updateData({"type":userData.displayName});
              Firestore.instance.collection('profiles').document('${user.uid}').updateData({"type":"customer"});

              
            });
    return statusMsg;
  }

  //To verify new User
  Future<String> verifyUser (UserData userData) async{
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .signInWithEmailAndPassword(email: userData.email, password: userData.password);
    return "Login Successfull";
  }
  
  
}

  

  @immutable
class StateInheritedWidget extends InheritedWidget {

   StateInheritedWidget({Key key,this.user,this.orderList,this.createUser,this.test, Widget child}): super(key:key, child:child);


  final UserData user;
  final List orderList;
 // int total =0;
  final Function createUser;
  final String test;
 // final Function testUserCreation;
  // void createUser;
  // void loginUser;
  // void signOutUser;
  //final DatabaseReference mealRef = FirebaseDatabase.instance.reference().child(
    //  "meals");

  //getMeals()=>mealRef.once();
 

  addOrder(order){
    this.orderList.add(order);

  }
  removeOrder(index){
    this.orderList.removeAt(index);
    
  }
  getTotal(price){
   // this.total = this.total+price;
  }
  
  @override
  bool updateShouldNotify(StateInheritedWidget old) {
   // user != old.user || orderList!=old.orderList ||test!=old.test;
    return test != old.test;}
  
 
   static StateInheritedWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(StateInheritedWidget);
  }
  
    
}

class UserInheritedWidget extends InheritedWidget {
  final UserData user;

  
  
  
  UserInheritedWidget({this.user, child}): super(child:child);
   static UserInheritedWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(UserInheritedWidget);
  }
  @override
  bool updateShouldNotify(UserInheritedWidget old) =>
    user != old.user ;
    
}

class InheritOrderList extends InheritedWidget {
  final List orderList;
  int total =0;
  
  //final DatabaseReference mealRef = FirebaseDatabase.instance.reference().child(
    //  "meals");

  //getMeals()=>mealRef.once();
  addOrder(order){
    this.orderList.add(order);

  }
  removeOrder(index){
    this.orderList.removeAt(index);
    
  }
  getTotal(price){
    this.total = this.total+price;
  }
   InheritOrderList({this.orderList, child}): super(child:child);
   static StateInheritedWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(StateInheritedWidget);
  }
  @override
  bool updateShouldNotify(StateInheritedWidget old) =>
    orderList!=old.orderList;
}