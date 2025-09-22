import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';

class HistoryContainer extends StatelessWidget {
  const HistoryContainer({
    super.key,
    required this.gradient,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.correct,
    required this.image,
    this.onTap,
  });

  final LinearGradient gradient;
  final String title, subtitle, date, correct, image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),

          /// Bring back the glow effect (bright & soft)
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.6), // outer glow (bright white)
              spreadRadius: 0,
              blurRadius: 13,
              offset: const Offset(2, 2),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.4), // inner subtle glow
              spreadRadius: 0,
              blurRadius: 15,
              offset: const Offset(-2, -2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image (no circular border)
            Image.asset(
              image,
              width: 55,
              height: 55,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 14),

            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),

                  // Subtitle with gradient
                  ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (rect) => gradient.createShader(rect),
                    child: Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 15,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Date & Correct info with icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.access_time,
                              size: 12, color: Color(0xff999999)),
                          const SizedBox(width: 4),
                          Text(
                            date,
                            style: const TextStyle(
                              color: Color(0xff999999),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.check_circle,
                              size: 12, color: Color(0xff999999)),
                          const SizedBox(width: 4),
                          Text(
                            correct,
                            style: const TextStyle(
                              color: Color(0xff999999),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ],
                      ),
                    ],
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
