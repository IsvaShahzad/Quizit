import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/widgets/label_widger.dart';

class ThirdProfileTab extends StatefulWidget {
  const ThirdProfileTab({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  _ThirdProfileTabState createState() => _ThirdProfileTabState();
}

class _ThirdProfileTabState extends State<ThirdProfileTab> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController emailController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController(text: widget.data["username"] ?? '');
    passwordController = TextEditingController(text: widget.data["password"] ?? '');
    emailController = TextEditingController(text: widget.data["email"] ?? '');
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenWidth * 0.1, // Adjust vertical padding based on screen width
        horizontal: screenWidth * 0.05, // Adjust horizontal padding based on screen width
      ),
      child: Form(
        key: formKey,
        child: ListView(
          children: [
            const Label(text: "Username"),
            SizedBox(height: screenWidth * 0.02), // Adjust spacing based on screen width
            ProfileTextField(controller: usernameController),
            SizedBox(height: screenWidth * 0.05), // Adjust spacing based on screen width
            const Label(text: "Email"),
            SizedBox(height: screenWidth * 0.02), // Adjust spacing based on screen width
            ProfileTextField(
              controller: emailController,
              enabled: true,
            ),
            SizedBox(height: screenWidth * 0.05), // Adjust spacing based on screen width
            const Label(text: "Password"),
            SizedBox(height: screenWidth * 0.02), // Adjust spacing based on screen width
            ProfileTextField(
              controller: passwordController,
              obscure: true,
              enabled: true,
            ),
            SizedBox(height: screenWidth * 0.1), // Adjust spacing based on screen width
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 15,
                    offset: const Offset(5, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  _updateProfile(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xff006666),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Update",
                  style: TextStyle(
                    fontSize: screenWidth * 0.04, // Adjust font size based on screen width
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff006666),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateProfile(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      // Collect updated data
      final updatedUsername = usernameController.text;
      final updatedPassword = passwordController.text;
      final updatedEmail = emailController.text;

      try {
        // Save data to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', updatedUsername);
        await prefs.setString('password', updatedPassword);
        await prefs.setString('email', updatedEmail);

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
      } catch (e) {
        // Handle any errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: $e')),
        );
      }
    }
  }
}

class ProfileTextField extends StatelessWidget {
  const ProfileTextField({
    super.key,
    required this.controller,
    this.obscure = false,
    this.enabled = true,
  });

  final TextEditingController controller;
  final bool obscure;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return TextFormField(
      cursorColor: Colors.teal,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Field is required.";
        }
        return null;
      },
      enabled: enabled,
      controller: controller,
      obscureText: obscure,
      style: TextStyle(
        fontFamily: kFontText,
        fontSize: screenWidth * 0.03, // Adjust font size based on screen width
        color: Colors.white,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04, // Adjust horizontal padding based on screen width
          vertical: screenWidth * 0.03, // Adjust vertical padding based on screen width
        ),
        suffixIcon: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(
            color: Color(0xffA9A9A9),
            width: 1,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(
            color: Color(0xffA9A9A9),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(
            color: Color(0xffA9A9A9),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(
            color: Color(0xffA9A9A9),
            width: 1,
          ),
        ),
      ),
    );
  }
}
