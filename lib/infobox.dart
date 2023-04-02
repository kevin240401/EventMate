import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventmate_first/constants.dart';
import 'package:eventmate_first/main.dart';
import 'package:eventmate_first/provider_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class infoBox extends StatefulWidget {

  infoBox({required this.name, required this.date,required this.info , required this.thePic, required this.note,required this.id, required this.private});

  // instance variable
  final String name;
  final String date;
  final String info;
  final String thePic;
  final String note;
  final String id;
  final String private;



  @override
  State<infoBox> createState() => _infoBoxState();
}


class _infoBoxState extends State<infoBox> {
  late TextEditingController _controller;
  late FirebaseFirestore _firestore;
  late String loggedInUser;








  void initFirebase() async {
    await Firebase.initializeApp();

    _firestore = FirebaseFirestore.instance;
    //this.currentUser = Provider.of<AppData>(context).greeting;
  }

  @override
  void initState() {
    super.initState();
    initFirebase();
    _controller = TextEditingController(text: widget.note);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void safeNote() async{

      final messages = await _firestore
          .collection(widget.private)
          .where( "description", isEqualTo: widget.info  )
          .get();

      print(messages);
      //Here is the list of messages
      for (var message in messages.docs) {
        print(message);
        String theback = message.get('note');
        print(theback);
        // Let's update the text by adding the work "OK " in front of it
        String newMessage = _controller.text;
        final data = {'note': newMessage};
        _firestore
            .collection(widget.private)
            .doc(message.id)
            .set(data, SetOptions(merge: true));
      }
    }



// function as a variable..nullable
  @override
  Widget build(BuildContext context) {

    return GestureDetector( //not relevant, can be deleted
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),

              Container(

                  width: 340,
                  decoration: BoxDecoration(
                      color: kLogoBlue,
                      borderRadius: BorderRadius.circular(20)
                  ),
                child: Column(

                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                        height: 180,
                        child: Image.network(widget.thePic)
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    Text(widget.name, style: TextStyle( fontSize: 24, fontWeight: FontWeight.w600),),

                    SizedBox(
                      height: 20,
                    ),
                    FittedBox(
                      child: Container(

                        width: 280,

                        child: Table(
                          columnWidths: {
                            0: FlexColumnWidth(1),
                            1: FlexColumnWidth(2),
                          },
                          children: [
                            _buildTableRow("Date", widget.date),
                            _buildTableRow("Detail", widget.info),
                            _buildTableRow("Note", ''),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Container(
                      width: 300,
                      height: 120,
                      padding: EdgeInsets.all(16.0),

                      decoration: BoxDecoration(

                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: TextField(
                        controller: _controller,
                        maxLines: 3,

                        decoration: InputDecoration(
                          focusedBorder:OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          hintText: 'Enter your notes',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors
                            .orangeAccent, // setzt die Hintergrundfarbe auf grün
                      ),
                      onPressed: () {

                        safeNote();
                        setState(() {

                        });
                       Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return  MyBottomBar();
                            },
                          ),
                        );

                      },
                      child: Text('Safe Changings ', style: TextStyle(
                          fontSize: 24
                      ),),
                    ),
                    SizedBox(height: 10),


                    /*
                    Text('View place on map:', style: TextStyle(fontSize: 20),),
                    Container(
                      height: 150,
                      width: 280,

                      child: Image.network('https://i.stack.imgur.com/b6KTX.png'),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Text('How is the weather going to be:', style: TextStyle(fontSize: 20),),

                    SizedBox(
                      height: 20,
                    ),


                    Container(
                      width: 280,
                        child: Image.network('https://images.ctfassets.net/4ivszygz9914/564a3dbe-9d51-4c03-a210-c3a385bfedd4/e4a97398a3cd0388fc86d4199a902595/954f5198-a143-4004-9f3a-14338df11fed.png?fm=webp')
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Text('Dont forget your rainsuites and passports!', style: TextStyle(fontStyle: FontStyle.italic),),
                    SizedBox(
                      height: 20,
                    ),*/



                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(String title, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "$title:",
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(value,style: TextStyle(fontSize: 20),),
        ),
      ],
    );
  }
}