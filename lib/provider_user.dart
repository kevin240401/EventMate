import 'package:flutter/cupertino.dart';

class AppData extends ChangeNotifier {
  String _greeting = 'guest';


  void changeGreeting(String newGreeting) {
    _greeting = newGreeting;
    notifyListeners();
  }

  String get greeting => _greeting;
}
