import 'package:flutter/material.dart';
import 'package:quiz_app/widgets/onBoarding_widget.dart';

class IntroPage1 extends StatelessWidget {
  final PageController controller;

  const IntroPage1({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get the size of the screen
    final Size screenSize = MediaQuery.of(context).size;

    return OnBoardingWidget(
      controller: controller,
      description: "Push your limits with our engaging quizzes and uncover your knowledge across diverse topics.",
      image: 'assets/images/intro1.png',
      imageHeight: screenSize.height * 0.4,  // Adjust image height relative to screen size
      imageWidth: screenSize.width * 0.8,   // Adjust image width relative to screen size
    );
  }
}
