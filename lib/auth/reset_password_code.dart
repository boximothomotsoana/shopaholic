import 'package:auth/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/app_colors.dart';
import '../utils/auth_appbar.dart';
import 'curvedpainter.dart';

class ResetPasswordCodePage extends StatefulWidget {
  const ResetPasswordCodePage({super.key});

  @override
  _ResetPasswordCodePageState createState() => _ResetPasswordCodePageState();
}

class _ResetPasswordCodePageState extends State<ResetPasswordCodePage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _codeController = TextEditingController();

  bool _isFormValid = false; // Track if form is valid

  void _checkFormValidity() {
    setState(() {
      _isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  /// **🔽 Show BottomSheet for Guidelines**
  void _showGuidelines() {
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
            child:
              Text(
                "More Info For code",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
              SizedBox(height: 10),
              Text("✅ check if your email is correct"),
              Text("✅ Verify that your device have stable or access to internet"),
              Text("✅ If you can not find email check your spam folder"),
              Text("✅ Contact support if you still have problem"),
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // Validation Functions
  String? _validatecode(String? value) {
    if (value == null || value.isEmpty) {
      return "Code cannot be empty";
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
                        _codeButton(),
                        const SizedBox(height: 10),
                        _resentCodeButton(),
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
    'assets/images/reset_pass.svg',
    height: 120,
    width: 120,
  );

  Widget _header() => const Text(
    "Enter code send to mothomotsoanabk@gmail.com",
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    textAlign: TextAlign.center,
  );

  Widget _inputFields() {
    return Column(
      children: [
        _buildTextField("Reset Password Code", Icons.security, _codeController, _validatecode, isCode: true),
        const SizedBox(height: 10),
      ],
    );
  }

  /// **📌 Reusable Text Field with Error Icons**
  Widget _buildTextField(String hintText, IconData icon, TextEditingController controller,
      String? Function(String?) validator,
      {bool isCode = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
        fillColor: AppColors.primary.withOpacity(0.1),
        filled: true,
        prefixIcon: Icon(icon),
        suffixIcon: (isCode)
            ? IconButton(
          icon: Icon(Icons.info_outline, color: Colors.grey),
          onPressed: isCode ? _showGuidelines : () {}, // Show guidelines only for password
        )
            : null,
        errorStyle: const TextStyle(color: Colors.red),
      ),
      validator: validator,
    );
  }

  Widget _codeButton() => SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: _isFormValid ? _submitForm : null,
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: AppColors.primary,
      ),
      child: const Text("Proceed", style: TextStyle(fontSize: 18, color: Colors.white)),
    ),
  );

  Widget _resentCodeButton() => OutlinedButton.icon(
    onPressed: () {},
    icon: const Icon(Icons.redo_sharp, color: Colors.black),
    label: const Text("Resend code", style: TextStyle(color: Colors.black)),
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
        const SnackBar(content: Text("Action Successful!"), backgroundColor: AppColors.success),
      );
    }
  }
}
