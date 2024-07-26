import 'package:audioplayers/audioplayers.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/pages/firebase_services.dart/firestore.dart';
import 'package:quiz_app/pages/home_page.dart';
import 'package:quiz_app/pages/question_page.dart';
import 'package:quiz_app/widgets/analysesWidger.dart';
import 'package:quiz_app/widgets/score_widget.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';

import '../widgets/correction_widget.dart';

class ResultPage extends StatelessWidget {
  ResultPage({
    super.key,
    required this.playerResults,
    required this.questions,
    required this.type,
    required this.email,
    required this.playerSelectedResponses,
    required this.diffiuclty,
    required this.catId,
  });

  final List<String> playerResults;
  final List<Question> questions;
  final String type, email, diffiuclty, catId;
  final List<Map<String, dynamic>> playerSelectedResponses;
  final AudioPlayer player = AudioPlayer();
  final ValueNotifier<double> _valueNotifier = ValueNotifier(0);

  int score = 0, totalQuestions = 0, correct = 0, skipped = 0, wrong = 0;

  Future<void> playSound() async {
    String soundPath = "sounds/level-complete-mobile-game-app-locran-1-00-06.mp3";
    await player.play(AssetSource(soundPath));
  }

  @override
  Widget build(BuildContext context) {
    totalQuestions = playerResults.length;
    for (String response in playerResults) {
      if (response == "true") {
        score += 10;
        correct++;
      } else if (response == "false") {
        wrong++;
      } else {
        skipped++;
      }
    }

    updateUserDetails(
      id: email,
      score: score,
      questionNumbers: questions.length - skipped,
      correctAnswers: correct,
      catName: questions[0].name,
      questionlength: questions.length,
      difficulty: diffiuclty,
      date: DateTime.now(),
    );

    playSound();

    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/teal.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    HomePage.id,
                    arguments: email,
                  );
                },
              ),
              const SizedBox(width: 5),
            ],
          ),
          body: Column(
            children: [
              Center(
                child: ScoreWidget(score: score),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Results",
                          style: TextStyle(
                            color: const Color(0xff999999).withOpacity(0.6),
                            fontSize: 20,
                            fontFamily: kFontText,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: DashedCircularProgressBar.aspectRatio(
                            aspectRatio: 3.3,
                            valueNotifier: _valueNotifier,
                            progress: (correct * 100) / totalQuestions,
                            maxProgress: 100,
                            corners: StrokeCap.butt,
                            foregroundColor: const Color(0xFF008080),
                            backgroundColor: const Color(0xffeeeeee),
                            foregroundStrokeWidth: 13,
                            backgroundStrokeWidth: 13,
                            animation: true,
                            child: Center(
                              child: ValueListenableBuilder(
                                valueListenable: _valueNotifier,
                                builder: (_, double value, __) => Text(
                                  '${value.toInt()}%',
                                  style: TextStyle(
                                    color: const Color(0xFF008080),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23,
                                    fontFamily: kFontText,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Quiz Analysis ",
                          style: TextStyle(
                            color: const Color(0xff999999).withOpacity(0.6),
                            fontSize: 20,
                            fontFamily: kFontText,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            AnaylsesWidget(
                              number: totalQuestions,
                              label: "Total Questions",
                              textColor: const Color(0xffA42FC1),
                              containerColor: const Color(0xffA42FC1),
                            ),
                            const Spacer(flex: 1),
                            AnaylsesWidget(
                              number: skipped,
                              label: "Skipped",
                              textColor: const Color(0xff6680DB),
                              containerColor: const Color(0xff6680DB),
                            ),
                            const Spacer(flex: 1),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            AnaylsesWidget(
                              number: correct,
                              label: "Correct",
                              textColor: const Color(0xff1F8435),
                              containerColor: const Color(0xff1F8435),
                            ),
                            const Spacer(flex: 2),
                            AnaylsesWidget(
                              number: wrong,
                              label: "Wrong",
                              textColor: const Color(0xffFA3939),
                              containerColor: const Color(0xffFA3939),
                            ),
                            const Spacer(flex: 1),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 47, left: 47, top: 20, bottom: 10),
                child: MaterialButton(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        child: QuestionPage(
                          catId: catId,
                          difficulty: diffiuclty,
                          questionNumber: questions.length.toString(),
                          type: type,
                          email: email,
                        ),
                        type: PageTransitionType.topToBottom,
                        duration: const Duration(milliseconds: 300),
                      ),
                    );
                  },
                  height: 51,
                  minWidth: double.infinity,
                  color: kPrimaryColor,
                  child: const Text(
                    "Play again",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: CorrectionUi(
                        playerSlectedResponses: playerSelectedResponses,
                        playerResults: playerResults,
                        controller: CountDownController(),
                        questions: questions,
                        questionsNumber: questions.length,
                        type: type,
                      ),
                      type: PageTransitionType.bottomToTop,
                      duration: const Duration(milliseconds: 300),
                    ),
                  );
                },
                child: Text(
                  "Check Correct Answers",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w300,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
