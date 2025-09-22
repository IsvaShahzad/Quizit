import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  bool isUsernameEditable = false;
  bool isEmailEditable = false;
  bool isPasswordEditable = false;

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
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final cardPadding = screenWidth * 0.05;
        final borderRadius = screenWidth * 0.0;
        final iconSize = screenWidth * 0.05;
        final fontSizeLabel = screenWidth * 0.035;
        final fontSizeInput = screenWidth * 0.04;

        return SingleChildScrollView(
          padding: EdgeInsets.all(screenWidth * 0.06),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _buildProfileCard(
                  icon: Icons.person,
                  label: "Username",
                  controller: usernameController,
                  isEditable: isUsernameEditable,
                  onEditTap: () => _onEditTapForField(
                    key: 'username',
                    controller: usernameController,
                    isEditable: isUsernameEditable,
                    setEditable: (v) => setState(() => isUsernameEditable = v),
                  ),
                  cardPadding: cardPadding,
                  borderRadius: borderRadius,
                  iconSize: iconSize,
                  fontSizeLabel: fontSizeLabel,
                  fontSizeInput: fontSizeInput,
                ),
                SizedBox(height: screenWidth * 0.04),
                _buildProfileCard(
                  icon: Icons.email,
                  label: "Email",
                  controller: emailController,
                  isEditable: isEmailEditable,
                  onEditTap: () => _onEditTapForField(
                    key: 'email',
                    controller: emailController,
                    isEditable: isEmailEditable,
                    setEditable: (v) => setState(() => isEmailEditable = v),
                  ),
                  cardPadding: cardPadding,
                  borderRadius: borderRadius,
                  iconSize: iconSize,
                  fontSizeLabel: fontSizeLabel,
                  fontSizeInput: fontSizeInput,
                ),
                SizedBox(height: screenWidth * 0.04),
                _buildProfileCard(
                  icon: Icons.lock,
                  label: "Password",
                  controller: passwordController,
                  obscure: true,
                  isEditable: isPasswordEditable,
                  onEditTap: () => _onEditTapForField(
                    key: 'password',
                    controller: passwordController,
                    isEditable: isPasswordEditable,
                    setEditable: (v) => setState(() => isPasswordEditable = v),
                  ),
                  cardPadding: cardPadding,
                  borderRadius: borderRadius,
                  iconSize: iconSize,
                  fontSizeLabel: fontSizeLabel,
                  fontSizeInput: fontSizeInput,
                ),
                SizedBox(height: screenWidth * 0.08),

                // Save Button
                Center(
                  child: SizedBox(
                    width: screenWidth * 0.7,
                    child: ElevatedButton(
                      onPressed: () => _updateProfile(context),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
                        backgroundColor: Colors.white.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                        elevation: 3,
                        shadowColor: Colors.black.withOpacity(0.3),
                      ),
                      child: Text(
                        "Save Changes",
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileCard({
    required String label,
    required TextEditingController controller,
    required bool isEditable,
    required VoidCallback onEditTap,
    required double cardPadding,
    required double borderRadius,
    required double iconSize,
    required double fontSizeLabel,
    required double fontSizeInput,
    bool obscure = false,
    IconData? icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: cardPadding, vertical: cardPadding * 0.7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row (Label + Edit Icon)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (icon != null)
                      Icon(icon, color: Colors.white.withOpacity(0.8), size: iconSize),
                    if (icon != null) SizedBox(width: cardPadding * 0.4),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: fontSizeLabel,
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: onEditTap,
                  child: Icon(
                    isEditable ? Icons.check_circle : Icons.edit,
                    color: isEditable ? Colors.greenAccent : Colors.white70,
                    size: iconSize,
                  ),
                ),
              ],
            ),
            SizedBox(height: cardPadding * 0.5),
            // Input Field
            TextFormField(
              controller: controller,
              enabled: isEditable,
              obscureText: obscure,
              style: TextStyle(color: Colors.white, fontSize: fontSizeInput),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "This field is required";
                }
                return null;
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
              ),
              cursorColor: Colors.tealAccent,
            ),
          ],
        ),
      ),
    );
  }

  void _onEditTapForField({
    required String key,
    required TextEditingController controller,
    required bool isEditable,
    required void Function(bool) setEditable,
  }) {
    if (isEditable) {
      final value = controller.text.trim();
      if (value.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Field cannot be empty')),
        );
        return;
      }
      _saveField(key, value).then((success) {
        if (success) setEditable(false);
      });
    } else {
      setEditable(true);
    }
  }

  Future<bool> _saveField(String key, String value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, value);
      setState(() {
        widget.data[key] = value;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$key saved')),
      );
      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save $key: $e')),
      );
      return false;
    }
  }

  Future<void> _updateProfile(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final updatedUsername = usernameController.text.trim();
      final updatedPassword = passwordController.text.trim();
      final updatedEmail = emailController.text.trim();

      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', updatedUsername);
        await prefs.setString('password', updatedPassword);
        await prefs.setString('email', updatedEmail);

        setState(() {
          widget.data['username'] = updatedUsername;
          widget.data['password'] = updatedPassword;
          widget.data['email'] = updatedEmail;
          isUsernameEditable = false;
          isEmailEditable = false;
          isPasswordEditable = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: $e')),
        );
      }
    }
  }
}
