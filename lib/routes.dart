import 'package:auth/widgets/orders.dart';
import 'package:flutter/material.dart';
import '../ui/dashboard.dart';
import '../utils/forms_fields.dart';
import '../auth/intro.dart';
import 'auth/custom_splash.dart';
import 'auth/login.dart';
import 'auth/register.dart';
import 'main.dart';

class AppRoutes {
  static const String home = '/';
  static const String about = '/about';
  static const String help = '/help';
  static const String settings = '/settings';
  static const String sell = '/sell';
  static const String deliver = '/deliver';
  static const String login = '/login';
  static const String introScreen = '/introScreen';
  static const String splashScreen = '/splashScreen';
  static const String dashboard = '/dashboard';
  static const String orders = '/orders';
  static const String register = '/register';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => Dashboard(),
      about: (context) => FormScreen(),
      help: (context) => FormScreen(),
      settings: (context) => FormScreen(),
      sell: (context) => FormScreen(),
      deliver: (context) => FormScreen(),
      login: (context) => LoginPage(),
      introScreen: (context) => IntroScreen(),
      dashboard: (context) => Dashboard(),
      orders: (context) => OrderScreen(),
      splashScreen: (context) => SplashScreen(isFirstTime: false),
      "/success": (context) => PaymentSuccessScreen(),
      "/cancel": (context) => PaymentCancelledScreen(),
      "/register": (context) => SignupPage(),

    };
  }
}
