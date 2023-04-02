import 'package:eventmate_first/constants.dart';
import 'package:flutter/material.dart';

// this class defines a currency box
// Color, Widget and an onpressed function are required

class EventCard extends StatelessWidget {
  EventCard({required this.theTitle, required this.color,  required this.theDate, required this.theChild, this.theOnTapFunc, this.deleteFunc, required this.note});

  // instance variable
  final String theTitle;
  final Color color;
  final String theDate;
  final Widget theChild;
  final String note;
  final VoidCallback? theOnTapFunc; // function as a variable..nullable
  final VoidCallback? deleteFunc;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: theOnTapFunc,
      onDoubleTap: deleteFunc,

      child: Container(
          height: 160,
          width: 320,
          margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20)
          ),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: SizedBox(
                      height: 120,
                      width: 120,
                      child: theChild
                  )
              ),

              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),

                     Container(


                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          padding: EdgeInsets.fromLTRB(4, 5, 10, 5),

                          child: Text(theTitle +' '+ theDate,maxLines: 2,overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),)
                      ),


                    /*FittedBox(
                      child: Container(
                        color: Colors.green,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          padding: EdgeInsets.fromLTRB(4, 5, 10, 5),

                          child: Text(theDate,maxLines: 2, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),)
                      ),
                    ),*/

                    FittedBox(
                      child: Container(


                          child: Text('Note: ' + note,maxLines:1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20),)
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [



                               IconButton(onPressed: deleteFunc,



                                   icon: Icon(Icons.delete,size: 30,)
                               ),


                      ],
                    )
                  ],

                ),
              )
            ],
          )



      ),
    );
  }
}