import 'package:auth/auth/forget_password.dart';
import 'package:auth/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';
import '../UI/dashboard.dart';
import '../utils/app_colors.dart';
import 'curvedpainter.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  void initState() {
    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.primary, // Status bar color
        statusBarIconBrightness: Brightness.light, // Light or dark icons
        systemNavigationBarColor: AppColors.primary, // Bottom navigation bar color
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Stack(
              children: [
            _buildTopCurve(), // ✅ Adds a top curved background
            _buildBottomCurve(),
                Positioned(
                    top: 40, // Adjust as needed
                    left: 16, // Adjust as needed
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                ),
            Center(
              child: SingleChildScrollView(
                // ✅ Enables scrolling
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    // ✅ Limits max width
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _splashImage(),
                        const SizedBox(height: 20),
                        _header(context),
                        const SizedBox(height: 20),
                        _inputField(context),
                        _forgotPassword(context),
                        _signup(context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ));
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

  /// 🖼️ Splash image (logo or decorative)
  Widget _splashImage() {
    return SvgPicture.asset(
      'assets/images/login.svg',
      height: 120, // Adjust as needed
      width: 120,
    );
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Welcome",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        Text("Enter your credentials to login"),
      ],
    );
  }

  _inputField(context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: "Username",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor:  AppColors.primary.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.person),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor:  AppColors.primary.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.lock),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity, // ✅ Makes button width match input fields
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor:  AppColors.primary,
            ),
            child: const Text(
              "Login",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ForgetPasswordPage()),
        );
      },
      child: const Text(
        "Forgot password?",
        style: TextStyle(color:  AppColors.primary),
      ),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignupPage()),
            );
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color:  AppColors.textPrimary),
          ),
        ),
      ],
    );
  }
}
