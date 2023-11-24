import 'package:flutter/material.dart';

class DrawerStatusController extends ChangeNotifier {
  static DrawerStatusController instance = DrawerStatusController();

  bool drawnerOpened = false;

  changeDrawnerStatus(bool newState) {
    drawnerOpened = newState;
    notifyListeners();
  }
}
