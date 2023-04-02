import 'package:eventmate_first/homescreen.dart';
import 'package:eventmate_first/main.dart';
import 'package:eventmate_first/provider_user.dart';
import 'package:eventmate_first/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late FirebaseAuth _auth;
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
                        'Sign In',
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.indigo,
                        ),
                        onPressed: () async {
                          //print("login with $email , $password");
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                            if (user != null) {
                              Provider.of<AppData>(context, listen: false)
                                  .changeGreeting(email);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return  MyBottomBar();
                                  },
                                ),
                              );
                            } else {
                              print("Login failed");
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Text('Login',style: TextStyle(fontSize: 22),),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('You have no Account yet?', style: TextStyle(fontSize: 18, ),),
                          TextButton(
                            child: const Text('Sign up!',style: TextStyle(color: Colors.white,fontSize: 20),),

                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return  RegisterScreen();
                                  },
                                ),
                              );
                              print('register');
                            },
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