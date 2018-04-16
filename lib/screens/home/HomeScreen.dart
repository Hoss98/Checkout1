import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../main.dart';
import '../../services/authentication.dart';
import '../../state/state.dart';
import '../../theme/theme.dart';
import '../checkOut.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();
  @override
  HomeScreenState createState() {
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  int _len = 0;
   GlobalKey<ScaffoldState> _homeScreenKey = new GlobalKey<ScaffoldState>();
   List _meals = [];
  @override
  void initState() {
      FirebaseDatabase.instance.reference().child("meals").once().then((meals){
        setState((){this._meals=meals.value["eco"];});
        print (_meals);
      });
      super.initState();
    }
    Drawer _buildDrawer(appState,context){
    
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
   Widget _buildDrawerButton(){
     return new IconButton(icon: new Icon(FontAwesomeIcons.alignLeft,color: primaryColor,),onPressed: ()=>_homeScreenKey.currentState.openDrawer(),);
   }
   AppBar _buildAppBar(InheritedApp appState){
     return new AppBar(
        leading: _buildDrawerButton(),
        title: new Text("THE KITCHEN",style: DarkTextStyle,),
        backgroundColor: Colors.grey[200],
        centerTitle: true,
        elevation:defaultTargetPlatform == TargetPlatform.iOS? 0.8
        :1.0,
        actions: <Widget>[
          new Stack(
            children: <Widget>[
              new IconButton(icon: new Icon(FontAwesomeIcons.shoppingCart,color: primaryColor,),
              onPressed: 
                ()=> Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new CheckOutPage())),
              ),
              new Positioned(
                top:5.0,
                left:5.0,
                child: appState.orderList.length>0? new  Container(
                  width: 15.0,
                  height: 15.0,
                  child: new CircleAvatar(
                    backgroundColor: Colors.red,
                    child: new Text("${appState.orderList.length.toString()}",textScaleFactor: 0.5,),
                  ),
                ):new Container(),
              )
            ],
          )
        ],
      );
   }
   Widget _buildFoodList(appState){
     return this._meals.length>0? new Padding(
       padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
       child: new ListView.builder(
   //   shrinkWrap: true,
        itemCount:this._meals.length ,

        itemBuilder: (BuildContext context,index){
          return new  Container(
            // height: MediaQuery.of(context).size.height/2,
            height: 400.0,
                    child: new Stack(
              //fit: StackFit.loose,
              children: <Widget>[
                new Container(
                 //height: 200.0,
                  //width: MediaQuery.of(context).devicePixelRatio,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new NetworkImage(_meals[index]["photo"]),
                    fit: BoxFit.cover
                  )
                )
                ),
                new Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                       
                        children: <Widget>[
                          // new CircleAvatar(backgroundColor: Colors.red,child: new IconButton(icon: new Icon(FontAwesomeIcons.cartPlus),onPressed:() =>_handleOrderList(appState,_meals[index]),color: Colors.amberAccent,))
                          new FlatButton(onPressed:() =>_handleOrderList(appState,_meals[index]), child: new Text("ADD TO CART"),color: Colors.red,),
                        ],
                      ),
                    ),
                new Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: FractionalOffset.bottomLeft,
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      
                      
                        
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Text(_meals[index]["name"],style:headingTextStyle,overflow: TextOverflow.fade,),
                        ],
                      ),
                      
                        new Text(_meals[index]["description"],style:textStyle),
                      



                    ],
                  ),
                ),
               
                
              ],
            ),
          );
        },
    ),
     ): new Center(child: new CircularProgressIndicator());
   }
    _handleOrderList(appState,orderObject){
    appState.addOrder(orderObject);
    setState((){
      this._len=appState.orderList.length;
    });
    print (appState.orderList);
  }

  @override
  Widget build(BuildContext context) {
    final appState = InheritedApp.of(context);
    return new Scaffold (
      // floatingActionButton: new FloatingActionButton(onPressed: () {},),
      key: _homeScreenKey,
     
     drawer: _buildDrawer(appState, context),
      appBar: _buildAppBar(appState),
      body:
      new Stack(
        children: <Widget>[
            new Container(decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/imgs/home.jpeg"),
                fit: BoxFit.cover
              )
            )),
          _buildFoodList(appState),
        ],
      )
      
      
      // new Column(
      //   children: <Widget>[
      //     new RaisedButton(
      //       onPressed: (){
      //         print (appState.user.phoneNumber);
      //         appState.addOrder("new order");
      //         print (appState.orderList);
      //         setState((){
      //           _len = appState.orderList.length;
      //         });
      //       },
      //     )
      //   ],
      // ),
    );
  }
}

class FoodList extends StatefulWidget {
  @override
  FoodListState createState() {
    return new FoodListState();
  }
}

class FoodListState extends State<FoodList> {
  List _meals = [];
  @override
  void initState() {
      FirebaseDatabase.instance.reference().child("meals").once().then((meals){
        setState((){this._meals=meals.value["eco"];});
        print (_meals);
      });
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    final appState = InheritedApp.of(context);
    return this._meals.length>0? new ListView.builder(
   //   shrinkWrap: true,
      itemCount:this._meals.length ,

      itemBuilder: (BuildContext context,index){
        return new  Container(
          height: 400.0,
                  child: new Stack(
            //fit: StackFit.loose,
            children: <Widget>[
              new Container(
               //height: 200.0,
                //width: MediaQuery.of(context).devicePixelRatio,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new NetworkImage(_meals[index]["photo"]),
                  fit: BoxFit.cover
                )
              )
              ),
              new Padding(
                    padding: const EdgeInsets.all(100.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                     
                      children: <Widget>[
                       new IconButton(icon: new Icon(FontAwesomeIcons.cartPlus),onPressed:() =>_handleOrderList(appState,_meals[index]),color: Colors.amberAccent,)
                       // new FlatButton(onPressed:() =>_handleOrderList(appState,_meals[index]), child: new Text("ADD TO CART"),color: Colors.amberAccent,),
                      ],
                    ),
                  ),
              new Container(
                padding: const EdgeInsets.all(8.0),
                alignment: FractionalOffset.bottomLeft,
                              child: new Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    
                    
                      
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Text(_meals[index]["name"],style:headingTextStyle),
                      ],
                    ),
                    
                      new Text(_meals[index]["description"],style:textStyle),
                    



                  ],
                ),
              ),
             
              
            ],
          ),
        );
      },
    ): new Center(child: new CircularProgressIndicator());
  }
  _handleOrderList(appState,orderObject){
    appState.addOrder(orderObject);
    print (appState.orderList);
  }
}