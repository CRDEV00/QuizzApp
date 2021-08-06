import 'package:quizz/Question.dart';
import 'package:flutter/material.dart';

class QuizBrain {
  List<Icon> _listScore = [];
  int _correctAns = 0;
  //this prop is private so it just can be access by this class
  List<Question> _questions = [
    Question(questionText: 'Question 1', questionAnwer: true),
    Question(questionText: 'Question 2', questionAnwer: false),
    Question(questionText: 'Question 3', questionAnwer: false),
    Question(questionText: 'Question 4', questionAnwer: true),
  ];

  int _currentQuestion = 0;

  get listScore {
    return this._listScore;
  }

  bool nextQuestion() {
    if (_currentQuestion < _questions.length - 1) {
      _currentQuestion++;
      return true;
    } else {
      return false;
    }
  }

  String currentTextQuestion() {
    return _questions[_currentQuestion].questionText;
  }

  bool curretAnswerQuestion() {
    return _questions[_currentQuestion].questionAnwer;
  }

  bool checkQuestion(bool userOption) {
    if (userOption == curretAnswerQuestion()) {
      print('nicee');
      _correctAns++;
      _listScore.add(
        Icon(
          Icons.check,
          color: Colors.green,
        ),
      );
    } else {
      print('ups');
      _listScore.add(
        Icon(
          Icons.close,
          color: Colors.red,
        ),
      );
    }
    return nextQuestion();
  }

  num quizAccuracy() {
    return (_correctAns * 100) / _questions.length;
  }

  void restart() {
    _correctAns = 0;
    _listScore = [];
    _currentQuestion = 0;
  }
}
