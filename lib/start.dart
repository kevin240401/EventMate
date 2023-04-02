import 'package:eventmate_first/login.dart';
import 'package:eventmate_first/main.dart';
import 'package:eventmate_first/provider_user.dart';
import 'package:eventmate_first/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class StartPage extends StatefulWidget {


  @override
  State<StartPage> createState() => _StartPageState();


}

class _StartPageState extends State<StartPage> {


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
              padding: const EdgeInsets.all(60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Image(image: AssetImage('assets/eventmate.png'),),
                  SizedBox(height: 30),
                  SizedBox(height: 220),
                  Container(
                    height: 40,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginScreen();
                            },
                          ),
                        );
                      },
                      child: Text('Login', style: TextStyle(fontSize: 24),),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0Xff5fcdfe).withOpacity(0.5), // Hintergrundfarbe des Buttons
                        onPrimary: Colors.white, // Textfarbe des Buttons
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0), // Radius der Ecken des Buttons
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 40,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return RegisterScreen();
                            },
                          ),
                        );
                      },
                      child: Text('Register', style: TextStyle(fontSize: 24),),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0Xff5fcdfe).withOpacity(0.5), // Hintergrundfarbe des Buttons
                        onPrimary: Colors.white, // Textfarbe des Buttons
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0), // Radius der Ecken des Buttons
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 45,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return MyBottomBar();
                            },
                          ),
                        );
                      },
                      child: Text('Enter as guest', style: TextStyle(fontSize: 24),),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0Xff5fcdfe).withOpacity(0.5), // Hintergrundfarbe des Buttons
                        onPrimary: Colors.white, // Textfarbe des Buttons
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0), // Radius der Ecken des Buttons
                        ),
                      ),
                    ),
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

