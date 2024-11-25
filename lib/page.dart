import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mt/constant.dart';
import 'package:mt/model/activity.dart';

class ActivityDetailsPage extends StatelessWidget {
  final Activity activity;
  ActivityDetailsPage({required this.activity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // لون سهم الرجوع
        ),
        backgroundColor: gc,
        title: Center(
          child: Text(
            activity.title, // استخدام activity.title هنا
            style: TextStyle(
                fontFamily: 'alfont',
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // عرض الصورة
              if (activity.imagePath != null)
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.green, width: 2),
                  ),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: FileImage(File(activity.imagePath!)),
                  ),
                ),
              SizedBox(height: 20),

              // عرض التفاصيل
              Text(
                activity.details, // استخدام activity.details هنا
                style: TextStyle(
                  fontFamily: 'alfont',
                  fontSize: 18,
                  color: gc,
                ),
              ),
              SizedBox(height: 20),

              // عرض التاريخ
              if (activity.date != null)
                Text(
                  'التاريخ: ${DateFormat('yyyy-MM-dd').format(activity.date!)}',
                  style: TextStyle(
                    fontFamily: 'alfont',
                    fontSize: 17,
                    color: gc,
                  ),
                ),
              SizedBox(height: 20),

              // عرض الوقت
              if (activity.time != null)
                Text(
                  'الوقت: ${activity.time!.format(context)}',
                  style: TextStyle(
                    fontFamily: 'alfont',
                    fontSize: 17,
                    color: gc,
                  ),
                ),
              SizedBox(height: 20),

              // عرض مستوى النشاط
              if (activity.sliderValue != null)
                Text(
                  'مستوى النشاط: ${activity.sliderValue!.toStringAsFixed(1)}',
                  style: TextStyle(
                    fontFamily: 'alfont',
                    fontSize: 17,
                    color: gc,
                  ),
                ),
              SizedBox(height: 20),

              // عرض الفترة الزمنية
              if (activity.rangeStart != null && activity.rangeEnd != null)
                Text(
                  'الفترة الزمنية: من ${activity.rangeStart} إلى ${activity.rangeEnd}',
                  style: TextStyle(
                    fontFamily: 'alfont',
                    fontSize: 17,
                    color: gc,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
