import 'package:flutter/material.dart';
import 'package:kashkha/core/theme/app_colors.dart';
// import 'package:kashkha/features/authentication/presentation/screens/login_screen.dart';
// import 'package:kashkha/features/authentication/presentation/screens/sign_up_screen.dart';
// import 'package:kashkha/features/authentication/presentation/screens/verify_email.dart';
import 'package:kashkha/features/home/presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.whiteCLR,
      ),
      home: const HomeScreen(),
    );
  }
}