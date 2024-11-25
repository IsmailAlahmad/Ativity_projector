import 'package:flutter/material.dart';

class Activity {
  final int id;
  final String title;
  final String details;
  final String? imagePath;
  final DateTime? date;
  final TimeOfDay? time;
  final double? sliderValue;
  String? rangeStart;
  String? rangeEnd;

  Activity({
    required this.id,
    required this.title,
    required this.details,
    this.imagePath,
    this.date,
    this.time,
    this.sliderValue,
    this.rangeStart,
    this.rangeEnd,
  });

  Activity copyWith({
    int? id,
    String? title,
    String? details,
    String? imagePath,
    DateTime? date,
    TimeOfDay? time,
    double? sliderValue,
    String? rangeStart,
    String? rangeEnd,
  }) {
    return Activity(
      id: id ?? this.id,
      title: title ?? this.title,
      details: details ?? this.details,
      imagePath: imagePath ?? this.imagePath,
      date: date ?? this.date,
      time: time ?? this.time,
      sliderValue: sliderValue ?? this.sliderValue,
      rangeStart: rangeStart ?? this.rangeStart,
      rangeEnd: rangeEnd ?? this.rangeEnd,
    );
  }
}


class ActivityProvider with ChangeNotifier {
  final List<Activity> _activities = [];

  List<Activity> get activities => _activities;

  void addActivity(Activity activity) {
    _activities.add(activity);
    notifyListeners();
  }
  void deleteActivity(Activity activity) {
  _activities.remove(activity);
  notifyListeners(); // لتحديث واجهة المستخدم
}


  void updateActivity(Activity updatedActivity) {
    final index = _activities.indexWhere((activity) => activity.id == updatedActivity.id);
    if (index != -1) {
      _activities[index] = updatedActivity;
      notifyListeners();
    }
  }



}
