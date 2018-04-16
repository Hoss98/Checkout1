import 'package:flutter/material.dart';

SnackBar showSnack (content,context){
  return new SnackBar(content: new Text(content),action: new SnackBarAction(label: 'Close',onPressed: context,),);
}