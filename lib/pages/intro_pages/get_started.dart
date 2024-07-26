import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/pages/login_page.dart';
import 'package:quiz_app/pages/sign_up_page.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});
  static String id = "/GetStartedPage";

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/teal4.png"),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.03, // Responsive horizontal padding
            vertical: screenSize.height * 0.02,  // Responsive vertical padding
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(
                flex: 11,
              ),
              const Spacer(
                flex: 1,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.07, // Responsive horizontal padding
                  vertical: screenSize.height * 0.02,  // Responsive vertical padding
                ),
                width: screenSize.width,
                height: screenSize.height / 2.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    Text(
                      "Log In Or Sign Up",
                      style: TextStyle(
                        fontSize: 20 * textScaleFactor,  // Responsive font size
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    MaterialButton(
                      elevation: 2,
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            child:  LogInPage(),
                            type: PageTransitionType.fade,
                            duration: const Duration(milliseconds: 500),
                            reverseDuration: const Duration(milliseconds: 500),
                          ),
                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: kPrimaryColor,
                      minWidth: screenSize.width * 0.78, // Responsive button width
                      height: 50,
                      child: Text(
                        "Log in",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18 * textScaleFactor,  // Responsive font size
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    MaterialButton(
                      elevation: 2,
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            child:  SignUpPage(),
                            type: PageTransitionType.fade,
                            duration: const Duration(milliseconds: 500),
                            reverseDuration: const Duration(milliseconds: 500),
                          ),
                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: const Color(0xFFDEDEDE),
                      minWidth: screenSize.width * 0.78, // Responsive button width
                      height: 50,
                      child: Text(
                        "Create an Account",
                        style: TextStyle(
                          color: const Color(0xFF006666),
                          fontSize: 18 * textScaleFactor,  // Responsive font size
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
