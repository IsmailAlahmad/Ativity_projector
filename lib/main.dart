import 'package:flutter/material.dart';
import 'package:mt/model/activity.dart';
import 'package:mt/model/page_index_provider.dart';
import 'package:mt/secreens/splash_secreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ActivityProvider()),
                ChangeNotifierProvider(create: (_) => PageIndexProvider()),

      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
