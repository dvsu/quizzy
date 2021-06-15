import 'question.dart';

class QuestionBank {
  int _questionNumber = 0;

  List<Question> _questionList = [
    Question(question: '1+1 = 2', answer: true),
    Question(question: '11*20 = 12', answer: false),
    Question(question: '11/5 = 2', answer: false),
    Question(question: '12^2 = 144', answer: true),
  ];

  void checkNextQuestion() {
    if (_questionNumber < _questionList.length - 1) {
      _questionNumber++;
    }
  }

  String? getQuestion() {
    return _questionList[_questionNumber].questionText;
  }

  bool? getAnswer() {
    return _questionList[_questionNumber].questionAnswer;
  }
}
