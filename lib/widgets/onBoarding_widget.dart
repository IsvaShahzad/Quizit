import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';

class OnBoardingWidget extends StatelessWidget {
  const OnBoardingWidget({
    super.key,
    required this.controller,
    required this.image,
    required this.description,
  });

  final String image;
  final String description;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: image.isNotEmpty
            ? DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(image),
        )
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 4),
            // If you want to show image here, you can pass a different image if needed
            // If not, this line can be removed or adapted based on the need
            // Image.asset(image),
            const Spacer(flex: 1),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: kFontText,
                    ),
                  ),
                  const Spacer(flex: 1),
                  MaterialButton(
                    elevation: 2,
                    onPressed: () {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    color: kPrimaryColor,
                    minWidth: MediaQuery.of(context).size.width * 0.78,
                    height: 50,
                    child: Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: kFontText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
