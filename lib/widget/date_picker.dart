import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mt/constant.dart';

class DatePickerSection extends StatefulWidget {
  final Function(DateTime?) onDatePicked; // Callback لإرسال التاريخ

  DatePickerSection({required this.onDatePicked});

  @override
  _DatePickerSectionState createState() => _DatePickerSectionState();
}

class _DatePickerSectionState extends State<DatePickerSection> {
  DateTime? selectedDate;

  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        widget.onDatePicked(selectedDate); // إرسال التاريخ
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: gc,
            padding: EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          ),
          onPressed: pickDate,
          icon: Icon(Icons.calendar_today, color: Colors.white),
          label: Text(
            'إضافة تاريخ',
            style: TextStyle(
              fontFamily: 'alfont',
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ),
        SizedBox(height: 20),
        if (selectedDate != null)
          Text(
            'التاريخ المختار: ${DateFormat('yyyy-MM-dd').format(selectedDate!)}',
            style: TextStyle(
              fontFamily: 'alfont',
              color: Colors.black,
              fontSize: 17,
            ),
          )
        else
          Text(
            'لم يتم اختيار تاريخ بعد.',
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
