import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventmate_first/event_view.dart';
import 'package:eventmate_first/start.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'background_image_setting.dart';
import 'constants.dart';
import 'homescreen.dart';
import 'searchscreen.dart';
import 'settingscreen.dart';
import 'package:provider/provider.dart';
import 'provider_user.dart';


void main() => runApp(
  MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => AppData()),
  ],
  child: MyApp(),
),);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home:  StartPage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
    primaryColor: Colors.white,
    scaffoldBackgroundColor: kLogoBlue,
    )
    );
  }
}


class MyBottomBar extends StatefulWidget {
  const MyBottomBar({Key? key}) : super(key: key);



  @override
  State<MyBottomBar> createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  @override
  late FirebaseAuth _auth;
  late FirebaseFirestore _firestore;
  late  String loggedInUser;

  void initState() {
    super.initState();
    initFirebase();

  }

  void initFirebase() async {
    await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
    this.loggedInUser = await _auth.currentUser?.email ?? 'guest';
    print(this.loggedInUser + 'call from Main ganz oben ');
  }

  int _currentIndex = 0;
  final List<Widget> _children = const [
    HomeScreen(),
    SearchScreen(),
    SettingsScreen()
  ];

  void onTappedBar(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar:Container(
        decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/loginbild.jpg'),
        fit: BoxFit.cover,
           alignment: Alignment.center,
         ),
        ),
    child:BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,

        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.white38),
              label: 'Home'),

         // BottomNavigationBarItem(
          //    icon: Icon(Icons.chat, color: Colors.white38),
          //    label: 'Chats'),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.white38),
              label: 'Login'),

          BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: Colors.white38),
              label: 'Settings')


        ],


      ),
      ),
    );
  }
}


