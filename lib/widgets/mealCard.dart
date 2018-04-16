import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meta/meta.dart';
import 'dart:async';
import '../screens/home/index.dart' as Home;
import '../services/authentication.dart';
import '../services/notification.dart' as Notify;
import '../theme/theme.dart';
import 'package:firebase_database/firebase_database.dart';


@immutable
class MealList extends StatelessWidget {
  final String tabSelector;
  const MealList({this.tabSelector});

  @override
  Widget build(BuildContext context) {
  //  return FutureBuilder(
  //    future: FirebaseDatabase.instance
  //         .reference()
  //         .child("meals/${this.tabSelector}").once(),
  //    builder: (BuildContext context, AsyncSnapshot snapshot) {
  //    //snapshot.hasData?new Text("Awesome"):new CircularProgressIndicator();
  //    return new Container(
  //      color: Colors.green,
  //    );
  //  },);
   
    return new FirebaseAnimatedList(
      //defaultChild: CircularProgressIndicator(),
      query: FirebaseDatabase.instance
          .reference()
          .child("meals/${this.tabSelector}"),
      itemBuilder: (BuildContext context, DataSnapshot meals,
          Animation animation, int index) {
        return  new MealCard(
          index: index,
          meals: meals,
        );
      },
    );
  }
}

class MealCard extends StatefulWidget {
  final int index;
  final meals;
  const MealCard({
    this.index,
    this.meals,
  });
  @override
  _MealCardState createState() => new _MealCardState();
}

class _MealCardState extends State<MealCard> {
  Color _addMealColor;
  Color _addFavColor;
  @override
  initState() {
    super.initState();
    _addMealColor = appTheme.disabledColor;
    _addFavColor = appTheme.disabledColor;
  }

  _handleOrder(stateContext, name, price, index) {
    stateContext.getTotal(price);
   // print (stateContext.total);
    var order = {
      "orderName": name,
      "orderPrice": price,
     // "customer": stateContext.user.displayName,
     // "customerID": stateContext.user.uid,
     // "customerPhone": stateContext.user.phoneNumber,
    };
  
    if (_addMealColor == appTheme.disabledColor) {
      setState(() {
        _addMealColor = secondaryColor;
      });
      stateContext.addOrder(order);
      Home.scaffoldKey.currentState.showSnackBar(Notify.showSnack(
          '$name added to cart.',
          () => Home.scaffoldKey.currentState.removeCurrentSnackBar()));
      print(stateContext.orderList);
    } else {
      setState(() {
        _addMealColor = appTheme.disabledColor;
      });
      stateContext.removeOrder(index);
      Home.scaffoldKey.currentState.showSnackBar(Notify.showSnack(
          '$name removed from cart.',
          () => Home.scaffoldKey.currentState.removeCurrentSnackBar()));
      print(stateContext.orderList);
    }
  }
  List<Widget> _buildStack(stateContext){
    return <Widget>[
             new Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                new  Expanded(
                    child:new Container(
                      decoration: new BoxDecoration(
                          boxShadow: <BoxShadow>[
                            // BoxShadow(color: Colors.black,blurRadius: 8.0,)
                          ],
                          image: new DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  new NetworkImage(widget.meals.value["photo"]))),
                      //height: MediaQuery.of(context).size.height*0.2,
                      //color: Colors.blue,
                    ),
                  ),
                  new Flexible(
                    child:new Container(
                      padding: const EdgeInsets.all(8.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            "${widget.meals.value["name"].toUpperCase()} (${widget.meals.value["price"]}EGP)",
                            textScaleFactor: 1.2,
                            style:new TextStyle(fontWeight: FontWeight.bold),
                          ),
                          new Text(
                            widget.meals.value["description"],
                            maxLines: 3,
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.clip,
                          ),
                          new Row(
                            //crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              new Flexible(
                                  child:new IconButton(
                                icon: new Icon(
                                  FontAwesomeIcons.cartPlus,
                                  color: _addMealColor,
                                ),
                                onPressed: () => _handleOrder(
                                    stateContext,
                                    widget.meals.value["name"],
                                    widget.meals.value["price"],
                                    widget.index),
                              )),
                             new Flexible(
                                  child:new IconButton(
                                icon:new Icon(
                                  FontAwesomeIcons.star,
                                  color: _addFavColor,
                                ),
                                onPressed: () {},
                              )),
                              // FlatButton (child: Text("Add to cart"),onPressed: (){},),
                              // FlatButton (child: Text("Add to cart"),onPressed: (){},),
                            ],
                          )
                        ],
                      ),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ];
  }
 

  @override
  Widget build(BuildContext context) {
    final stateContext = StateInheritedWidget.of(context);

    return new Container(
      padding: const EdgeInsets.all(8.0),
      //
      child:new Card(
        elevation: 8.0,
        child:new Container(
          height: MediaQuery.of(context).size.height / 2,
          child:new Stack(
            fit: StackFit.expand,
            children: _buildStack(stateContext)
          ),
        ),
      ),
    );
  }
}
