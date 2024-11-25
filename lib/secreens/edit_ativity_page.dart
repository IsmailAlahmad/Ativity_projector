import 'package:flutter/material.dart';
import 'package:mt/constant.dart';
import 'package:mt/model/activity.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart'; // إضافة مكتبة اختيار الصور
import 'dart:io';

class EditActivityPage extends StatefulWidget {
  final Activity activity;

  EditActivityPage({required this.activity});

  @override
  _EditActivityPageState createState() => _EditActivityPageState();
}

class _EditActivityPageState extends State<EditActivityPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  String? selectedImagePath;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    titleController.text = widget.activity.title;
    detailsController.text = widget.activity.details;
    selectedImagePath = widget.activity.imagePath;
    selectedDate = widget.activity.date;
    selectedTime = widget.activity.time;
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImagePath = pickedFile.path;
      });
    }
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // لون سهم الرجوع
        ),
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
            'تعديل نشاط',
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
                    icon: Icon(Icons.edit, color: gc),
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
                    icon: Icon(Icons.details, color: gc),
                    labelText: 'تفاصيل النشاط',
                    labelStyle: TextStyle(fontFamily: 'alfont'),
                    border: InputBorder.none,
                  ),
                  cursorColor: gc,
                ),
              ),
              SizedBox(height: 20),
              selectedImagePath == null
                  ? CircleAvatar(
                      radius: 50, // تحديد نصف قطر الدائرة
                      backgroundColor: Colors
                          .grey[200], // تحديد لون الخلفية عند عدم وجود صورة
                      child: Icon(Icons.image,
                          size: 50,
                          color: Colors
                              .grey), // عرض أيقونة بدلاً من الصورة عند عدم وجودها
                    )
                  : Container(
                      width: 180,
                      height: 189,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.green, width: 2),
                      ),
                      child: CircleAvatar(
                        radius: 100, // تحديد نصف قطر الدائرة
                        backgroundImage: FileImage(File(
                            selectedImagePath!)), // تحميل الصورة من المسار المحدد
                      ),
                    ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'التاريخ: ${selectedDate?.toLocal().toString().split(' ')[0] ?? 'لم يتم تحديده'}',
                    style: TextStyle(
                        fontSize: 15, color: gc, fontFamily: 'alfont'),
                  ),
                  IconButton(
                    icon: Icon(
                      size: 30,
                      Icons.calendar_today,
                      color: gc,
                    ),
                    onPressed: () => _pickDate(context),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'الوقت: ${selectedTime?.format(context) ?? 'لم يتم تحديده'}',
                    style: TextStyle(
                        fontSize: 15, color: gc, fontFamily: 'alfont'),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.access_time,
                      size: 30,
                      color: gc,
                    ),
                    onPressed: () => _pickTime(context),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: gc,
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                ),
                onPressed: () {
                  if (titleController.text.isEmpty ||
                      detailsController.text.isEmpty) {
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

                  // تعديل النشاط في Provider
                  Provider.of<ActivityProvider>(context, listen: false)
                      .updateActivity(
                    widget.activity.copyWith(
                      title: titleController.text,
                      details: detailsController.text,
                      imagePath: selectedImagePath,
                      date: selectedDate,
                      time: selectedTime,
                    ),
                  );

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
                            '   تم  تعديل  البيانات بنجاح',
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

                  Navigator.pop(context); // العودة إلى الصفحة الرئيسية
                },
                child: Text(
                  'حفظ التعديلات',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontFamily: "alfont",
                      fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
