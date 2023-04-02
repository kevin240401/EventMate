import 'package:eventmate_first/private.dart';
import 'package:eventmate_first/public.dart';
import 'package:eventmate_first/start.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FirebaseAuth _auth;
  late FirebaseFirestore _firestore;
  late  String loggedInUser;
  bool homeboddy = false;


@override
  void initState() {
    super.initState();
    initFirebase();
  }

  void initFirebase() async {
    await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
    this.loggedInUser = await _auth.currentUser?.email ?? 'guest';
  }






  String get currentUser => loggedInUser;

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Stack(
            children: [
              Image.asset(
                'assets/loginbild.jpg', // Pfad zum Hintergrundbild
                fit: BoxFit.cover,
                width: double.infinity, // Die Breite des Bildes wird auf die gesamte Breite des Bildschirms gesetzt
                height: double.infinity,// Das Bild wird auf die gesamte Bildschirmgröße skaliert
                alignment: Alignment.topCenter,
              ),
              Container(
                color: Colors.blue.withOpacity(0.5), // Farbe mit einer Transparenz von 50%
              ),
            ],
          ),
          leading: Text(''),
          toolbarHeight: 66,
          backgroundColor: kBody,
          title: Text('EventMate - Home',style: TextStyle(fontSize: 27, fontWeight: FontWeight.w700),),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: (){
                  _auth.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return StartPage();
                      },
                    ),
                  );
                }
                , icon: Icon(Icons.logout))
          ],
        ),
        body: Column(
          children: [
            TabBar(
                unselectedLabelStyle: TextStyle(fontSize: 14) ,
                unselectedLabelColor: Colors.white,
                labelStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w900,color: Colors.black) ,
                indicatorColor: Colors.white,

                tabs: [
                  Tab(
                    text: 'Public',

                  ),
                  Tab(
                    text: 'Private',
                  ),
                ]
            ),
            Expanded(
                child: TabBarView(children: [

                  PublicPage(),

                  PrivatePage()
                ],
                )
            ),

            /*ElevatedButton(onPressed: (){

              print(this.loggedInUser);
             }, child: Text('hallo'),
            ),*/
          ],
        ),
      ),
    );


  }

}

