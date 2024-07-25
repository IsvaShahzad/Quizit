import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class CountDownTimer extends StatelessWidget {
  const CountDownTimer({
    super.key,
    required this.controller,
    required this.questionSelectedIndex,
    required this.onComplete,
    this.duration = 30,
  });

  final int questionSelectedIndex;
  final CountDownController controller;
  final int duration;

  final void Function()? onComplete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(10),
      child: CircularCountDownTimer(
        width: 80,
        height: 80,
        duration: duration,
        controller: controller,
        textStyle: const TextStyle(
          color: Color(0xFF008080),
          fontSize: 26,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.white,
        fillColor: Colors.white,
        ringColor: const Color(0xFF008080),
        isReverse: true,
        onComplete: onComplete,
      ),
    );
  }
}
