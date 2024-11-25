import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:mt/constant.dart';
import 'package:mt/model/page_index_provider.dart';
import 'package:mt/secreens/add_activity_page.dart';
import 'package:mt/secreens/home_page.dart';
import 'package:provider/provider.dart';


class MainPageView extends StatelessWidget {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final pageIndexProvider = Provider.of<PageIndexProvider>(context);

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          pageIndexProvider.updateIndex(index); // تحديث الفهرس عبر Provider
        },
        children: [
          HomePage(),
          NewActivityPage(),
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: gc,
        style: TabStyle.react,
        items: [
          TabItem(fontFamily: 'alfont', icon: Icons.home, title: 'الرئيسية'),
          TabItem(fontFamily: 'alfont', icon: Icons.add, title: 'إضافة نشاط'),
        ],
        initialActiveIndex: pageIndexProvider.currentIndex,
        onTap: (int index) {
          pageIndexProvider.updateIndex(index); // تحديث الفهرس عبر Provider
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }
}
