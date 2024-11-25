import 'package:flutter/material.dart';
import 'package:mt/constant.dart';
import 'package:mt/model/activity.dart';
import 'package:mt/widget/date_picker.dart';
import 'package:mt/widget/image_picker.dart';
import 'package:mt/widget/slider.dart';
import 'package:mt/widget/time_picker.dart';
import 'package:provider/provider.dart';

class NewActivityPage extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? imagePath; // لتخزين مسار الصورة
    DateTime? selectedDate; // لتخزين التاريخ المختار
    TimeOfDay? selectedTime; // لتخزين الوقت المختار
    String? rangeStart; // بداية الفترة الزمنية
    String? rangeEnd; // نهاية الفترة الزمنية

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [gc, Colors.lightGreen],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Center(
          child: Text(
            'إضافة نشاط جديد',
            style: TextStyle(
              fontFamily: 'alfont',
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: gc),
                ),
                child: TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.edit,
                      color: gc,
                      size: 30,
                    ),
                    labelText: 'عنوان النشاط',
                    labelStyle: TextStyle(fontFamily: 'alfont'),
                    border: InputBorder.none,
                  ),
                  cursorColor: gc,
                ),
              ),
              SizedBox(height: 20),

              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: gc),
                ),
                child: TextFormField(
                  controller: detailsController,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.details,
                      color: gc,
                      size: 30,
                    ),
                    labelText: 'تفاصيل النشاط',
                    labelStyle: TextStyle(fontFamily: 'alfont'),
                    border: InputBorder.none,
                  ),
                  cursorColor: gc,
                ),
              ),
              SizedBox(height: 20),

              // اختيار الصورة
              ImagePickerSection(
                onImagePicked: (path) {
                  imagePath = path;
                },
              ),
              SizedBox(height: 20),

              // اختيار التاريخ
              DatePickerSection(
                onDatePicked: (date) {
                  selectedDate = date;
                },
              ),
              SizedBox(height: 20),

              // اختيار الوقت
              TimePickerSection(
                onTimePicked: (time) {
                  selectedTime = time;
                },
              ),
              SizedBox(height: 30),

              // اختيار مستوى النشاط
              SliderSection(),

              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: gc),
                ),
                child: TextFormField(
                  cursorColor: gc,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.start_outlined,
                      color: gc,
                      size: 30,
                    ),
                    labelText: 'بداية الفترة الزمنية',
                    labelStyle: TextStyle(fontFamily: 'alfont'),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    rangeStart = value;
                  },
                ),
              ),

              SizedBox(height: 10),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: gc),
                ),
                child: TextFormField(
                  cursorColor: gc,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.closed_caption_disabled_rounded,
                      color: gc,
                      size: 30,
                    ),
                    labelText: 'نهاية الفترة الزمنية',
                    labelStyle: TextStyle(fontFamily: 'alfont'),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    rangeEnd = value;
                  },
                ),
              ),
              SizedBox(height: 30),

              // زر الإضافة
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: gc,
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                ),
                onPressed: () {
                  if (titleController.text.isEmpty ||
                      detailsController.text.isEmpty ||
                      imagePath == null ||
                      selectedDate == null ||
                      selectedTime == null ||
                      rangeStart == null ||
                      rangeEnd == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red.shade400,
                        content: Row(
                          children: [
                            Icon(
                              Icons.error,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'يرجى ملء جميع الحقول',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  fontFamily: "alfont",
                                  fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    );
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: gc,
                      content: Row(
                        children: [
                          Icon(
                            Icons.thumb_up,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '   تم تعبئة جميع البيانات بنجاح',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontFamily: "alfont",
                                fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  );
                  // إضافة النشاط باستخدام Provider
                  Provider.of<ActivityProvider>(context, listen: false)
                      .addActivity(
                    Activity(
                      id: 1,
                      title: titleController.text,
                      details: detailsController.text,
                      imagePath: imagePath,
                      date: selectedDate,
                      time: selectedTime,
                      sliderValue:
                          null, // يمكن تعديل هذا إذا كنت تريد قيمة افتراضية
                      rangeStart: rangeStart,
                      rangeEnd: rangeEnd,
                    ),
                  );

                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  } // العودة إلى الصفحة الرئيسية بعد الإضافة
                },
                child: Text(
                  'إضافة النشاط',
                  style: TextStyle(
                    fontFamily: 'alfont',
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
