import 'package:flutter/material.dart';

class NavBarStateModel extends ChangeNotifier {
  int currentIndex = 0;

  void updateIndex({required int index}) {
    currentIndex = index;
    notifyListeners();
  }
}
