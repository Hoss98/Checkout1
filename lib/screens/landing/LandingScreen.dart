import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../login/LoginScreen.dart';
import '../signup/SignupScreen.dart';
// import '../lsogin/index.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen();
  @override
  _LandingScreenState createState() => new _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  var _splashImage;
  var _splashImg;
  @override
  initState() {
    super.initState();
    _splashImage = new Image.asset("assets/imgs/splash.jpeg");
    _splashImg = new AssetImage("assets/imgs/splash.jpg");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Container(
            // color: Colors.red,
            decoration: new BoxDecoration(
                image:
                    new DecorationImage(fit: BoxFit.cover, image: _splashImg)),
          ),
          new Container(
            padding: const EdgeInsets.all(15.0),
            child: new Column(
               mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Container(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: new Text(
                      "THE KITCHEN",
                      style: headingTextStyle,
                    )),
                    // new Text("Here is the logo"),
                    new Container(
                      // padding: const EdgeInsets.only(top: 100.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //  crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                    new FlatButton(onPressed: ()=>Navigator.of(context).push(new MaterialPageRoute(builder: (_)=>new SignupScreen())),color: secondaryColor,child: new Text("SIGNUP")),
                    new FlatButton(onPressed: ()=>Navigator.of(context).push(new MaterialPageRoute(builder: (_)=>new LoginScreen())),color: primaryColor,child: new Text("LOGIN"),)
                
                
              ],
            ),
          )
              ],
            ),
          ),
          // new Text("Here is the logo"),
          

          // _splashImage
        ],
      ),
    );
  }
}

