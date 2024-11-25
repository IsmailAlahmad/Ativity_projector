import 'package:flutter/material.dart';
import 'package:mt/constant.dart';

class SliderSection extends StatefulWidget {
  @override
  _SliderSectionState createState() => _SliderSectionState();
}

class _SliderSectionState extends State<SliderSection> {
  double activityLevel = 5.0; // مستوى النشاط الافتراضي
  RangeValues _currentRangeValues =
      const RangeValues(5, 7); // الفترة الزمنية الافتراضية

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Slider لمستوى النشاط
          Text(
            'مستوى النشاط: ${activityLevel.toStringAsFixed(1)}',
            style: TextStyle(
              fontFamily: 'alfont',
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          Slider(
            activeColor: gc,
            inactiveColor: Colors.grey,
            value: activityLevel,
            min: 0,
            max: 100,
            divisions: 100,
            label: activityLevel.toStringAsFixed(1),
            onChanged: (value) => setState(() => activityLevel = value),
          ),
          SizedBox(height: 30),

          // RangeSlider للفترة الزمنية
          Text(
            textAlign: TextAlign.center,
            'الفترة الزمنية المحددة: من ${_currentRangeValues.start.toInt()} صباحًا إلى ${_currentRangeValues.end.toInt()} صباحًا',
            style: TextStyle(
              fontFamily: 'alfont',
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          RangeSlider(
            activeColor: gc,
            inactiveColor: Colors.grey,
            values: _currentRangeValues,
            min: 0, // منتصف الليل
            max: 23, // الساعة 11 مساءً
            divisions: 23, // كل ساعة
            labels: RangeLabels(
              '${_currentRangeValues.start.toInt()}',
              '${_currentRangeValues.end.toInt()}',
            ),
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
              });
            },
          ),
        ],
      ),
    );
  }
}
