import 'package:auth/UI/dashboard.dart';
import 'package:auth/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'curvedpainter.dart';
import 'login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroScreen(),
    );
  }
}

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            children: [
            _buildTopCurve(), // ✅ Adds a top curved background
        _buildBottomCurve(),
        Center(
        child: Container(
          color: Colors.transparent,
        constraints: BoxConstraints(maxWidth: 600), // Limits width for large screens
        child: IntroductionScreen(
          globalBackgroundColor: Colors.transparent,
        pages: [
        PageViewModel(
          title: "Welcome to TeleHealth",
          body: "Your online medical consultation made easy.",
          image: buildLottie('assets/animations/one.json'),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: "Find the Best Doctors",
          body: "Get access to top-rated professionals anywhere, anytime. ",
          image: buildLottie('assets/animations/turbine.json'),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: "Book Appointments Easily",
          body: "Schedule and manage appointments effortlessly.",
          image: buildLottie('assets/animations/two.json'),
          decoration: getPageDecoration(),
        ),
      ],
      onDone: () => goToHome(context),
      onSkip: () => goToHome(context),
      showSkipButton: true,
      skip: Text("Skip", style: TextStyle(color: AppColors.textPrimary),),
      next: Icon(Icons.arrow_forward, color: AppColors.textPrimary),
      done: Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: DotsDecorator(
        size: Size(20, 20),
        activeSize: Size(42, 20),
        activeColor: AppColors.light,
        color: AppColors.textPrimary,
        spacing: EdgeInsets.symmetric(horizontal: 5),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    )
        )
        )
    ]
        )
    );
  }

  /// 🎨 Adds a top curved design
  Widget _buildTopCurve() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: CustomPaint(
        size: const Size(double.infinity, 150),
        painter: CurvePainterTop(),
      ),
    );
  }

  /// 🎨 Adds a bottom curved design
  Widget _buildBottomCurve() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: CustomPaint(
        size: const Size(double.infinity, 150),
        painter: CurvePainterBottom(),
      ),
    );
  }

  Widget buildLottie(String assetPath) {
    return Lottie.asset(assetPath, width: 300, height: 300, fit: BoxFit.cover);
  }

  Widget buildImage(String assetPath) {
    return Container(
      width: 300,
      height: 300,
      child: Image.asset(assetPath, fit: BoxFit.cover),
    );
  }
  PageDecoration getPageDecoration() {
    return PageDecoration(
      titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      bodyTextStyle: TextStyle(fontSize: 16),
      bodyPadding: EdgeInsets.all(16).copyWith(bottom: 0),
      imagePadding: EdgeInsets.all(20),
      pageColor: Colors.transparent,
    );
  }

  Future<void> goToHome(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Dashboard()),
    );
  }
}
