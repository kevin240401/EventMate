import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventmate_first/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late FirebaseAuth _auth;
  late FirebaseFirestore _firestore;
  late String loggedInUser;
  String? dateText;
  String? nameText;
  String? descrText;
  String? imgText;
  String noteText = '';

  TextEditingController _date = TextEditingController();

  @override
  void initState() {
    super.initState();
    initFirebase();
  }

  void initFirebase() async {
    await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;

    // hard code log in !!! We remove this soon.


    loggedInUser = _auth.currentUser?.email ?? 'none';
    print(loggedInUser);
  }

  void getMessages() async {
    final messages = await _firestore
        .collection('events')
         .where("sender", isEqualTo: 'tester@gmail.com')
        .get();
    //Here is the list of messages
    for (var message in messages.docs) {
      String aMessage = message.id +
          ' : ' +
          message.get('sender') +
          ' : ' +
          message.get('text');
      print(aMessage);

      // Let's update the text by adding the work "OK " in front of it
      String newMessage = "OK " + message.get('text');
      final data = {'text': newMessage};
      _firestore
          .collection('messages')
          .doc(message.id)
          .set(data, SetOptions(merge: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
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
        backgroundColor: kBody,
        title: const Text('Create a new Event',style: TextStyle(fontSize: 26),),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/loginbild.jpg', // Pfad zum Hintergrundbild
            fit: BoxFit.cover,
            width: double.infinity, // Die Breite des Bildes wird auf die gesamte Breite des Bildschirms gesetzt
            height: double.infinity,// Das Bild wird auf die gesamte Bildschirmgröße skaliert
          ),
          Container(
            color: Colors.blue.withOpacity(0.5), // Farbe mit einer Transparenz von 50%
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),

                Text('Enter the Event Information'
                  ,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700),),

                SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value){
                      nameText = value;
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Eventname',
                        hintStyle: TextStyle(
                            color: kExtra3Color, fontSize: 16),
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _date,

                    onTap: () async{
                      DateTime? pickdate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2023),
                          lastDate: DateTime(2080));

                      if (pickdate!= null){
                        setState(() {
                          _date.text = DateFormat('yyyy-MM-dd').format(pickdate) ;
                          this.dateText = _date.text;
                        });
                      }


                    },

                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: ' Starting Date',
                        hintStyle: TextStyle(
                            color: kExtra3Color, fontSize: 16),
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value){
                      descrText = value;
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Description',
                        hintStyle: TextStyle(
                            color: kExtra3Color, fontSize: 16),
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value){
                      imgText = value;
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Image URL',
                        hintStyle: TextStyle(
                            color: kExtra3Color, fontSize: 16),
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 50,
                  width: 160,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors
                          .orangeAccent, // setzt die Hintergrundfarbe auf grün
                    ),
                    child: Text('Create Event', style: TextStyle(fontSize: 22),),
                    onPressed: () {
                      // First create a map
                      print(loggedInUser);
                      Map<String, dynamic> data = {
                        'date': dateText ?? '',
                        'name': nameText?? '',
                        'description': descrText??'',
                        'image': imgText??'',
                        'sender': loggedInUser,
                        'note': noteText
                      };
                      // Send data to the collection
                      _firestore.collection('events').add(data);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return  MyBottomBar();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }
}








/* Stack(
          children: [
            Image.asset(
              'assets/loginbild.jpg', // Pfad zum Hintergrundbild
              fit: BoxFit.cover,
              width: double.infinity, // Die Breite des Bildes wird auf die gesamte Breite des Bildschirms gesetzt
              height: double.infinity,// Das Bild wird auf die gesamte Bildschirmgröße skaliert
            ),
            Container(
              color: Colors.blue.withOpacity(0.5), // Farbe mit einer Transparenz von 50%
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Put your Image URL here...',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(

                    onChanged: (value) {
                      url = value;

                    },
                    decoration: InputDecoration(
                      hintText: 'Image URL',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8.0),

                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.indigo,
                        ),
                        onPressed: ()  {
                          updateBackground();
                        },
                        child: Text('Update',style: TextStyle(fontSize: 22),),
                      ),
                      SizedBox(width: 10,),
                      Text('or',style: TextStyle(fontSize: 24),),
                      SizedBox(width: 10,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                        onPressed: ()  {
                          Navigator.pop(context);
                        },
                        child: Text('Get back',style: TextStyle(fontSize: 22,color: Colors.indigo),),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ],
        ),*/