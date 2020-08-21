import 'package:flutter/cupertino.dart';

class SettingProvider extends ChangeNotifier {
  int hour = 10;
  int words = 50;

  setHour(hour) {
    this.hour = hour;

    notifyListeners();
  }
}