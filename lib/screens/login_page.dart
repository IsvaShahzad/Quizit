import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/screens/sign_up_page.dart';

import 'package:quiz_app/widgets/ArrowButton.dart';
import 'package:quiz_app/widgets/Login_textfield.dart';

import '../api_helper/show_toast.dart';
import 'home_page.dart';
import 'main_pages/login_cubit/login_cubit.dart';

class LogInPage extends StatelessWidget {
  static String id = "/LoginPage";
  final String requiredPassword = "p455w0rd";
  GlobalKey<FormState> formKey = GlobalKey();
  String? email;
  String? password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          isLoading = false;
          Navigator.pushNamed(context, HomePage.id, arguments: email);
        } else if (state is LoginFailure) {
          isLoading = false;
          toastFailure(message: state.errMessage, context: context);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Form(
            key: formKey,
            child: WillPopScope(
              onWillPop: () async => false, // Prevents going back
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/images/bg1.png",
                        width: screenSize.width,
                        height: screenSize.height,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: screenSize.height * 0.03, // Responsive vertical padding
                          horizontal: screenSize.width * 0.06, // Responsive horizontal padding
                        ),
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            SizedBox(
                              height: screenSize.height * 0.15,
                            ),
                            Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 35 * textScaleFactor, // Responsive font size
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenSize.height * 0.06,
                            ),
                            CustomTextField(
                              icon: Icons.email_outlined,
                              label: "Email Address",
                              onSubmitted: (data) {
                                email = data;
                              },
                            ),
                            SizedBox(
                              height: screenSize.height * 0.05,
                            ),
                            CustomTextField(
                              icon: Icons.lock,
                              label: "Password",
                              suffixIcon: true,
                              obscure: true,
                              onSubmitted: (data) {
                                password = data;
                              },
                            ),
                            SizedBox(
                              height: screenSize.height * 0.07,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.07, // Responsive horizontal padding
                              ),
                              child: MaterialButton(
                                elevation: 1,
                                height: screenSize.height * 0.06, // Responsive height
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    // Check if password is correct
                                    if (password == requiredPassword) {
                                      // Proceed with login
                                      BlocProvider.of<LoginCubit>(context).LoginUser(
                                        email: email,
                                        password: password!,
                                      );
                                    } else {
                                      // Show error toast
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Incorrect password.'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  }
                                },
                                color: kPrimaryColor,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: screenSize.width * 0.05, // Responsive spacing
                                    ),
                                    Text(
                                      "Log in",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22 * textScaleFactor, // Responsive font size
                                      ),
                                    ),
                                    SizedBox(width: screenSize.width * 0.04), // Responsive spacing
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenSize.height * 0.05,
                            ),
                            Text(
                              "OR",
                              style: TextStyle(
                                color: Colors.black45,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 15 * textScaleFactor, // Responsive font size
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: screenSize.height * 0.03,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    child: SignUpPage(),
                                    type: PageTransitionType.rightToLeft,
                                  ),
                                );
                              },
                              child: Text(
                                "Create a new account",
                                style: TextStyle(
                                  decorationColor: kTextAccent,
                                  color: kTextAccent,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17 * textScaleFactor, // Responsive font size
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
