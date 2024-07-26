import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/screens/question_page.dart';

import 'package:quiz_app/widgets/difficulty_container.dart';
import 'package:quiz_app/widgets/number_container.dart';
import 'package:quiz_app/widgets/typeContainer.dart';

import 'home_page.dart';

class CatSettingsPage extends StatefulWidget {
  const CatSettingsPage({
    super.key,
    required this.catId,
    required this.email,
  });

  static String id = "catSettingsPage";
  final int catId;
  final String email;

  @override
  State<CatSettingsPage> createState() => _CatSettingsPageState();
}

class _CatSettingsPageState extends State<CatSettingsPage> {
  String? difficulty;
  String? type;
  int? questionNumbers;

  int difficultySelectedindex = -1;
  int typeSelectedIndex = -1;
  int questionIndex = -1;
  final AudioPlayer player = AudioPlayer();
  final AudioPlayer player2 = AudioPlayer();

  Future<void> playSound2() async {
    String soundPath = "sounds/456601__bumpelsnake__select10.wav";
    await player2.play(AssetSource(soundPath));
  }

  Future<void> playSound() async {
    String soundPath = "sounds/click-button-app-147358.mp3";
    await player.play(AssetSource(soundPath));
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            kPrimaryColor,
            const Color(0xff006666),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFF008080),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          child: Column(
            children: [
              AppBar(
                actions: [
                  Container(
                    margin: const EdgeInsets.only(right: 0),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        if (difficulty != null &&
                            questionNumbers != null &&
                            type != null) {
                          playSound();
                          Navigator.push(
                            context,
                            PageTransition(
                              child: QuestionPage(
                                email: widget.email,
                                type: type!,
                                catId: widget.catId.toString(),
                                questionNumber: questionNumbers.toString(),
                                difficulty: difficulty!,
                              ),
                              type: PageTransitionType.rightToLeft,
                              duration: const Duration(milliseconds: 300),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Next",
                        style: TextStyle(
                          fontSize: 25 * textScaleFactor, // Responsive font size
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  )
                ],
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  onPressed: () => Navigator.popAndPushNamed(
                    context,
                    HomePage.id,
                    arguments: widget.email,
                  ),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(
                    vertical: screenSize.height * 0.02,
                    horizontal: screenSize.width * 0.03,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: screenSize.height * 0.01,
                    horizontal: screenSize.width * 0.03,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(
                        flex: 1,
                      ),
                      Text(
                        "Quiz zone",
                        style: TextStyle(
                          fontSize: 20 * textScaleFactor, // Responsive font size
                          fontFamily: 'Montserrat',
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DifficultyContainer(
                            title: "Hard",
                            color: difficultySelectedindex == 0
                                ? const Color(0xff66b2b2)
                                : const Color(0xffb2d8d8),
                            onTap: () {
                              playSound2();
                              setState(() {
                                if (difficultySelectedindex == 0) {
                                  difficultySelectedindex = -1;
                                  difficulty = null;
                                } else {
                                  difficultySelectedindex = 0;
                                  difficulty = "hard";
                                }
                              });
                            },
                          ),
                          DifficultyContainer(
                            title: "Medium",
                            color: difficultySelectedindex == 1
                                ? const Color(0xff66b2b2)
                                : const Color(0xffb2d8d8),
                            onTap: () {
                              playSound2();
                              setState(() {
                                if (difficultySelectedindex == 1) {
                                  difficultySelectedindex = -1;
                                  difficulty = null;
                                } else {
                                  difficultySelectedindex = 1;
                                  difficulty = "medium";
                                }
                              });
                            },
                          ),
                          DifficultyContainer(
                            title: "Easy",
                            color: difficultySelectedindex == 2
                                ? const Color(0xff66b2b2)
                                : const Color(0xffb2d8d8),
                            onTap: () {
                              playSound2();
                              setState(() {
                                if (difficultySelectedindex == 2) {
                                  difficultySelectedindex = -1;
                                  difficulty = null;
                                } else {
                                  difficultySelectedindex = 2;
                                  difficulty = "easy";
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenSize.height * 0.04,
                      ),
                      Text(
                        "Play Zone",
                        style: TextStyle(
                          fontSize: 20 * textScaleFactor, // Responsive font size
                          fontFamily: 'Montserrat',
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.02,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: screenSize.width * 0.02,
                          ),
                          const Icon(Icons.pending_actions),
                          SizedBox(
                            width: screenSize.width * 0.02,
                          ),
                          Text(
                            "Choose the Type of questions :",
                            style: TextStyle(
                              fontSize: 12 * textScaleFactor, // Responsive font size
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenSize.height * 0.02,
                      ),
                      TypeContainer(
                        title: "True/False",
                        color: typeSelectedIndex == 0
                            ? const Color(0xff66b2b2)
                            : const Color(0xffb2d8d8),
                        onTap: () {
                          playSound2();
                          setState(() {
                            if (typeSelectedIndex == 0) {
                              typeSelectedIndex = -1;
                              type = null;
                            } else {
                              typeSelectedIndex = 0;
                              type = "boolean";
                            }
                          });
                        },
                      ),
                      SizedBox(
                        height: screenSize.height * 0.02,
                      ),
                      TypeContainer(
                        title: "Multiple Choice",
                        color: typeSelectedIndex == 1
                            ? const Color(0xff66b2b2)
                            : const Color(0xffb2d8d8),
                        onTap: () {
                          playSound2();
                          setState(
                                () {
                              if (typeSelectedIndex == 1) {
                                typeSelectedIndex = -1;
                                type = null;
                              } else {
                                typeSelectedIndex = 1;
                                type = "multiple";
                              }
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: screenSize.height * 0.04,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: screenSize.width * 0.02,
                          ),
                          const Icon(Icons.quiz_outlined),
                          SizedBox(
                            width: screenSize.width * 0.02,
                          ),
                          Text(
                            "Choose the Number of questions :",
                            style: TextStyle(
                              fontSize: 12 * textScaleFactor, // Responsive font size
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenSize.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          NumberContainer(
                            title: "5 Questions",
                            onTap: () {
                              playSound2();
                              setState(() {
                                if (questionIndex == 0) {
                                  questionIndex = -1;
                                  questionNumbers = null;
                                } else {
                                  questionIndex = 0;
                                  questionNumbers = 5;
                                }
                              });
                            },
                            color: questionIndex == 0
                                ? const Color(0xff66b2b2)
                                : const Color(0xffb2d8d8),
                          ),
                          NumberContainer(
                            title: "10 Questions",
                            onTap: () {
                              playSound2();
                              setState(() {
                                if (questionIndex == 1) {
                                  questionIndex = -1;
                                  questionNumbers = null;
                                } else {
                                  questionIndex = 1;
                                  questionNumbers = 10;
                                }
                              });
                            },
                            color: questionIndex == 1
                                ? const Color(0xff66b2b2)
                                : const Color(0xffb2d8d8),
                          ),
                        ],
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
