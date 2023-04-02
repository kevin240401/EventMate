import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventmate_first/constants.dart';
import 'package:eventmate_first/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'main.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late FirebaseAuth _auth;
  late FirebaseFirestore _firestore;
  String email = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    initFirebase();
  }

  void initFirebase() async {
    await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
    _firestore =  FirebaseFirestore.instance;
  }

  void createBackgroundDoc(email) async{

    Map<String, dynamic> data = {
      'user': email,
      'image': ''
    };
    // Send data to the collection
    _firestore.collection('backgrounds').add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(

                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Email Adress',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.indigo,
                        ),
                        onPressed: () async {

                          //print("create account with $email , $password");
                          final newUser = await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);

                          createBackgroundDoc(email);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return LoginScreen();
                              },
                            ),
                          );
                        },
                        child: Text('Register',style: TextStyle(fontSize: 22),),
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