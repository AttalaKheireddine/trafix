import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home :Scaffold(
      key: _scaffoldKey,

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
                      leading: Icon(Icons.local_hospital),
                      onTap: (){ _scaffoldKey.currentState.openEndDrawer();
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => new signaler()));    },),
            Divider(),
            ListTile( title: Text('Liste des accidents'),
              leading: Icon(Icons.directions_car),
              onTap: (){

              },
            ),
            Divider(),
            ListTile( title: Text('Choisir un chemin'),
              leading: Icon(Icons.location_on),
              onTap: (){ _scaffoldKey.currentState.openEndDrawer();
              Navigator.push(context, MaterialPageRoute(builder: (context) => new Map()));    },),
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
               MaterialPageRoute(builder: (context) => new MyApp()));},
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


  Completer<GoogleMapController> _controller = Completer();
  
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

           appBar: AppBar(backgroundColor: Colors.deepPurple,
             leading: new IconButton(
             icon: new Icon(Icons.arrow_back, color: Colors.white),
             onPressed: () => Navigator.of(context).pop(),
           ), ),




           body:GoogleMap(
             mapType: MapType.hybrid,
             initialCameraPosition: _kGooglePlex,
             onMapCreated: (GoogleMapController controller) {
               _controller.complete(controller);
             },
           ),

      ),
    );
  }
}



//------------------ Signaler un accident

class signaler extends StatefulWidget {
  @override
  _signalerState createState() => _signalerState();
}

class _signalerState extends State<signaler> {

String s="0";
  File _image;




  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {

      _image = image;


    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp
      (
      home: Scaffold(

        appBar: AppBar(backgroundColor: Colors.deepPurple, leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),),
        body: ListView(

          children: <Widget>[



          Column(
            children: <Widget>[
              
              Image.asset('assets/car-crash.png',scale: 2,),

              Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: <Widget>[

                 Padding(
                   padding: const EdgeInsets.only(left: 20),
                   child: Icon(Icons.place ,size: 50,),
                 ),
                 Flexible(child:
                 Padding(
                   padding: const EdgeInsets.only(left: 20,right: 40,bottom: 10),
                   child: Container(child: TextField( decoration:  new InputDecoration(
                       hintText: 'Ex: alger',
                       labelText: 'lieu',

                   )
                     ,)),
                 ),)
              ],),


              Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Icon(Icons.people ,size: 50,),
                  ),
                  Flexible(child:
                  Padding(
                    padding:const EdgeInsets.only(left: 20,right: 40,bottom: 10),
                    child: Container(child: TextField( decoration:  new InputDecoration(
                      hintText: 'Ex: 10',
                      labelText: 'nombre de victimes',


                    ),
                      keyboardType: TextInputType.number,
                      )),
                  ),)
                ],),


              Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Icon(Icons.calendar_today ,size: 50,),
                  ),
                  Flexible(child:
                  Padding(
                    padding:const EdgeInsets.only(left: 20,right: 40,bottom: 20),
                    child: Container(child: TextField( decoration:  new InputDecoration(
                      hintText: 'Ex: ',
                      labelText: 'Date et heure',

                    )
                      ,
                    keyboardType: TextInputType.datetime)),
                  ),)
                ],),
              
              
               IconButton( iconSize: 40, color: Colors.deepPurpleAccent, icon: Icon(Icons.add_photo_alternate), onPressed:() {getImage() ;


               },),

              _image == null
                  ? Text('Ajouter une image')
                  : Row( mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[  Icon( Icons.check,color: Colors.green,), Text("Image chargé"),],),



              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  onPressed: () {},
                  elevation: 10,
                  color: Colors.deepPurpleAccent,
                  child: Text("Soummetre",style: TextStyle(color: Colors.white ),),

                ),
              )

            ],
          ),






        ],)

      ),

    );
  }
}