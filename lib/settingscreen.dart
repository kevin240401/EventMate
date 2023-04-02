import 'package:eventmate_first/background_image_setting.dart';
import 'package:eventmate_first/faq.dart';
import 'package:eventmate_first/settingsbox.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

// this page has 2 hard coded Tables and no more additional logic

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading:Text(''),
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
        toolbarHeight: 70,
        backgroundColor: kBody,
        title: const Text('Settings', style: TextStyle(fontSize: 28),),
        centerTitle: true,
      ),

      body: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),

              SettingsBox(
                text: 'Battery',
                theChild: Icon(Icons.battery_1_bar),
                  theOnTapFunc: (){

                  }
              ),
              SettingsBox(
                text: 'Background Image',
                theChild: Icon(Icons.image),
                theOnTapFunc: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return BackgroundSet();
                      },
                    ),
                  );
                },
              ),
              SettingsBox(
                text: 'Data Security',
                theChild: Icon(Icons.security),
                theOnTapFunc: (){

                },
              ),
              SettingsBox(
                text: 'Version Information',
                theChild: Icon(Icons.info),
                theOnTapFunc: (){

                },
              ),
              SettingsBox(
                text: 'FAQ',
                theChild: Icon(Icons.help),
                  theOnTapFunc: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return  FAQScreen();
                        },
                      ),
                    );
                  }
              )
            ],
          ),
        ),
      ),
    );


  }
}