import 'package:eventmate_first/event_card.dart';
import 'package:eventmate_first/event_view.dart';
import 'package:eventmate_first/provider_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'addscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'private_event_model.dart';


class PrivatePage extends StatefulWidget {

  @override
  State<PrivatePage> createState() => _PrivatePageState();
}

class _PrivatePageState extends State<PrivatePage> {
  late FirebaseAuth _auth;
  late FirebaseFirestore _firestore;
  late String loggedInUser;
  String backo ='';
  String coll = 'events';
  List<PrivateEventModel> privEvents = [];

  
  
  @override
  void initState() {
    super.initState();
    initFirebase();

  }

  fetchRecords() async{
    var records = await FirebaseFirestore.instance.collection('events').where("sender",isEqualTo: loggedInUser).get();
    mapRecords(records);
  }

  mapRecords(QuerySnapshot <Map<String, dynamic>> records){
    var _list = records.docs.map((event) => PrivateEventModel(
    id: event.id,
    name: event["name"],
    sender: event["sender"],
    date: event["date"],
    description: event["description"],
    image: event["image"],
    note: event["note"]
    ),).toList();

    setState(() {
      privEvents = _list;
    });
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
    setState(() {

    });
  }

  /*Future<BackgroundModel> getBackground() async{
  final snapshot = await _firestore.collection('backgrounds').where("name", isEqualTo: loggedInUser).get();
  final userData= snapshot.docs.map((e) => BackgroundModel.fromSnapshot(e)).single;
  return userData;
  }*/

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

  void deleteEvent(String info) async{
    final events = await _firestore
        .collection('events')
        .where("name", isEqualTo: info)
        .get();

    for(var event in events.docs){
      _firestore.collection('events').doc(event.id).delete();
    }
  }
  
  Color getColor(time){
    DateTime stanni = DateTime.parse(time);
    DateTime today = DateTime.now();
    DateTime sevenDaysLater = today.add(Duration(days: 7));
    var booli =   stanni.isBefore(sevenDaysLater);
    if(booli == true){
      return Colors.red;
    }else{
      return Colors.grey;
    }
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
               child:
                   Text("Log or sign in to have access!",style: TextStyle(fontSize: 24, color: Colors.red,fontWeight: FontWeight.w700),),

            ),
          )

          : Container(

        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: NetworkImage(
                this.backo),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [

                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 45,
                  width: 320,

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors
                          .orangeAccent, // setzt die Hintergrundfarbe auf grün
                    ),
                    onPressed: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const ChatScreen();
                          },
                        ),
                      );
                    },
                    child: Text('+ Create a new Event ', style: TextStyle(
                        fontSize: 24
                    ),),
                  ),
                ),

                Container(
                  height: 600,
                  width: 360,

                  child: ListView.builder(
                      itemCount: privEvents.length,
                      itemBuilder: (context, index) {
                        return EventCard(
                            color: getColor(privEvents[index].date),
                            theTitle: privEvents[index].name,
                            deleteFunc: () {
                              print('Gecalled');
                              deleteEvent(privEvents[index].name);
                              setState(() {

                              });
                            },
                            note: privEvents[index].note ,
                            theDate: privEvents[index].date,
                            theChild: Image.network(privEvents[index].image),
                            theOnTapFunc: () {
                              print('Feld gedrückt');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                     return  EventViewScreen(
                                         name: privEvents[index].name,
                                         descr: privEvents[index].description,
                                         img: privEvents[index].image,
                                         date: privEvents[index].date,
                                         note: privEvents[index].note,
                                         id: privEvents[index].id,
                                         coll: coll
                                     );
                                  },
                                ),
                              );
                            });
                      }),
                )


              ],
            ),
          ),
        ),
      ),

    );


  }
}
