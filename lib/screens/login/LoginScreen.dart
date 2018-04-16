import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../main.dart';
import '../../services/authentication.dart';
import '../../services/validations.dart';
import '../../state/state.dart';
import '../../theme/theme.dart';
import '../../widgets/inputField.dart';
import '../../widgets/roundedButton.dart';
import '../../widgets/textButton.dart';
import '../home/HomeScreen.dart';
import '../home/index.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen();
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldLoginKey = new GlobalKey<ScaffoldState>();
  UserAuth userAuth = new UserAuth();
  UserData user = new UserData();
  final GlobalKey<FormState> formLoginKey = new GlobalKey<FormState>();
  bool autovalidate = false;
  Validations validations = new Validations();

  AppBar _buildAppBar() {
    return new AppBar(
      elevation: 0.0,
      title: new Text("Sign In"),
      backgroundColor: primaryColor,
      centerTitle: true,
    );
  }

  void _handleSubmitted(userState) {
    final FormState form = formLoginKey.currentState;
    if (!form.validate()) {
      autovalidate = true; // Start validating on every change.
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      userAuth.verifyUser(user).then((onValue) {
        userState.userLogin;
        if (onValue == "Login Successfull")
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
                builder: (_) =>new FoodApp()
                ));
         // Navigator.pushNamed(context, "/HomePage");
        else
          showInSnackBar(onValue);
      }).catchError((PlatformException onError) {
        showInSnackBar(onError.message);
      });
    }
  }

  void showInSnackBar(String value) {
    _scaffoldLoginKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }
  _onPressed() {
    print("button clicked");
  }

  onPressed(String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  _scaffoldBody(context,userState) {
    final Size screenSize = MediaQuery.of(context).size;
    return new Padding(
      padding: const EdgeInsets.all(20.0),
      child: new ListView(
        shrinkWrap: true,
        children: <Widget>[
         new  Container(
            //   height: 500.0,
            // width: 500.0,
            decoration: new BoxDecoration(
              border: new Border.all(color: primaryColor),
              borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
              //color: primaryColor
            ),
            padding: new EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
            child: new Form(
                key: formLoginKey,
                autovalidate: autovalidate,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>
                  [ new InputField(
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
              buttonName: "Login",
              onTap: ()=>_handleSubmitted(userState),
              width: screenSize.width,
              height: 50.0,
              bottomMargin: 10.0,
              borderWidth: 0.0,
              buttonColor: primaryColor,
            ),
          ),
          new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new TextButton(
                                buttonName: "Create Account",
                                onPressed: () => onPressed("/SignUp"),
                                buttonTextStyle: buttonTextStyle),
                            new TextButton(
                                buttonName: "Need Help?",
                                onPressed: _onPressed,
                                buttonTextStyle: buttonTextStyle)
                          ],
                        )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userState =InheritedApp.of(context);
   
    return new Scaffold(
      key: _scaffoldLoginKey,
      appBar: _buildAppBar(),
      body: _scaffoldBody(context,userState),
    );
  }
}
