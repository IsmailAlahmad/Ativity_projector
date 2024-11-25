import 'package:flutter/material.dart';

class PageIndexProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void updateIndex(int newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }
    TimeOfDay? _selectedTime;

  TimeOfDay? get selectedTime => _selectedTime;

  void updateTime(TimeOfDay? time) {
    _selectedTime = time;
    notifyListeners();
  }
}
