import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';







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
  final String name;
  final String num;
  MyApp({Key key, @required this.name,@required this.num}) : super(key: key);


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
               accountName: Text(widget.name), accountEmail: Text(widget.num)),

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
              onTap: (){ _scaffoldKey.currentState.openEndDrawer();
              Navigator.push(context, MaterialPageRoute(builder: (context) => new Sospage())); },
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

  String phoneNo;
  String smsCode;
  String verificationId;
  String Name;


//####          Firebase

  Future<void> verifyPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsCodeDialog(context).then((value) {
        print('Signed in');
      });
    };

    final PhoneVerificationCompleted verifiedSuccess = (FirebaseUser user) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => new MyApp(name: Name , num: phoneNo,)));
    };

    final PhoneVerificationFailed veriFailed = (AuthException exception) {
      print('${exception.message}');
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.phoneNo,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verifiedSuccess,
        verificationFailed: veriFailed);
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('votre code'),
            content: TextField(
              onChanged: (value) {
                this.smsCode = value;
              },
              decoration: InputDecoration( labelText: "code"),
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              new FlatButton(
                child: Text('Done'),
                onPressed: () {
                  FirebaseAuth.instance.currentUser().then((user) {
                    if (user != null) {
                      Navigator.of(context).pop();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => new MyApp(name: Name , num: phoneNo,)));
                    } else {
                      Navigator.of(context).pop();
                      signIn();
                    }
                  });
                },
              )
            ],
          );
        });
  }

  signIn() {
    FirebaseAuth.instance
        .signInWithPhoneNumber(verificationId: verificationId, smsCode: smsCode)
        .then((user) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => new MyApp( name: Name , num: phoneNo,)));

    }).catchError((e) {
      print(e);
    });
  }

  //////////////////////////////////////


  @override
  Widget build(BuildContext context) {

   return MaterialApp(
     home: Scaffold
       (
       backgroundColor: const Color(0xff662D91),



       body:

       Center
          (child:
       SingleChildScrollView(
         child: Column(   mainAxisAlignment: MainAxisAlignment.center,
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


                 showDialog(
                     context: context,
                     builder: (BuildContext context) {
                       return AlertDialog(
                         title: Text("Vos infos",textAlign: TextAlign.center,),
                         content: Column(
                           mainAxisSize: MainAxisSize.min,
                           children: <Widget>[
                               TextField(
                                 onChanged: (value) { this.Name = value;},
                                 decoration: new InputDecoration( labelText: 'Nom', hintText: 'ex: khaled mebhah'), ) ,
                               TextField(
                                 onChanged: (value) { this.phoneNo = value;},
                                 decoration: new InputDecoration( labelText: 'Num', hintText: 'ex: +213669 ....'), ),

                           ],
                         ),

                         actions: <Widget>[
                           FlatButton(
                             child: Text('Soummet'),
                             onPressed: verifyPhone,

                           ),
                         ],
                       );
                     });



                   },
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
         ],),
       )







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

  static final CameraPosition _mainpos = CameraPosition(
    target: LatLng(36.705311,  3.171040),
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
             mapType: MapType.normal,
             initialCameraPosition: _mainpos,
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


  TextEditingController place,nb_v,date_time;
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



          SingleChildScrollView(
            child: Column(
              children: <Widget>[

                Image.asset('assets/car-crash.png',scale: 2,),

                //  ------ TextField

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
                     child: Container(child:
                     TextField(
                         controller: place,
                         decoration:  new InputDecoration(
                         hintText: 'Ex: alger',
                         labelText: 'lieu',

                     )
                       ,)),
                   ),)
                ],),

                //  ------ TextField

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
                      child: Container(child: TextField(
                        controller: nb_v,
                        decoration:
                        new InputDecoration(
                        hintText: 'Ex: 10',
                        labelText: 'nombre de victimes',


                      ),
                        keyboardType: TextInputType.number,
                        )),
                    ),)
                  ],),

                //  ------ TextField

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
                      child: Container(child:
                      TextField(
                        controller: date_time,
                        decoration:
                        new InputDecoration(
                        hintText: 'Ex: ',
                        labelText: 'Date et heure',

                      )
                        ,
                      keyboardType: TextInputType.datetime)),
                    ),)
                  ],),


                 //   ### Image picker

                 IconButton( iconSize: 40, color: Colors.deepPurpleAccent, icon: Icon(Icons.add_photo_alternate), onPressed:() {getImage() ;


                 },),

                _image == null
                    ? Text('Ajouter une image')
                    : Row( mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[  Icon( Icons.check,color: Colors.green,), Text("Image chargé"),],),


                //  ######       Submition button
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    onPressed: ()
                    {

                    },
                    elevation: 5,
                    color: Colors.deepPurpleAccent,
                    child: Text("Soummetre",style: TextStyle(color: Colors.white ),),

                  ),
                )

              ],
            ),
          ),






        ],)

      ),

    );
  }
}


//---------- Sos page ---------------------------
class Sospage extends StatefulWidget
{
  @override
  _SospageState createState() => _SospageState();
}

class _SospageState extends State<Sospage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        appBar: AppBar(backgroundColor: Colors.deepPurple, leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),),



        body: ListView( children: <Widget>[


          //   ###########  Police   ##########
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _gettile("assets/Police.png", 'Police National', 'La Police National intervient dans le cas.......')

                  ),


                  ButtonTheme.bar( // make buttons use the appropriate styles for cards
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(

                          child: const Text('Appeler', style: TextStyle(fontSize: 20,color: Colors.deepPurpleAccent),),
                          onPressed: () { launch("tel:1548"); },
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Divider( indent: 20,endIndent: 20,),

          //   ###########  Gendarmerie   ##########
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _gettile("assets/GN.png", 'Gendarmerie Nationale', 'La Gendarmerie National intervient dans le cas.......')

                  ),


                  ButtonTheme.bar( // make buttons use the appropriate styles for cards
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('Appeler', style: TextStyle(fontSize: 20 ,color: Colors.deepPurpleAccent),),
                          onPressed: () { launch("tel:1055 ");},
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Divider( indent: 20,endIndent: 20,),

          //   ###########  Protection civile   ##########
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _gettile("assets/Protection_civile.png",'Protection Civile', 'La Protection Civile intervient dans le cas.......')

                  ),


                  ButtonTheme.bar( // make buttons use the appropriate styles for cards
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('Appeler', style: TextStyle(fontSize: 20 ,color: Colors.deepPurpleAccent),),
                          onPressed: () { launch("tel:14"); },
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Divider( indent: 20,endIndent: 20,),


          //   ###########  SAMU   ##########

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,

                children: <Widget>[

                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _gettile("assets/Amb.png", 'SAMU', 'Le Samu intervient dans le cas .......')

                  ),


                  ButtonTheme.bar( // make buttons use the appropriate styles for cards
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('Appeler ', style: TextStyle(fontSize: 20 ,color: Colors.deepPurpleAccent),),
                          onPressed: () { launch("tel:021235050");},
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],)





      ),
    );
  }

  Widget _gettile(String path , String title , String sub ) {
    var assetImage = AssetImage(path);
    var image = new Image(image: assetImage,);
    final ListTile listTile = new ListTile(title: new Text(title),
        leading: image, subtitle: new Text(sub));
    return listTile;
  }
}