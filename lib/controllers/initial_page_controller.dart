import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialPageController extends ChangeNotifier {
  late bool headerAndFooterIsActive;

  static const _keyHeaderAndFooterActive = 'header_and_footer_active';

  InitialPageController() {
    headerAndFooterIsActive = true;
    changeIfHeaderAndFooterIsActive();
  }

  changeIfHeaderAndFooterIsActive() async {
    bool isActive = await getHeaderAndFooterIsActive();

    headerAndFooterIsActive = isActive;
    notifyListeners();
  }

  closeHeaderAndFooter() {
    setHeaderAndFooterIsActive(false);

    headerAndFooterIsActive = false;
    notifyListeners();
  }

  openHeaderAndFooter() {
    setHeaderAndFooterIsActive(true);

    headerAndFooterIsActive = true;
    notifyListeners();
  }

  Future<void> setHeaderAndFooterIsActive(bool isActive) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_keyHeaderAndFooterActive, isActive);
  }

  Future<bool> getHeaderAndFooterIsActive() async {
    final prefs = await SharedPreferences.getInstance();
    bool? isActive = prefs.getBool(_keyHeaderAndFooterActive);

    if (isActive != null) {
      return isActive;
    } else {
      setHeaderAndFooterIsActive(true);
      return true;
    }
  }
}
