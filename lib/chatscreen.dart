import 'package:flutter/material.dart';
import 'constants.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

// this page has 2 hard coded Tables and no more additional logic

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: kBarColor,
        title: const Text('Chat'),
        centerTitle: true,
      ),

    );


  }
}