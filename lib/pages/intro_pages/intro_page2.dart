// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:quiz_app/widgets/onBoarding_widget.dart';

class IntroPage2 extends StatelessWidget {
  IntroPage2({
    super.key,
    required this.controller,
  });
  PageController controller;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return OnBoardingWidget(
        controller: controller,
        image: "assets/images/intro2.png",
        description:
            "Engage in educational quizzes crafted to bring fun and excitement to learning.",
      imageHeight: screenSize.height * 0.4,  // Adjust image height relative to screen size
      imageWidth: screenSize.width * 0.8,
    );
  }
}
