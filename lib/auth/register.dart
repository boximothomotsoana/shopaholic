import 'package:auth/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/app_colors.dart';
import 'curvedpainter.dart';
import 'otp.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isFormValid = false; // Track if form is valid

  void _checkFormValidity() {
    setState(() {
      _isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  /// **🔽 Show BottomSheet for Password Guidelines**
  void _showPasswordGuidelines() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Spacer(), // This will push the X button to the right.
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Center(
                child: Text(
                  "Password Requirements",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Text("✅ At least 8 characters long"),
              Text("✅ At least 1 uppercase letter (A-Z)"),
              Text("✅ At least 1 lowercase letter (a-z)"),
              Text("✅ At least 1 number (0-9)"),
              Text("✅ At least 1 special character (!@#\$%^&*)"),
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }


  // Validation Functions
  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return "Username cannot be empty";
    }
    return null;
  }

  /// **🔍 Validate Email**
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email cannot be empty";
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email address";
    }
    return null;
  }

  /// **🔒 Validate Strong Password**
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password cannot be empty";
    }
    final passwordRegex =
    RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    if (!passwordRegex.hasMatch(value)) {
      return "Weak password";
    }
    return null;
  }

  /// **🔄 Validate Confirm Password**
  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Confirm your password";
    }
    if (value != _passwordController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildTopCurve(),
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
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Form(
                    key: _formKey,
                    onChanged: _checkFormValidity, // Enable/disable button
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _splashImage(),
                        const SizedBox(height: 20),
                        _header(),
                        const SizedBox(height: 20),
                        _inputFields(),
                        const SizedBox(height: 10),
                        _signupButton(),
                        const SizedBox(height: 10),
                        const Text("Or"),
                        const SizedBox(height: 10),
                        _googleSignInButton(),
                        const SizedBox(height: 20),
                        _loginLink(context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopCurve() => Positioned(
    top: 0,
    left: 0,
    right: 0,
    child: CustomPaint(
      size: const Size(double.infinity, 150),
      painter: CurvePainterTop(),
    ),
  );

  Widget _buildBottomCurve() => Positioned(
    bottom: 0,
    left: 0,
    right: 0,
    child: CustomPaint(
      size: const Size(double.infinity, 150),
      painter: CurvePainterBottom(),
    ),
  );

  Widget _splashImage() => SvgPicture.asset(
    'assets/images/register.svg',
    height: 120,
    width: 120,
  );

  Widget _header() => const Text(
    "Create your account",
    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
  );

  Widget _inputFields() {
    return Column(
      children: [
        _buildTextField("Username", Icons.person, _usernameController, _validateUsername),
        const SizedBox(height: 10),
        _buildTextField("Email", Icons.email, _emailController, _validateEmail, isEmail: true),
        const SizedBox(height: 10),
        _buildTextField("Password", Icons.lock, _passwordController, _validatePassword,
            obscureText: true, isPassword: true),
        const SizedBox(height: 10),
        _buildTextField("Confirm Password", Icons.lock, _confirmPasswordController, _validateConfirmPassword,
            obscureText: true),
      ],
    );
  }

  /// **📌 Reusable Text Field with Error Icons**
  Widget _buildTextField(String hintText, IconData icon, TextEditingController controller,
      String? Function(String?) validator,
      {bool obscureText = false, bool isEmail = false, bool isPassword = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
        fillColor: AppColors.primary.withOpacity(0.1),
        filled: true,
        prefixIcon: Icon(icon),
        suffixIcon: (isEmail || isPassword)
            ? IconButton(
          icon: Icon(Icons.info_outline, color: Colors.grey),
          onPressed: isPassword ? _showPasswordGuidelines : () {}, // Show guidelines only for password
        )
            : null,
        errorStyle: const TextStyle(color: Colors.red),
      ),
      validator: validator,
    );
  }

  Widget _signupButton() => SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: _isFormValid ? _submitForm : null,
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: AppColors.primary,
      ),
      child: const Text("Sign Up", style: TextStyle(fontSize: 18, color: Colors.white)),
    ),
  );

  Widget _googleSignInButton() => OutlinedButton.icon(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OtpPage()),
      );
    },
    icon: const Icon(Icons.login, color: Colors.black),
    label: const Text("Sign in with Google", style: TextStyle(color: Colors.black)),
  );

  Widget _loginLink(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text("Already have an account? "),
      TextButton(onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }, child: const Text("Login")),
    ],
  );

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sign Up Successful!"), backgroundColor: AppColors.success),
      );
    }
  }
}
