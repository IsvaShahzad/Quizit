import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/widgets/label_widger.dart';

class ThirdProfileTab extends StatefulWidget {
  ThirdProfileTab({
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 39),
      child: Form(
        key: formKey,
        child: ListView(
          children: [
            const Label(text: "Username"),
            const SizedBox(height: 2),
            ProfileTextField(controller: usernameController),
            const SizedBox(height: 20),
            const Label(text: "Email"),
            const SizedBox(height: 2),
            ProfileTextField(
              controller: emailController,
              enabled: true,
            ),
            const SizedBox(height: 20),
            const Label(text: "Password"),
            const SizedBox(height: 2),
            ProfileTextField(
              controller: passwordController,
              obscure: true,
              enabled: true,
            ),
            const SizedBox(height: 30),
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
                child: const Text(
                  "Update",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                    color: Color(0xff006666),
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
        fontSize: 13,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
