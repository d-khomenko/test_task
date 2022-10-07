// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:test_task/ui/theme/app_colors.dart';
import 'package:test_task/ui/widgets/auth_screen/auth_screen.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: AppColors.primarySwatch,
      ),
      debugShowCheckedModeBanner: false,
      home: const AuthScreen(),
    );
  }
}