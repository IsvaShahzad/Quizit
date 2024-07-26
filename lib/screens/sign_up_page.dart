import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quiz_app/constants.dart';

import 'package:quiz_app/widgets/ArrowButton.dart';
import 'package:quiz_app/widgets/signUptextfield_widget.dart';

import '../api_helper/show_toast.dart';
import 'home_page.dart';
import 'main_pages/signup_cubit/signup_cubit.dart';

class SignUpPage extends StatelessWidget {
  static String id = "/signUpPage";
  String? userName, email, password;
  final String requiredPassword = "p455w0rd"; // Password to match
  int score = 0;
  bool isLoading = false;
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupLoading) {
          isLoading = true;
        } else if (state is SignupSuccess) {
          isLoading = false;
          Navigator.push(
            context,
            PageTransition(
              child: HomePage(
                emails: email!,
                first: true,
              ),
              type: PageTransitionType.rightToLeft,
            ),
          );
        } else if (state is SignupFailure) {
          isLoading = false;
          toastFailure(message: state.errMessage, context: context);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg1.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Form(
              key: formkey,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: ListView(
                  clipBehavior: Clip.none,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.06, // Responsive horizontal padding
                        vertical: screenSize.height * 0.01, // Responsive vertical padding
                      ),
                      // Add any additional widgets if needed
                    ),
                    SizedBox(
                      height: screenSize.height * 0.1, // Responsive height
                    ),
                    Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 35 * textScaleFactor, // Responsive font size
                          fontFamily: 'Montserrat',
                          letterSpacing: 2,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.02, // Responsive height
                    ),
                    SignUpTextField(
                      hint: "User Name",
                      icon: Icons.border_color,
                      onChange: (data) {
                        userName = data;
                      },
                    ),
                    SignUpTextField(
                      hint: "Email Address",
                      icon: Icons.mark_email_unread,
                      onChange: (data) {
                        email = data;
                      },
                    ),
                    SignUpTextField(
                      hint: "Password",
                      icon: Icons.lock,
                      obscure: true,
                      onChange: (data) {
                        password = data;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.1, // Responsive horizontal padding
                        vertical: screenSize.height * 0.04, // Responsive vertical padding
                      ),
                      child: MaterialButton(
                        elevation: 2,
                        height: screenSize.height * 0.06, // Responsive height
                        minWidth: screenSize.width * 0.8, // Responsive width
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            if (password == requiredPassword) {
                              BlocProvider.of<SignupCubit>(context).signUpUser(
                                email: email!,
                                password: password!,
                                userName: userName!,
                                score: score,
                              );
                            } else {
                              toastFailure(
                                message: "Password is incorrect. Please try again.",
                                context: context,
                              );
                            }
                          }
                        },
                        color: kPrimaryColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 22 * textScaleFactor, // Responsive font size
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: screenSize.height * 0.02, // Responsive padding
                      ),
                      child: Text(
                        "OR",
                        style: TextStyle(
                          fontSize: 18 * textScaleFactor, // Responsive font size
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Already have an account? Sign In",
                        style: TextStyle(
                          decorationColor: kTextAccent,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          fontSize: 13 * textScaleFactor, // Responsive font size
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
