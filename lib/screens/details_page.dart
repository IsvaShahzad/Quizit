import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';
import 'home_page.dart';

class AddPage extends StatelessWidget {
  AddPage({super.key, required this.email});
  final String email;
  final AudioPlayer player = AudioPlayer();

  Future<void> playSound() async {
    String soundPath = "sounds/click-button-app-147358.mp3";
    await player.play(AssetSource(soundPath));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff006666), Color(0xff00b3b3)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // 🔹 Hero Header
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/icons/quiz.png",
                        width: size.width * 0.35,
                        height: size.width * 0.35,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Ready to play?",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: size.width * 0.07,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Test your knowledge in a fun way",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: size.width * 0.04,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),

                // 🔹 Glassmorphism Card
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Info Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          _InfoPill(icon: Icons.article_outlined, label: "1 Qs"),
                          _InfoPill(icon: Icons.timer, label: "30s"),
                          _InfoPill(icon: Icons.star_border, label: "10 pts"),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Rules
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          _RuleText("10 points for correct answers."),
                          _RuleText("30 seconds for each question."),
                          _RuleText("Tap to select an option."),
                          _RuleText("Press Next to move ahead."),
                          _RuleText("Submit when all done."),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: size.height * 0.06,
                ),
                // 🔹 Start Button
                GestureDetector(
                  onTap: () {
                    playSound();
                    Navigator.popAndPushNamed(
                      context,
                      HomePage.id,
                      arguments: email,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    height: size.height * 0.07,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1),
                      gradient: const LinearGradient(
                        colors: [Color(0xff00b3b3), Color(0xff004c4c)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Start Quiz",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoPill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          Icon(icon, size: size.width * 0.05, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: size.width * 0.04,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _RuleText extends StatelessWidget {
  final String text;
  const _RuleText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.check_circle, size: 18, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: MediaQuery.of(context).size.width * 0.04,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
