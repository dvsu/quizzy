import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'question_bank.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Quizzy',
    home: QuizPage(),
  ));
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  QuestionBank questionBank = QuestionBank();

  static Color mainThemeColor = Color(0xffFFBD69);
  static Color subThemeColor = Color(0xff543864);
  static Color mainContentColor = Color(0xff202040);
  static Color subContentColor = Color(0xffFF6363);

  Color pageBackgroundColor = mainThemeColor;
  Color questionColor = mainContentColor;
  Color trueButtonColor = subThemeColor;
  Color trueButtonOverlayColor = Color(0xff9172a3);
  Color falseButtonColor = subContentColor;
  Color falseButtonOverlayColor = Color(0xfff79999);
  Color correctIconColor = subThemeColor;
  Color falseIconColor = subContentColor;

  Container questionText() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        questionBank.getQuestion() ?? '',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: questionColor,
          fontSize: 40.0,
          fontFamily: 'Athiti',
        ),
      ),
    );
  }

  Padding answerButton(
      {String? buttonText,
      bool? userAnswer,
      Color? backgroundColor,
      Color? overlayColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 25.0,
      ),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            if (questionBank.getAnswer() == userAnswer) {
              scoreKeeper.add(correctIcon());
            } else {
              scoreKeeper.add(falseIcon());
            }
            questionBank.checkNextQuestion();
          });
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (states) => overlayColor,
          ),
        ),
        child: Text(
          buttonText ?? '',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            fontFamily: 'TextMeOne',
          ),
        ),
      ),
    );
  }

  Padding trueButton() {
    return answerButton(
        buttonText: 'TRUE',
        userAnswer: true,
        backgroundColor: trueButtonColor,
        overlayColor: trueButtonOverlayColor);
  }

  Padding falseButton() {
    return answerButton(
        buttonText: 'FALSE',
        userAnswer: false,
        backgroundColor: falseButtonColor,
        overlayColor: falseButtonOverlayColor);
  }

  Icon correctIcon() {
    return Icon(
      Icons.check_circle_rounded,
      color: correctIconColor,
      size: 30.0,
    );
  }

  Icon falseIcon() {
    return Icon(
      Icons.cancel_rounded,
      color: falseIconColor,
      size: 30.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 15,
              child: questionText(),
            ),
            Expanded(
              flex: 3,
              child: trueButton(),
            ),
            Expanded(
              flex: 3,
              child: falseButton(),
            ),
            SizedBox(
              height: 50.0,
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: scoreKeeper),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
