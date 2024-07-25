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
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/Quizzit.png"),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.9,
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
                      "LogIn Or Sign up",
                      style: TextStyle(

                        fontSize: 20,
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
                            child: LogInPage(),
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
                      minWidth: MediaQuery.of(context).size.width * 0.78,
                      height: 50,
                      child: Text(
                        "Log in",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
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
                            child: SignUpPage(),
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
                      minWidth: MediaQuery.of(context).size.width * 0.78,
                      height: 50,
                      child: Text(
                        "Create an Account",
                        style: TextStyle(
                          color: const Color(0xFF006666),
                          fontSize: 18,
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
