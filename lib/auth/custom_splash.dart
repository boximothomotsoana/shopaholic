import 'package:auth/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'intro.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  final bool isFirstTime;

  const SplashScreen({super.key, required this.isFirstTime});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.primary, // Status bar color
        statusBarIconBrightness: Brightness.light, // Light or dark icons
        systemNavigationBarColor: AppColors.primary, // Bottom navigation bar color
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _navigateToNextScreen();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 3)); // Duration for the splash screen
    if (widget.isFirstTime) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => IntroScreen()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: RotationTransition(
          turns: _controller,
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
    );
  }
}
