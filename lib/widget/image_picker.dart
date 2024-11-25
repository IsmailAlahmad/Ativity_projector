import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mt/constant.dart';

class ImagePickerSection extends StatefulWidget {
  final Function(String?) onImagePicked; // Callback لإرسال مسار الصورة

  ImagePickerSection({required this.onImagePicked});

  @override
  _ImagePickerSectionState createState() => _ImagePickerSectionState();
}

class _ImagePickerSectionState extends State<ImagePickerSection> {
  String? imagePath;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
        widget.onImagePicked(imagePath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.green, width: 2),
          ),
          child: CircleAvatar(
            radius: 70,
            backgroundImage: imagePath != null
                ? FileImage(
                    File(imagePath!)) // استخدام FileImage عند اختيار صورة
                : AssetImage('')
                    as ImageProvider, // استخدام صورة افتراضية في حالة عدم اختيار صورة
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: gc,
            padding: EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          ),
          onPressed: pickImage,
          icon: Icon(Icons.image, color: Colors.white),
          label: Text(
            'إضافة صورة',
            style: TextStyle(
              fontFamily: 'alfont',
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ),
        SizedBox(height: 10),
        // عرض رسالة إذا لم يتم اختيار أي صورة
        if (imagePath == null)
          Text(
            'لم يتم اختيار صورة بعد.',
            style: TextStyle(
              fontFamily: 'alfont',
              color: Colors.grey,
              fontSize: 17,
            ),
          ),
      ],
    );
  }
}
