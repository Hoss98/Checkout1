import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../UI/drawer.dart';

import '../state/state.dart';
import '../theme/theme.dart';
class CheckOutPage extends StatefulWidget {
  
  
  
  @override
  _CheckOutPageState createState() => new _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
 
  @override
  Widget build(BuildContext context) {
    final appState = InheritedApp.of(context);
  
    Widget _buildFoodList(InheritedApp appState){

     return appState.orderList.length>0? new Padding(
       padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
       child: new ListView.builder(
   //   shrinkWrap: true,
        itemCount:appState.orderList.length,

        itemBuilder: (BuildContext context,index){
          return new  Container(
            // height: MediaQuery.of(context).size.height/2,
            decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
             
            ),
                    child: new Column(
              //fit: StackFit.loose,
              children: <Widget>[
                new Container(
                 //height: 200.0,
                  //width: MediaQuery.of(context).devicePixelRatio,

                  decoration: new BoxDecoration(
                    color: Colors.greenAccent,
                    boxShadow: [
                      new BoxShadow(color: Colors.black45, blurRadius: 2.0, spreadRadius: 2.0)
                    ]
                  ),
               
                   
                   child: new Padding(
                     padding: new EdgeInsets.all(10.0),
                     child: new Row(
                         children: [
                            new Text(
                              appState.orderList[index]["name"].toString(), 
                              style: new TextStyle(fontSize: 20.0)
                         
                       ),
                       new Expanded(
                         child: new Container(),
                       ),
                       new Text(
                              "${appState.orderList[index]["price"].toString()} EGP.", 
                              style: new TextStyle(fontSize: 20.0)
                         
                       ),
                       new IconButton(
                         onPressed: () {
                           print("Deleted!");
                           appState.orderList.removeAt(index);
                           setState((){});
                         },
                         icon: new Icon(Icons.cancel),
                       )
                         ]
                     ),
                    
                   ),
                ),
                new Padding(
                  padding: new EdgeInsets.only(bottom: 10.0),
                )
              ]
          
          )
          );
        }
       ),
        
     ) : new Container();
    }
      
    return new Scaffold(
    
      appBar: new AppBar(
        //leading: _buildDrawerButton(),
        title: new Text("THE KITCHEN",style: DarkTextStyle,),
        backgroundColor: Colors.grey[200],
        centerTitle: true,
        elevation:defaultTargetPlatform == TargetPlatform.iOS? 0.8
        :1.0,
        actions: <Widget>[
           new IconButton(icon: new Icon(Icons.done,color: primaryColor,),
              onPressed: (){print ("Checked Out!");},
           ),
        ],
     ),
      drawer: new KitchenDrawer(),
      body:  new Stack(
        children: <Widget>[
            new Container(decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/imgs/home.jpeg"),
                fit: BoxFit.cover
              )
            )),
          _buildFoodList(appState),
        ],
      ),
        
    );
  }
}

