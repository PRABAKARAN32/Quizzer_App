import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'question_brain.dart';

QuestionBrain questionBrain = QuestionBrain();

void main() {
  runApp(const Quizzer());
}

class Quizzer extends StatelessWidget {
  const Quizzer({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override

  /*List<String> question = [
    'What is Your name',
    'How are You',
    'Are You Legend'
  ];
  List<bool> answer = [true, true, true];*/
  List<Icon> icon = [];

  void CheckAnswer(bool UserChoice) {
    bool correctanswer = questionBrain.getAnswer();
    setState(() {
      if (questionBrain.isFinished() == true) {
        //This is the code for the basic alert from the docs for rFlutter Alert:
        //Alert(context: context, title: "RFLUTTER", desc: "Flutter is awesome.").show();

        //Modified for our purposes:
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();

        questionBrain.reset();

        icon = [];
      } else {
        if (correctanswer == UserChoice) {
          icon.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
          questionBrain.getqueation_no();
        } else {
          icon.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
          questionBrain.getqueation_no();
        }
      }
    });
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  questionBrain.getQuestion(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0, color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Container(
                color: Colors.green,
                child: TextButton(
                  onPressed: () {
                    CheckAnswer(true);
                  },
                  child: Center(
                    child: Text(
                      'True',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ),
              ),
              /**/
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Container(
                color: Colors.red,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      CheckAnswer(false);
                    });
                  },
                  child: Center(
                    child: Text(
                      'False',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SafeArea(child: Row(children: icon))
        ],
      ),
    );
  }
}
