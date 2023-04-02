import 'package:eventmate_first/constants.dart';
import 'package:flutter/material.dart';

// this class defines a currency box
// Color, Widget and an onpressed function are required

class SettingsBox extends StatelessWidget {
  SettingsBox({required this.text,  required this.theChild, this.theOnTapFunc});

  // instance variable
  final String text;
  final Widget theChild;
  final VoidCallback? theOnTapFunc; // function as a variable..nullable

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: theOnTapFunc,
      child:  Column(
        children: [
          Container(
            height: 80,
            width: 390,

            decoration: BoxDecoration(
              color: kLogoBlue,
              border: Border.all( color: Colors.black)
            ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                  child: theChild),

              Expanded(
                  flex: 8,
                  child: Text(text, style: TextStyle(fontSize: 26),) ),


            ],
          ),
          ),
          SizedBox(height: 2,)
        ],
      ),
    );
  }
}