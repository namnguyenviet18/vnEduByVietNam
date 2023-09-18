


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vnedu/controller/appbar_provider.dart';
import 'package:vnedu/controller/chang_image_provider.dart';
import 'package:vnedu/controller/notification_provider.dart';
import 'package:vnedu/controller/profile_provider.dart';
import 'package:vnedu/controller/update_user_provider.dart';
import 'package:vnedu/screens/login_screen.dart';
import 'package:vnedu/screens/school_yard_screen.dart';
import 'package:vnedu/screens/splash_screen.dart';
import 'package:vnedu/shared/message_board_component.dart';
import 'package:vnedu/shared/overall_for_home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UpdateUserNotifier()),
        ChangeNotifierProvider(create: (context) => ProfileNotifier()),
        ChangeNotifierProvider(create: (context) => AppBarNotifier()),
        ChangeNotifierProvider(create: (context) => ChangeImageProvider()),
        ChangeNotifierProvider(create: (context) => NotificationNotifier())
      ],
      child: MyApp(),
    ),

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }

}


