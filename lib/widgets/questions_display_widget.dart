import 'package:audioplayers/audioplayers.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/models/question.dart';

import 'package:quiz_app/widgets/boolean_response_widget.dart';
import 'package:quiz_app/widgets/countDownTimed.dart';
import 'package:quiz_app/widgets/multiple_response_widget.dart';
import 'package:quiz_app/widgets/question_indicator.dart';
import 'package:quiz_app/widgets/soundWidget.dart';

import '../screens/home_page.dart';
import '../screens/results_page.dart';

class QuestionUi extends StatefulWidget {
  const QuestionUi({
    super.key,
    required this.controller,
    required this.questions,
    required this.questionsNumber,
    required this.type,
    required this.email,
    required this.catId,
    required this.difficulty,
    required this.questionNumber,
  });

  final CountDownController controller;
  final List<Question> questions;
  final int questionsNumber;
  final String type, email, catId, questionNumber, difficulty;

  @override
  State<QuestionUi> createState() => _QuestionUiState();
}

class _QuestionUiState extends State<QuestionUi> {
  final player = AudioPlayer();
  List<String> playerResponses = [];
  List<Map<String, dynamic>> playerSelectedResponsess = [];
  int questionSelectedIndex = 0;
  int responseSelectedIndex = -1;
  String? playerResponse;
  bool sound = true;

  Future<void> playSound() async {
    String soundPath =
        "sounds/analog-timer-60-sec-2-startof-171599.mp3";
    await player.play(AssetSource(soundPath));
  }

  void nextQuestion(List<dynamic> answers, String? response) async {
    await player.stop();
    if (questionSelectedIndex < widget.questionsNumber) {
      setState(() {
        checkPlayerResponse(response, answers);
        questionSelectedIndex++;
        widget.controller.start();
        responseSelectedIndex = -1;
        playerResponse = null;
      });
    }
    playSound();
  }

  void update(int index) {
    responseSelectedIndex = index;
  }

  void checkPlayerResponse(String? response, answers) {
    playerSelectedResponsess.insert(questionSelectedIndex,
        {"playerSelectedResponses": responseSelectedIndex, "answers": answers});

    if (response == widget.questions[questionSelectedIndex].correctAnswer) {
      playerResponses.insert(questionSelectedIndex, "true");
    } else if (response == null) {
      playerResponses.insert(questionSelectedIndex, "null");
    } else {
      playerResponses.insert(questionSelectedIndex, "false");
    }
  }

  @override
  void initState() {
    super.initState();
    playSound();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> wrongAnswers =
        widget.questions[questionSelectedIndex].incorrectAnswers;
    String correctAnswer =
        widget.questions[questionSelectedIndex].correctAnswer;

    List<dynamic> answers = [...wrongAnswers, correctAnswer];

    String question = widget.questions[questionSelectedIndex].question
        .replaceAll("&#039;", "'")
        .replaceAll("&quot;", '"')
        .replaceAll("&amp;", "&")
        .replaceAll("&ldquo;", '"')
        .replaceAll("&rdquo;", '"')
        .replaceAll("&lsquo;", "'")
        .replaceAll("&rsquo;", "'");
    if (questionSelectedIndex != widget.questionsNumber - 1) {
      answers.shuffle();
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SoundWidget(
          player: player,
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10), // Adjusted margin to prevent overflow
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white,
                  width: 1.0,
                ),
              ),
            ),
            child: InkWell(
              onTap: questionSelectedIndex == widget.questionsNumber - 1
                  ? null
                  : () {
                nextQuestion(answers, playerResponse);
              },
              child: Text(
                questionSelectedIndex == widget.questionsNumber - 1
                    ? ""
                    : "Next",
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontFamily: "Montserrat",
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20), // Adjusted padding
          child: Column(
            children: [
              Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  width: double.infinity,
                  height: widget.questionsNumber == 10 ? 250.16 : 215,
                  padding: const EdgeInsets.all(15), // Adjusted padding
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: -55,
                        right: 0,
                        left: 0,
                        child: Column(
                          children: [
                            Center(
                              child: CountDownTimer(
                                controller: widget.controller,
                                questionSelectedIndex: questionSelectedIndex,
                                duration: widget.type == "multiple" ? 30 : 15,
                                onComplete: () async {
                                  if (questionSelectedIndex ==
                                      widget.questionsNumber - 1) {
                                    checkPlayerResponse(playerResponse, answers);
                                    await player.stop();
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        duration:
                                        const Duration(milliseconds: 300),
                                        child: ResultPage(
                                          playerSelectedResponses:
                                          playerSelectedResponsess,
                                          email: widget.email,
                                          diffiuclty: widget.difficulty,
                                          playerResults: playerResponses,
                                          questions: widget.questions,
                                          type: widget.type,
                                          catId: widget.catId,
                                        ),
                                      ),
                                    );
                                  } else {
                                    nextQuestion(answers, playerResponse);
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 22),
                              child: Row(
                                children: [
                                  for (int i = 0;
                                  i <
                                      (widget.questionsNumber == 10
                                          ? widget.questionsNumber / 2
                                          : widget.questionsNumber);
                                  i++)
                                    QuestionIndicator(
                                      label: "${i + 1}",
                                      color: questionSelectedIndex == i
                                          ? const Color(0xFF008080)
                                          : const Color(0xffE5E5E5),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            if (widget.questionsNumber == 10)
                              Padding(
                                padding: const EdgeInsets.only(left: 22),
                                child: Row(
                                  children: [
                                    for (int i = 5; i < widget.questionsNumber; i++)
                                      QuestionIndicator(
                                        label: "${i + 1}",
                                        color: questionSelectedIndex == i
                                            ? const Color(0xff66b2b2)
                                            : const Color(0xffb2d8d8),
                                      ),
                                  ],
                                ),
                              ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              question,
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: "Poppins",
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              widget.type == "boolean"
                  ? BooleanResponseWidget(
                update: update,
                responseSelectedIndex: responseSelectedIndex,
                onResponseSelected: (response) {
                  playerResponse = response;
                },
              )
                  : MultipleResponseWidget(
                update: update,
                responseSelectedIndex: responseSelectedIndex,
                answers: answers,
                onResponseSelected: (response) {
                  playerResponse = response;
                },
              ),
              const Spacer(
                flex: 1,
              ),
              MaterialButton(
                onPressed: widget.questionsNumber - 1 == questionSelectedIndex
                    ? () async {
                  widget.controller.pause();
                  checkPlayerResponse(playerResponse, answers);
                  await player.stop();
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      duration: const Duration(milliseconds: 300),
                      child: ResultPage(
                        playerSelectedResponses: playerSelectedResponsess,
                        email: widget.email,
                        diffiuclty: widget.difficulty,
                        playerResults: playerResponses,
                        questions: widget.questions,
                        type: widget.type,
                        catId: widget.catId,
                      ),
                    ),
                  );
                }
                    : null,
                disabledColor: const Color(0xffBDBDBD),
                color: kPrimaryColor,
                textColor: widget.questionsNumber - 1 == questionSelectedIndex
                    ? Colors.white
                    : Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 45,
                child: const Center(
                  child: Text(
                    "Submit Quiz",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              InkWell(
                onTap: () async {
                  await player.stop();
                  Navigator.popAndPushNamed(context, HomePage.id,
                      arguments: widget.email);
                },
                child: Text(
                  "Exit",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
