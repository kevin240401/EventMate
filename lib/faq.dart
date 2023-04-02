import 'package:eventmate_first/provider_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key}) : super(key: key);

// this page has 2 hard coded Tables and no more additional logic

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: kLogoBlue,
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
        toolbarHeight: 70,
        backgroundColor: kLogoBlue,
        title:  Text('Frequently Asked Questions', style: TextStyle(fontSize: 24),),
        centerTitle: true,
      ),

      body: Center(
        child: Container(

          width: 280,
          child: Column(
            children: [
              SizedBox(height: 20),

              Text('How can I add an event to my Homepage?', style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white,
              ),),

              SizedBox(height: 5),

              Text('When you found an event you would like to follow you can click on the heart, which is going to ad the event on your Homepage',
                style:TextStyle(color: Colors.white, fontSize: 16)),

              SizedBox(height: 20),

              Text('How can i delete an event?', style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white
              ),),

              SizedBox(height: 5),
              Text('When you are on the Homepage there is a small trashcan at the bottom of the Card. Click the trashcan and this event willd disappear',
                  style:TextStyle(color: Colors.white, fontSize: 16)),

              SizedBox(height: 20),

              Text('How can I create a public Event?', style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white
              ),),

              SizedBox(height: 5),

              Text('To create a public event you have to be a verrified Eventmanger working for an Eventmanaging Company',
                  style:TextStyle(color: Colors.white, fontSize: 16)),

            ],
          ),


        ),
      ),
    );


  }
}