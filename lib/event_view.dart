import 'package:flutter/material.dart';
import 'constants.dart';
import 'infobox.dart';


class EventViewScreen extends StatelessWidget {


  final String name;
  final String descr;
  final String img;
  final String date;
  final String note;
  final String id;
  final String coll;

  const EventViewScreen({
    required this.name,
    required this.descr,
    required this.img,
    required this.date,
    required this.note,
    required this.id,
    required this.coll,
  });

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
        backgroundColor: kBody,
        title: const Text('Event here'),
        centerTitle: true,
      ),

      body: Container(
        color: Colors.white,
        child: infoBox(
          name: name,
          date: date,
          info: descr,
          thePic: img,
          note: note,
          id: id,
          private: coll

        ),
      ),

    );


  }
}