import 'package:flutter/material.dart';
import 'package:structure_app/Utils/routes/routes_name.dart';
import 'package:structure_app/features/Home/presentation/home_view.dart';
import 'package:structure_app/features/Login/presentation/login_view.dart';
import 'package:structure_app/features/Splash/presentation/splash_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashView:
        return MaterialPageRoute(builder: (BuildContext context) => SplashView());
      case RoutesName.loginView:
        return MaterialPageRoute(builder: (BuildContext context) => const LoginView());
      case RoutesName.homeView:
        return MaterialPageRoute(builder: (BuildContext context) => const HomeView());
        default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
