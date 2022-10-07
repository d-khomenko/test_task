import 'dart:io';

import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task/ui/widgets/auth_screen/auth_model.dart';
import 'package:test_task/ui/widgets/auth_screen/auth_screen.dart';

///
class MainNavigation {
  ///
  Route<dynamic>? Function(RouteSettings)? onGenerateRoute = (settings) {
    ///
    switch (settings.name) {
      case MainNavigationRoutesNames.auth:

        ///
        final String localeName = Platform.localeName;
        final code = codes.map(CountryCode.fromMap).toList().firstWhere(
              (element) => element.code == localeName.substring(3, 5),
            );

        ///
        return MaterialPageRoute<dynamic>(
          builder: (_) => ChangeNotifierProvider<AuthModel>(
            lazy: false,
            create: (context) => AuthModel(code: code),
            child: const AuthScreen(),
          ),
        );

      default:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const Center(
            child: Text("Error path... =("),
          ),
        );
    }
  };
}

///
abstract class MainNavigationRoutesNames {
  ///
  static const auth = "/auth";
}
