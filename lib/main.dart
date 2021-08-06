import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quizz/QuizBrain.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizz Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizzPage(),
    );
  }
}

class QuizzPage extends StatefulWidget {
  QuizzPage({Key? key}) : super(key: key);

  @override
  _QuizzPageState createState() => _QuizzPageState();
}

class _QuizzPageState extends State<QuizzPage> {
  QuizBrain quizBrain = QuizBrain();

  void validateNextQuestion(bool userOption) {
    bool isNext = quizBrain.checkQuestion(userOption);
    setState(() {});

    if (!isNext) {
      Alert(
        context: context,
        title: "Quizz done !!",
        desc: " You've got ${quizBrain.quizAccuracy()}% ",
        style: AlertStyle(
          isCloseButton: false,
          isOverlayTapDismiss: false,
        ),
        buttons: [
          DialogButton(
            child: Text(
              'Restart',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              quizBrain.restart();
              setState(() {});
            },
          )
        ],
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    quizBrain.currentTextQuestion(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade200,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    validateNextQuestion(true);
                  },
                  child: Text('True'),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.all(20),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      Colors.green,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    validateNextQuestion(false);
                  },
                  child: Text('False'),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.all(20),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      Colors.red,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: quizBrain.listScore,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
