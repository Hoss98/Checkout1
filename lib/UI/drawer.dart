import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../services/authentication.dart';
import '../state/state.dart';
import '../theme/theme.dart';
class KitchenDrawer extends StatefulWidget {
  @override
  _KitchenDrawerState createState() => new _KitchenDrawerState();
}

class _KitchenDrawerState extends State<KitchenDrawer> {
  @override
  Widget build(BuildContext context) {
    final appState = InheritedApp.of(context);
    return new Drawer(
       child: new ListView(
         children: <Widget>[
         new UserAccountsDrawerHeader(accountEmail: new Text(appState.user.email,style: DarkTextStyle,),accountName: new Text(appState.user.displayName,style: DarkTextStyle,),decoration: new BoxDecoration(color:Colors.grey[200]),),
          new ListTile(
            leading: new Icon(FontAwesomeIcons.user,color: primaryColor,
          ),
          title: new Text("Profile",style: DarkTextStyle,),),
           new ListTile(
            leading: new Icon(FontAwesomeIcons.locationArrow,color: primaryColor,
          ),
          title: new Text("Places",style: DarkTextStyle,),),
          
         new  ListTile(
            leading: new Icon(FontAwesomeIcons.history,color: primaryColor,
          ),
          title:  new Text("Order History",style: textStyle),),
           new ListTile(
            leading: new Icon(FontAwesomeIcons.signOutAlt,color: primaryColor,
          ),
          title:new  Text("Sign Out",style: textStyle),onTap: (){
               UserAuth auth = new UserAuth();
               auth.firebaseAuth.signOut().then((_)=>Navigator.of(context).pushReplacementNamed("/Login"));
               //StateInheritedWidget.of(context).user=null;
          },),
        
         ]
         
       ),
      );
  }
}

class KitchenAppBar extends StatefulWidget {
 
  @override
  KitchenAppBarState createState() {
    return new KitchenAppBarState();
  }
}

class KitchenAppBarState extends State<KitchenAppBar> {
  @override
  Widget build(BuildContext context) {
     return new AppBar(
       
        title: new Text("THE KITCHEN",style: DarkTextStyle,),
        backgroundColor: Colors.grey[200],
        centerTitle: true,
        elevation:defaultTargetPlatform == TargetPlatform.iOS? 0.8
        :1.0,
     );
        
  }
}
