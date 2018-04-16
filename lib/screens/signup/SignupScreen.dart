import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../main.dart';
import '../../services/authentication.dart';
import '../../services/validations.dart';
import '../../theme/theme.dart';
import '../../widgets/inputField.dart';
import '../../widgets/roundedButton.dart';
import '../../widgets/textButton.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => new _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<ScaffoldState> _scaffoldSignUpKey = new GlobalKey<ScaffoldState>();
  UserAuth userAuth = new UserAuth();
  UserData user = new UserData();
  final GlobalKey<FormState> formSignUpKey = new GlobalKey<FormState>();
  bool autovalidate = false;
  Validations validations = new Validations();

  AppBar _buildAppBar() {
    return new AppBar(
      elevation: 0.0,
      title: new Text("Create An Account"),
      backgroundColor: primaryColor,
      centerTitle: true,
    );
  }

  void _handleSubmitted() {
    final FormState form = formSignUpKey.currentState;
    if (!form.validate()) {
      autovalidate = true; // Start validating on every change.
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      userAuth.createUser(user).then((onValue) {
        
        if (onValue == "Account Created Successfully"){
          userAuth.verifyUser(user).then((_){
            Navigator.pushReplacement(context, new MaterialPageRoute(
            builder: (_)=>new FoodApp()
          ));
          });
          }
        else
          showInSnackBar("ERROR");
      }).catchError((PlatformException onError) {
        showInSnackBar(onError.message);
      });
    }
  }

  void showInSnackBar(String value) {
    _scaffoldSignUpKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }
  _onPressed() {
    print("button clicked");
  }

  onPressed(String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  _scaffoldBody(context) {
    final Size screenSize = MediaQuery.of(context).size;
    return new Padding(
      padding: const EdgeInsets.all(20.0),
      child: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          new Container(
            //   height: 500.0,
            // width: 500.0,
            decoration: new BoxDecoration(
              border: new Border.all(color: primaryColor),
              borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
              //color: primaryColor
            ),
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
            child: new Form(
                key: formSignUpKey,
                autovalidate: autovalidate,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  // [new InputField(
                  //       hintText: "Phone Number",
                  //       hintStyle: textStyle,
                  //       obscureText: false,
                  //       textInputType: TextInputType.number,
                  //       textStyle: textStyle,
                  //       textFieldColor: textFieldColor,
                  //       icon: FontAwesomeIcons.phone,
                  //       iconColor: primaryColor,
                  //       bottomMargin: 20.0,
                  //       validateFunction: validations.validateNumber,
                  //       onSaved: (String username) {
                  //         user.phoneNumber = username;
                  //       }),
                  //   new InputField(
                  //       hintText: "User Name",
                  //       hintStyle: textStyle,
                  //       obscureText: false,
                  //       textInputType: TextInputType.text,
                  //       textStyle: textStyle,
                  //       textFieldColor: textFieldColor,
                  //       icon: FontAwesomeIcons.user,
                  //       iconColor: primaryColor,
                  //       bottomMargin: 20.0,
                  //       validateFunction: validations.validateName,
                  //       onSaved: (String username) {
                  //         user.displayName = username;
                  //       }),
                    new InputField(
                        hintText: "Email",
                        hintStyle: textStyle,
                        obscureText: false,
                        textInputType: TextInputType.emailAddress,
                        textStyle: textStyle,
                        textFieldColor: textFieldColor,
                        icon: FontAwesomeIcons.envelope,
                        iconColor: primaryColor,
                        bottomMargin: 20.0,
                        validateFunction: validations.validateEmail,
                        onSaved: (String email) {
                          user.email = email;
                        }),
                    new InputField(
                        hintText: "Password",
                        hintStyle: textStyle,
                        obscureText: true,
                        textInputType: TextInputType.text,
                        textStyle: textStyle,
                        textFieldColor: textFieldColor,
                        icon: FontAwesomeIcons.key,
                        iconColor: primaryColor,
                        bottomMargin: 20.0,
                        validateFunction: validations.validatePassword,
                        onSaved: (String password) {
                          user.password = password;
                        }),
                  ],
                )),
          ),
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new RoundedButton(
              buttonName: "Get Started",
              onTap: _handleSubmitted,
              width: screenSize.width,
              height: 50.0,
              bottomMargin: 10.0,
              borderWidth: 0.0,
              buttonColor: primaryColor,
            ),
          ),
         ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldSignUpKey,
      appBar: _buildAppBar(),
      body: _scaffoldBody(context),
    );
  }
}
