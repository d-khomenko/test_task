// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';
import 'package:test_task/ui/navigation/main_navigation.dart';
import 'package:test_task/ui/theme/app_colors.dart';

class AppWidget extends StatelessWidget {
  static final mainNavigation = MainNavigation();
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
      initialRoute: MainNavigationRoutesNames.auth,
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}
