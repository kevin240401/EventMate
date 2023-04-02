import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventmate_first/main.dart';
import 'package:eventmate_first/provider_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BackgroundSet extends StatefulWidget {
  @override
  State<BackgroundSet> createState() => _BackgroundSetState();
}

class _BackgroundSetState extends State<BackgroundSet> {
  late FirebaseAuth _auth;
  String url = '';
  late FirebaseFirestore _firestore;
  late String loggedInUser;
  String? messageText;
  String currentUser = '';



  @override
  void initState() {
    super.initState();
    initFirebase();

  }

  void initFirebase() async {
    await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
    //this.currentUser = Provider.of<AppData>(context).greeting;
  }

  void updateBackground() async {
    final messages = await _firestore
        .collection('backgrounds')
        .where("user", isEqualTo: Provider.of<AppData>(context, listen: false).greeting )
        .get();
    //Here is the list of messages
    for (var message in messages.docs) {
      String theback = message.get('image');
      print(theback);
      // Let's update the text by adding the work "OK " in front of it
      String newMessage = this.url;
      final data = {'image': newMessage};
      _firestore
          .collection('backgrounds')
          .doc(message.id)
          .set(data, SetOptions(merge: true));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: Stack(
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return  MyBottomBar();
                              },
                            ),
                          );
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
        ),
      ),
    );
  }
}