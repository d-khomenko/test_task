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
        return MaterialPageRoute<dynamic>(
          builder: (_) => ChangeNotifierProvider<AuthModel>(
            create: (context) => AuthModel(),
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
