import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  // make a private variable
  int _count = 0;

  int get count {
    return _count;
  }

  void increment() {
    _count++;
    notifyListeners();
  }
}
