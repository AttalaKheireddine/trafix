import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



void main() => runApp(Rootscreen());


class Rootscreen extends StatefulWidget
{
  @override
  _RootscreenState createState() => _RootscreenState();
}

class _RootscreenState extends State<Rootscreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( home: Scaffold( body: login(),),);
  }
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  final appTitle = '';

  AnimationController _controller;
  Animation<double> _animation;

  initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000),vsync: this, value: 0.1);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);

    _controller.forward();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home :Scaffold(

      appBar: AppBar(backgroundColor: Colors.deepPurple,),


      body: ScaleTransition(scale: _animation ,child: Center(child:
      Image.asset('assets/urbanix-l-s.png',),
      ),) ,

      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
           UserAccountsDrawerHeader(

               decoration: BoxDecoration( color: Colors.deepPurpleAccent ),
               otherAccountsPictures: <Widget>[
                 CircleAvatar(child: Icon(Icons.tag_faces), backgroundColor: Colors.deepPurple,),


               ],
               currentAccountPicture: CircleAvatar(child: Icon(Icons.assignment_ind ,size: 50,),backgroundColor: Colors.deepPurple,),
               accountName: Text("fouad"), accountEmail: Text("+213 669506475")),

            ListTile( title: Text('Signaler un accident'),
                      leading: Icon(Icons.local_hospital),),
            Divider(),
            ListTile( title: Text('Liste des accidents'),
              leading: Icon(Icons.directions_car),),
            Divider(),
            ListTile( title: Text('Choisir un chemin'),
              leading: Icon(Icons.location_on),),
            Divider(),
            ListTile( title: Text('SOS'),
              leading: Icon(Icons.call),
              onTap: (){ },
            ),
            Divider(),
            ListTile( title: Text('Sortir'),
              leading: Icon(Icons.exit_to_app),
              onTap: (){ exit(0);},
            ),











          ],
        ),
      ),
    )
    );
  }
}



//---------------------------- First page ------------------------------------------//

class login extends StatefulWidget
{
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {

   return MaterialApp(
     home: Scaffold
       (
       backgroundColor: const Color(0xff662D91),



       body:

       Center
          (child: Column(   mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>
       [
         Image.asset('assets/logo-w.png',scale: 5,),

         //--- Auth button

         Container(

           margin: EdgeInsets.only(left: 60,right: 60,top: 20),


             child:
         RaisedButton(
           color: Colors.orange,
             padding: EdgeInsets.only(top: 10,bottom: 10),
             elevation: 20,
             shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),

             onPressed:() {
               Navigator.push(
               context,
               MaterialPageRoute(builder: (context) => MyApp()));},
           child:

         Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,




           children: <Widget>
           [
             Icon(Icons.phone , color: Colors.white,size: 30,),
             Text('Authentification',style: TextStyle(color: Colors.white ,fontSize: 20),),
           ],
         ),
         )
         )
       ],)







        ),

     ),
   );
  }
}




//------- Map
class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

           appBar: AppBar(backgroundColor: Colors.deepPurple,
             leading: new IconButton(
             icon: new Icon(Icons.arrow_back, color: Colors.white),
             onPressed: () => Navigator.of(context).pop(),
           ), ),




           body: Text('hello'),

      ),
    );
  }
}



