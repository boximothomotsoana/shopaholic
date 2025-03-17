import 'package:auth/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard/index.dart';
import 'utils/app_colors.dart';
import 'providers/cart_provider.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isFirstTime = await checkFirstTime();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()), // Keep CartProvider
      ],
      child: MyApp(isFirstTime: isFirstTime),
    ),
  );
}

// Check if the app is opened for the first time
Future<bool> checkFirstTime() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isFirstTime') ?? true;
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  MyApp({super.key, required this.isFirstTime});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ba jetseng ka thabo batla kotula ka thabo',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,  // Added for deep linking navigation
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      //initialRoute: isFirstTime ? AppRoutes.introScreen : AppRoutes.splashScreen,
      initialRoute: isFirstTime ? AppRoutes.introScreen : AppRoutes.admin,
      routes: {
        ...AppRoutes.getRoutes(),
        "/success": (context) => PaymentSuccessScreen(),
        "/cancel": (context) => PaymentCancelledScreen(),
      },
    );
  }
}

class PaymentSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Success")),
      body: Center(child: Text("Payment Successful!")),
    );
  }
}

class PaymentCancelledScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cancelled")),
      body: Center(child: Text("Payment Cancelled.")),
    );
  }
}
