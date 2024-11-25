import 'package:flutter/material.dart';
import 'package:mt/constant.dart';

class TimePickerSection extends StatefulWidget {
  final Function(TimeOfDay?) onTimePicked; // Callback لإرسال الوقت

  TimePickerSection({required this.onTimePicked});

  @override
  _TimePickerSectionState createState() => _TimePickerSectionState();
}

class _TimePickerSectionState extends State<TimePickerSection> {
  TimeOfDay? selectedTime;

  Future<void> pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        widget.onTimePicked(selectedTime); // إرسال الوقت
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
          onPressed: pickTime,
          icon: Icon(Icons.access_time, color: Colors.white),
          label: Text(
            'إضافة وقت',
            style: TextStyle(
              fontFamily: 'alfont',
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ),
        SizedBox(height: 20),
        if (selectedTime != null)
          Text(
            'الوقت المختار: ${selectedTime!.format(context)}',
            style: TextStyle(
              fontFamily: 'alfont',
              color: Colors.black,
              fontSize: 17,
            ),
          )
        else
          Text(
            'لم يتم اختيار وقت بعد.',
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
