import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';

class StatsContainer extends StatelessWidget {
  const StatsContainer({
    super.key,
    required this.title,
    required this.subTitle,
    required this.color,
    required this.image,
    this.size = 13,
  });

  final String image;
  final String title, subTitle;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: screenWidth * 0.43,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xffA6ABBD).withOpacity(0.8),
            spreadRadius: 0,
            blurRadius: 18.5,
            offset: const Offset(2.5, 2.5),
          ),
          BoxShadow(
            color: const Color(0xffFAFBFF).withOpacity(0.4),
            offset: const Offset(-1.24, -1.24),
            blurRadius: 16,
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
              child: Center(
                child: Image.asset(
                  image,
                  width: 26,
                  height: 26,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontFamily: kFontText,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              subTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: size,
                fontFamily: kFontText,
                color: const Color(0xff999999),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
