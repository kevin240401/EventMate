import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventmate_first/event_card.dart';
import 'package:eventmate_first/event_model.dart';
import 'package:eventmate_first/homescreen.dart';
import 'package:eventmate_first/main.dart';
import 'package:eventmate_first/search_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'api_service.dart';


class SearchScreen extends StatefulWidget {

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? currentUser;
  late FirebaseAuth _auth;
  late FirebaseFirestore _firestore;
  late String loggedInUser;
  String searchWord = '';
  String perf= '';
  String img = '';
  String descr = '';
  String loc = '';
  String startD= '';
  bool anzeige= false;

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


  final meinController = TextEditingController();

  @override
  void dispose() {
    meinController.dispose(); // Controller freigeben, um Speicherlecks zu vermeiden
    super.dispose();
  }

  void addPublic(date, name, description, image,) async{
    print(loggedInUser);
    Map<String, dynamic> data = {
      'date': date ?? '',
      'name': name?? '',
      'description': description??'',
      'image': image??'',
      'startDate': date??'',
      'note': '',
      'sender': loggedInUser,
    };
    // Send data to the collection
    _firestore.collection('publics').add(data);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return  MyBottomBar();
          },
        ),
      );
  }


// this page has 2 hard coded Tables and no more additional logic
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
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
        leading: Text(''),
        backgroundColor: Colors.white,
        title: const Text('Search for events!', style: TextStyle(fontSize: 24),),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: TextField(
                        controller: meinController,
                        onTap: (){
                          setState(() {
                            anzeige = false;
                          });
                        },// Controller dem Textfeld zuweisen
                        onChanged: (text) { // onChanged-Event abonnieren und den Text in der Variable speichern
                          setState(() {
                            searchWord = text;
                          });
                        },
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          fillColor: Colors.white,

                          filled: true,
                          hintText: 'Enter the name of your Event',
                          hintStyle: TextStyle(color: kExtra3Color, fontSize: 16),
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                          )
                        ),

                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: IconButton(
                          icon: Icon(Icons.search), // Das Icon definieren
                          onPressed: (){
                            setState(() {
                              anzeige = true;
                            });
                            Navigator.pushNamed(context, '/api_page');
                          }, // Die Funktion zuweisen
                        ),)
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
      body: anzeige
          ? _buildBody()
          : Center(child: Text('search for something...',style: TextStyle(color: Colors.blue,fontSize: 26),)),
    );
  }




  Widget _buildBody() {
    return FutureBuilder<List<Data>>(
      future: APIService(name: searchWord).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available!'));
        }
        final data = snapshot.data!;

        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return SearchCard(theTitle: data[index].performerName,
                color: kLogoBlue,
                theDate: data[index].startDate,
                theChild: Image.network(data[index].image),
                addFunc: (){
                  addPublic(
                      data[index].startDate,
                      data[index].performerName,
                      data[index].description,
                      data[index].image,
                  );
                }

            );
          },
        );
      },
    );
  }
}