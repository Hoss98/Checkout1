import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../services/authentication.dart';
import '../../theme/theme.dart';
import '../../widgets/mealCard.dart';
import "package:firebase_database/firebase_database.dart";
import 'package:firebase_database/ui/firebase_animated_list.dart';

// import '../cart/index.dart';

final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
// class HomePage extends StatefulWidget {
//    const HomePage(
    
//    );
   
//   @override
//   HomePageState createState() {
//     return new HomePageState();
//   }
// }

// class HomePageState extends State<HomePage> {
//   PageController _pController;
//   int _page = 0;
//   @override
//   void initState(){
//     super.initState();
//     _pController = new PageController();
//   }
//   @override
//   void dispose(){
//     super.dispose();
//     this._pController.dispose();
//       }
//   BottomNavigationBar _buildBottomBar(){
//     return BottomNavigationBar (items: <BottomNavigationBarItem>[
//        ,

//     ],//currentIndex: this._page,
//     onTap: _handleMenuNav,);
//   }
//   void _handleMenuNav(int page) {
    
//     _pController.animateToPage(this._page,
//         duration: const Duration(milliseconds: 300), curve: Curves.ease);
//   }
//     void onPageChanged(int page) {
//     setState(() {
//       this._page = page;
//     });
//   }



//   @override
//   Widget build(BuildContext context) {
//      final userContext = StateInheritedWidget.of(context);
//      final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  
//      return Scaffold(
//       // key: scaffoldKey,
//        drawer: widget._buildDrawer(userContext,context),
//        body: PageView(
         
//          controller: _pController,
//          children: <Widget>[
//          RaisedButton(
//            onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (_)=>HomeTest())),
//          ),
//          Text("two"),
//          Text("three"),
//        ],
//          onPageChanged: onPageChanged,
         
      
//        ),//ListView(children: List.generate(5,(i)=>CardMeal())) ,
//       appBar: widget._buildAppBar(),
//       bottomNavigationBar: _buildBottomBar()

//     //  body: new MenuCard();
//     );
//   }
// }

class HomePage extends StatefulWidget {
  const HomePage();
  
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
  Widget _cart = null;
  List<BottomNavigationBarItem> _bottomBarItems;
  PageController _p ;
  int _page = 0;

  Drawer _buildDrawer(userContext,context){
    
     return new Drawer(
       child: new ListView(
         children: <Widget>[
         new UserAccountsDrawerHeader(accountEmail: new Text(userContext.user.email??'shadyaziza@gmail.com',),accountName: new Text(userContext.user.displayName??'Shady Aziza'),),
          new ListTile(
            leading: new Icon(FontAwesomeIcons.user,color: primaryColor,
          ),
          title: new Text("Profile",style: textStyle,),),
           new ListTile(
            leading: new Icon(FontAwesomeIcons.locationArrow,color: primaryColor,
          ),
          title: new Text("Places",style: textStyle,),),
          
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
   AppBar _buildAppBar() {
    return new  AppBar(
      // actions: <Widget>[
      //   new IconButton(icon: new Icon(Icons.done),onPressed: (){
      //    // Navigator.of(context).push(MaterialPageRoute(builder: (_)=>new TestFB()));
      //   },)
      // ],
      elevation: 0.0,
      title: new Text("The Kitchen"),
      backgroundColor: primaryColor,
      centerTitle: true,
    );
  }

  @override
  void initState(){
    super.initState();
    
    _p = new PageController(viewportFraction: 0.9);
    _bottomBarItems = [
      new BottomNavigationBarItem(
              icon: new Icon(FontAwesomeIcons.moneyBillAlt),
              title: new Text(
                "Economy",
                // textDirection: TextDirection.rtl,
              )),
           new BottomNavigationBarItem(
              icon: new Icon(FontAwesomeIcons.dollarSign),
              title: new Text(
                "Premium",
                // textDirection: TextDirection.rtl
              )),
              new BottomNavigationBarItem(
               
              icon: new Icon(FontAwesomeIcons.leaf),
              title: new Text(
                "Diet",
                // textDirection: TextDirection.rtl
              ))
    ];
  }
  void _handleTap(index){
    _p.animateToPage(index,duration: const Duration(milliseconds: 500),curve: Curves.ease);
  }

  
  @override
  Widget build(BuildContext context) {
    final userContext = StateInheritedWidget.of(context);
     
    return new Scaffold(
      floatingActionButton: new FloatingActionButton(
        child: new Icon(FontAwesomeIcons.utensils),
        onPressed: ()=>Navigator.of(context).pushNamed("/Cart")
      ),
      key: scaffoldKey,
      appBar: _buildAppBar(),
      drawer: _buildDrawer(userContext, context),
      body: new PageView (
        controller: _p,
        children: <Widget>[
          const MealList (tabSelector: "eco",),
           const MealList (tabSelector: "prem",),
            const MealList (tabSelector: "diet",),
          //  _cart,
        //  ListView(children: List.generate(15,(i)=>CardMeal()),),
        //  ListView(children: List.generate(15,(i)=>CardMeal()),),
        //  ListView(children: List.generate(15,(i)=>CardMeal()),),
        // //  ListView(children: List.generate(15,(i)=>CardMeal()),),
        //  ListView(children: List.generate(15,(i)=>CardMeal()),),
        ],
        onPageChanged: (p){
         // print(userContext.getMeals().toString());
          setState((){
            this._page=p;
          });
        },
      ),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(canvasColor: secondaryColor),
              child: new BottomNavigationBar(fixedColor: Colors.white,
          items: _bottomBarItems,
          currentIndex: _page,
          onTap: _handleTap,
        ),
      ),
    );
  }
}

