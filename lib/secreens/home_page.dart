import 'package:flutter/material.dart';
import 'package:mt/constant.dart';
import 'package:mt/model/activity.dart';
import 'package:mt/page.dart';
import 'package:mt/secreens/add_activity_page.dart';
import 'package:mt/secreens/edit_ativity_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final activities = Provider.of<ActivityProvider>(context).activities;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'الرئيسية',
                style: TextStyle(
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(0, 1),
                    ),
                  ],
                  fontFamily: 'alfont',
                  fontWeight: FontWeight.bold,
                  color: gc,
                  fontSize: 25,
                ),
              ),
              background: Image.asset(
                'images/act.jpg',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final activity = activities[index];

                return Container(
                  decoration: BoxDecoration(
                    color: index % 2 == 0 ? Colors.grey[200] : Colors.white,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      activity.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'alfont',
                        color: gc,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity.details,
                          style: TextStyle(
                            fontFamily: 'alfont',
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        if (activity.date != null)
                          Text(
                            'التاريخ: ${activity.date!.toLocal().toString().split(' ')[0]}',
                            style: TextStyle(color: Colors.grey),
                          ),
                        if (activity.time != null)
                          Text(
                            'الوقت: ${activity.time!.format(context)}',
                            style: TextStyle(color: Colors.grey),
                          ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: gc),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditActivityPage(activity: activity),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            // تأكيد الحذف
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    'تأكيد الحذف',
                                    style: TextStyle(
                                      fontFamily: 'alfont',
                                      color: gc,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  content: Text(
                                    'هل أنت متأكد من حذف هذا النشاط؟',
                                    style: TextStyle(fontFamily: 'alfont'),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(
                                        'إلغاء',
                                        style: TextStyle(
                                          fontFamily: 'alfont',
                                          color: gc,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // تنفيذ الحذف
                                        Provider.of<ActivityProvider>(context,
                                                listen: false)
                                            .deleteActivity(activity);
                                        Navigator.pop(
                                            context); // إغلاق نافذة التأكيد
                                      },
                                      child: Text('حذف',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'alfont',
                                              color: Colors.red)),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      // الانتقال إلى صفحة التفاصيل عند الضغط على النشاط
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ActivityDetailsPage(activity: activity),
                        ),
                      );
                    },
                  ),
                );
              },
              childCount: activities.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: gc,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewActivityPage()),
          );
        },
        child: Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
