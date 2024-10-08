import 'package:quiz_app/models/question.dart';

import '../api_helper/api.dart';

class GetQuestionsService {
  Future<List<Question>> getQuestions({
    required String type,
    required String difficulty,
    required String questionNumbers,
    required String catId,
  }) async {
    Map<String, dynamic> data = await Api().get(

      //open trivia database api used
        url:
            "https://opentdb.com/api.php?amount=$questionNumbers&category=$catId&difficulty=$difficulty&type=$type");
    List<Question> questions = [];

    for (int i = 0; i < data["results"].length; i++) {
      questions.add(Question.fromJson(data["results"][i]));
    }

    return questions;
  }
}
