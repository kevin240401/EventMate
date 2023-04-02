import 'package:eventmate_first/constants.dart';
import 'package:flutter/material.dart';

// this class defines a currency box
// Color, Widget and an onpressed function are required

class SearchCard extends StatelessWidget {
  SearchCard({required this.theTitle, required this.color,  required this.theDate, required this.theChild, this.theOnTapFunc, this.addFunc});

  // instance variable
  final String theTitle;
  final Color color;
  final String theDate;
  final Widget theChild;
  final VoidCallback? theOnTapFunc; // function as a variable..nullable
  final VoidCallback? addFunc;

  @override
  Widget build(BuildContext context) {
    return  Container(
          height: 160,
          width: 350,
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

                    FittedBox(
                      child: Container(

                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          padding: EdgeInsets.fromLTRB(4, 5, 10, 5),

                          child: Text(theTitle, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),)
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    FittedBox(
                      child: Container(

                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          padding: EdgeInsets.fromLTRB(4, 5, 10, 5),

                          child: Text(theDate, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),)
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(),
                        SizedBox(width: 40,),

                        Container(
                            height: 44,

                            child: IconButton(onPressed: addFunc,


                                icon: Icon(Icons.add,size: 30,))
                        ),

                      ],
                    )
                  ],

                ),
              )
            ],
          )



      );

  }
}