import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/services/get_questions.dart';
import 'package:quiz_app/widgets/loading_widget.dart';
import 'package:quiz_app/widgets/questions_display_widget.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({
    super.key,
    required this.catId,
    required this.difficulty,
    required this.questionNumber,
    required this.type,
    required this.email,
  });

  final String difficulty, type, catId, questionNumber, email;
  static String id = "questionPage";

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final CountDownController controller = CountDownController();

  List<Question> questions = [];

  int selectedResponse = -1;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/teal.png"),
            fit: BoxFit.cover, // Ensures the image covers the entire container

          ),
        ),
        child: FutureBuilder(
          future: GetQuestionsService().getQuestions(
              type: widget.type,
              difficulty: widget.difficulty,
              questionNumbers: widget.questionNumber,
              catId: widget.catId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingWidget(
                color: Color(0xFF6666),
              );
            } else if (snapshot.hasData) {
              questions = snapshot.data!;

              return questions.isNotEmpty
                  ? QuestionUi(
                      email: widget.email,
                      controller: controller,
                      questions: questions,
                      questionsNumber: int.parse(widget.questionNumber),
                      type: widget.type,
                      difficulty: widget.difficulty,
                      catId: widget.catId,
                      questionNumber: widget.questionNumber,
                    )
                  : Scaffold(
                      backgroundColor: Color(0xFF8080),
                      body: Container(
                        height: 200,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                            vertical: 200, horizontal: 30),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 25),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 4,
                              offset: const Offset(5, 5),
                            )
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "There is no data for this type of questions",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  right: 15,
                                  left: 15,
                                  bottom: 15,
                                  top: 0,
                                ),
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: kPrimaryColor,
                                ),
                                child: const Center(
                                  child: Text(
                                    "Change settings",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
            } else {
              return Text(snapshot.error.toString());
            }
          },
        ),
      ),
    );
  }
}
