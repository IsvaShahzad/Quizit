import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/widgets/MultipleCorrectionWidget.dart';
import 'package:quiz_app/widgets/booleanCorrectionWidget.dart';
import 'package:quiz_app/widgets/countDownTimed.dart';
import 'package:quiz_app/widgets/question_indicator.dart';

class CorrectionUi extends StatefulWidget {
  const CorrectionUi({
    super.key,
    required this.controller,
    required this.questions,
    required this.questionsNumber,
    required this.type,
    required this.playerResults,
    required this.playerSlectedResponses,
  });

  final CountDownController controller;
  final List<Question> questions;
  final int questionsNumber;
  final List<String> playerResults;
  final List<Map<String, dynamic>> playerSlectedResponses;
  final String type;

  @override
  State<CorrectionUi> createState() => _CorrectionUi();
}

class _CorrectionUi extends State<CorrectionUi> {
  int questionSelectedIndex = 0;

  String? playerResponse;

  void nextQuestion() {
    if (questionSelectedIndex < widget.questionsNumber - 1) {
      setState(() {
        questionSelectedIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double questionAreaHeight = widget.questionsNumber == 10
        ? screenHeight * 0.30
        : screenHeight * 0.25;

    String question = widget.questions[questionSelectedIndex].question
        .replaceAll("&#039;", "'")
        .replaceAll("&quot;", '"')
        .replaceAll("&amp;", "&")
        .replaceAll("&ldquo;", '"')
        .replaceAll("&rdquo;", '"')
        .replaceAll("&lsquo;", "'")
        .replaceAll("&rsquo;", "'");

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Container(
            margin: EdgeInsets.only(right: screenWidth * 0.05),
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
                nextQuestion();
              },
              child: Text(
                questionSelectedIndex == widget.questionsNumber - 1
                    ? ""
                    : "Next",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: "Montserrat",
                ),
              ),
            ),
          ),
          const SizedBox(width: 35),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: questionSelectedIndex == 0
              ? null
              : () {
            setState(() {
              questionSelectedIndex--;
            });
          },
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/teal2.png",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.05),
            child: Column(
              children: [
                Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(23.9),
                  child: Container(
                    width: double.infinity,
                    height: questionAreaHeight,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(23.9),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: -55,
                          right: 1,
                          left: 1,
                          child: Column(
                            children: [
                              Center(
                                child: CountDownTimer(
                                  duration: 0,
                                  controller: widget.controller,
                                  questionSelectedIndex: questionSelectedIndex,
                                  onComplete: () {},
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 22),
                                child: Row(
                                  children: [
                                    for (int i = 0;
                                    i < (widget.questions.length == 10 ? widget.questions.length / 2 : widget.questions.length);
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
                              const SizedBox(height: 5),
                              if (widget.questionsNumber == 10)
                                Padding(
                                  padding: const EdgeInsets.only(left: 22),
                                  child: Row(
                                    children: [
                                      for (int i = 5; i < widget.questionsNumber; i++)
                                        QuestionIndicator(
                                          label: "${i + 1}",
                                          color: questionSelectedIndex == i
                                              ? const Color(0xFF008080)
                                              : const Color(0xffE5E5E5),
                                        ),
                                    ],
                                  ),
                                ),
                              const SizedBox(height: 8),
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
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                widget.type == "boolean"
                    ? BooleanCorrectionWidget(
                  wrongAnswers: widget.questions[questionSelectedIndex].incorrectAnswers,
                  responseSelectedIndex: -1,
                  onResponseSelected: (response) {
                    playerResponse = response;
                  },
                )
                    : MultipleCorrectionWidget(
                  wrongAnswers: widget.questions[questionSelectedIndex].incorrectAnswers,
                  responseSelectedIndex: widget.playerSlectedResponses[questionSelectedIndex]["playerSelectedResponses"],
                  answers: widget.playerSlectedResponses[questionSelectedIndex]["answers"],
                  onResponseSelected: (response) {
                    playerResponse = response;
                  },
                ),
                const Spacer(),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: kPrimaryColor,
                  textColor: Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 50,
                  child: const Center(
                    child: Text(
                      "Back to Results",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
