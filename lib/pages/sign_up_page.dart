import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/helper/show_toast.dart';
import 'package:quiz_app/pages/cubits/signup_cubit/signup_cubit.dart';
import 'package:quiz_app/pages/home_page.dart';
import 'package:quiz_app/widgets/ArrowButton.dart';
import 'package:quiz_app/widgets/signUptextfield_widget.dart';

class SignUpPage extends StatelessWidget {
  static String id = "/signUpPage";
  String? userName, email, password;
  final String requiredPassword = "p455w0rd"; // Password to match
  int score = 0;
  bool isLoading = false;
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
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
                image: AssetImage("assets/images/register_background.png"),
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
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                      // child: Row(
                      //   children: [
                      //     ArrowButton(),
                      //   ],
                      // ),
                    ),
                    const SizedBox(
                      height: 75,
                    ),
                    Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'Montserrat',
                          letterSpacing: 2,
                          fontWeight: FontWeight.w300,

                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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
                      padding: const EdgeInsets.symmetric(horizontal: 41, vertical: 32),
                      child: MaterialButton(
                        elevation: 2,
                        height: 50,
                        minWidth: 320,
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
                                fontSize: 22,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        "OR",
                        style: TextStyle(
                          fontSize: 18,
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
                          fontSize: 13,
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
