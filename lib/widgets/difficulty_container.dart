import 'package:flutter/material.dart';

class DifficultyContainer extends StatelessWidget {
  const DifficultyContainer({
    super.key,
    required this.title,
    required this.onTap,
    required this.color,
  });
  final Color color;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5),
        elevation: 2,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.26,
          height: 85,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: color,
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
