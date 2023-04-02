import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventmate_first/constants.dart';
import 'package:eventmate_first/event_card.dart';
import 'package:eventmate_first/event_view.dart';
import 'package:eventmate_first/main.dart';
import 'package:eventmate_first/private.dart';
import 'package:eventmate_first/provider_user.dart';
import 'package:eventmate_first/public_event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:eventmate_first/api_service.dart';
import 'package:eventmate_first/event_model.dart';
import 'package:provider/provider.dart';

class PublicPage extends StatefulWidget {

  @override
  State<PublicPage> createState() => _PublicPageState();
}

class _PublicPageState extends State<PublicPage> {
  late FirebaseAuth _auth;
  late FirebaseFirestore _firestore;
  late String loggedInUser;
  String backo = '';
  String coll = 'publics';
  List<PublicEventModel> pubEvents = [];


  @override
  void initState() {
    super.initState();
    initFirebase();

  }

  void initFirebase() async {
    await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
    _firestore =  FirebaseFirestore.instance;

    // hard code log in !!! We remove this soon.


    loggedInUser =  _auth.currentUser?.email ?? 'guest';
    print(loggedInUser);
    getBackground();
    fetchRecords();
  }

  void getBackground() async {
    final backgrounds = await _firestore
        .collection('backgrounds')
        .where("user", isEqualTo: this.loggedInUser)
        .get();
    //Here is the list of messages
    for (var background in backgrounds.docs) {
      String theBack = background.get('image');
      backo =  theBack ;
    }

  }


  fetchRecords() async{
    var records = await FirebaseFirestore.instance.collection('publics').where("sender",isEqualTo: loggedInUser).get();
    mapRecords(records);
  }

  mapRecords(QuerySnapshot <Map<String, dynamic>> records){
    var _list = records.docs.map((event) => PublicEventModel(
        id: event.id,
        name: event["name"],
        sender: event["sender"],
        date: event["date"],
        description: event["description"],
        image: event["image"],
        startDate: event["startDate"],
        note: event["note"]
    ),).toList();

    setState(() {
      pubEvents = _list;
    });
  }

  Color getColor(time){
    DateTime stanni = DateTime.parse(time);
    DateTime today = DateTime.now();
    DateTime sevenDaysLater = today.add(Duration(days: 7));
    var booli =   stanni.isBefore(sevenDaysLater);
    if(booli == true){
      return Colors.red;
    }else{
      return kLogoBlue;
    }
  }

  void deleteEvent(String info) async{
    final events = await _firestore
        .collection('publics')
        .where("name", isEqualTo: info)
        .get();

    for(var event in events.docs){
      _firestore.collection('publics').doc(event.id).delete();
    }
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    String vergl = Provider.of<AppData>(context, listen: false).greeting;
    return Scaffold(
      backgroundColor: Colors.white,
      body: vergl == 'guest'
        ? Center(
        child: Container(
        color: Colors.white,
        child: Text("Log or sign in to have access!",style: TextStyle(fontSize: 24, color: Colors.red,fontWeight: FontWeight.w700),),
    ),
    )

        : Container(

        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: NetworkImage(
                backo),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ListView.builder(
                    itemCount: pubEvents.length,
                    itemBuilder: (context, index) {
                      return EventCard(
                          color: getColor(pubEvents[index].date),
                          theTitle: pubEvents[index].name,
                          deleteFunc: () {
                             deleteEvent(pubEvents[index].name);
                             setState(() {

                             });
                             Navigator.push(
                               context,
                               MaterialPageRoute(
                                 builder: (context) {
                                   return  MyBottomBar(
                                   );
                                 },
                               ),
                             );
                          },
                          note: pubEvents[index].note,
                          theDate: pubEvents[index].startDate,
                          theChild: Image.network(pubEvents[index].image),
                          theOnTapFunc: () {
                            print(pubEvents[index].id);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                     return  EventViewScreen(
                                       name: pubEvents[index].name,
                                       img: pubEvents[index].image,
                                       descr: pubEvents[index].description,
                                       date: pubEvents[index].date,
                                       note: pubEvents[index].note,
                                       id:pubEvents[index].id,
                                       coll: coll,


                                     );
                                  },
                                ),
                              );
                          });
                    }),




        ),
      ),
    );
  }
}


/*

import 'package:flutter/material.dart';

import 'api_service.dart';
import 'event_model.dart';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // instance variables
  late List<EventModel>? _eventModel = [];

  @override
  void initState() {
    super.initState();
    _getEvent();
  }

  void _getEvent() async {
    _eventModel = (await ApiService().getEvents())!;

    // Simulate QUERY time for the real API call
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('REST API Example'),
          ),
          body: _eventModel == null || _eventModel!.isEmpty
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : ListView.builder(
              itemCount: _eventModel!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Text(_eventModel![index].performer.toString()),
                );
              })),
    );
  }
}*/

