import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quiz_app/constants.dart';

import 'get_started.dart';


class IntroPage3 extends StatelessWidget {
  const IntroPage3({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/intro3.png"),
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
              flex: 4,
            ),
            const Spacer(
              flex: 1,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.07, // Responsive horizontal padding
                vertical: screenSize.height * 0.03,  // Responsive vertical padding
              ),
              width: screenSize.width,
              height: screenSize.height / 3.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  Text(
                    "Demonstrate your expertise and excel as a quiz master by answering challenging questions across different subjects.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15 * textScaleFactor,  // Responsive text size
                      fontFamily: kFontText,
                    ),
                  ),
                  const Spacer(flex: 2),
                  MaterialButton(
                    elevation: 3,
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: const GetStartedPage(),
                          type: PageTransitionType.rightToLeft,
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
                      "Get Started",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22 * textScaleFactor,  // Responsive button text size
                        fontWeight: FontWeight.bold,
                        fontFamily: kFontText,
                      ),
                    ),
                  ),
                  const Spacer(flex: 1),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
