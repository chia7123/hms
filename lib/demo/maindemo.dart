import 'package:flutter/material.dart';
import 'package:huawei_account/huawei_account.dart';
import 'package:huawei_analytics/huawei_analytics.dart';
import 'package:sign_in_hms/demo/login.dart';
import 'quiz.dart';
import 'result.dart';
void main() {
  runApp(
    MaterialApp(
      title: 'TechQuizApp',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginDemo(),
        '/second': (context) => MyApp(''),
      },
    ),
  );
}
class MyApp extends StatefulWidget {
  final String userName;
  MyApp(this.userName);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}
class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;
  int _totalScore = 0;
  String name;
  final HMSAnalytics _hmsAnalytics = new HMSAnalytics();
  @override
  void initState() {
    _enableLog();
    _predefinedEvent();
    super.initState();
  }
  Future<void> _enableLog() async {
    _hmsAnalytics.setUserId(widget.userName);
    await _hmsAnalytics.enableLog();
  }
  void _restartQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }
  void _logoutQuiz() async {
    final signOutResult = await AccountAuthService.signOut();
    if (signOutResult) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginDemo()));
 
      print('You are logged out');
    } else {
      print('signOut failed');
    }
  }
  void _predefinedEvent() async {
    String name = HAEventType.SIGNIN;
    dynamic value = {HAParamType.ENTRY: 06534797};
    await _hmsAnalytics.onEvent(name, value);
    print("Event posted");
  }
  void _customEvent(int index, int score) async {
    String name = "Question$index";
    dynamic value = {'Score': score};
    await _hmsAnalytics.onEvent(name, value);
  }
  static const _questions = [
    {
      'questionText': 'ROM stands for?',
      'answers': [
        {'text': 'Read only memory', 'Score': 10},
        {'text': 'Reading only memory', 'Score': 0},
        {'text': 'Remote only memory', 'Score': 0},
        {'text': 'Right only memory', 'Score': 0},
      ]
    },
    {
      'questionText': 'RAM stands for?',
      'answers': [
        {'text': 'Random after memory', 'Score': 0},
        {'text': 'Rom and Memory', 'Score': 0},
        {'text': 'Read and memory', 'Score': 0},
        {'text': 'Random access memory', 'Score': 10},
      ]
    },
    {
      'questionText': 'What\'s cache memory?',
      'answers': [
        {'text': 'Permanent memory', 'Score': 0},
        {'text': "Temporary memory", 'Score': 10},
        {'text': 'Garbage memory', 'Score': 0},
        {'text': 'Unused memory', 'Score': 0},
      ]
    },
    {
      'questionText': 'Printer is input device?',
      'answers': [
        {'text': 'Input device', 'Score': 0},
        {'text': 'Output device', 'Score': 10},
        {'text': 'Both', 'Score': 0},
        {'text': 'Non of these', 'Score': 0},
      ]
    }
  ];
  Future<void> _answerQuestion(int score) async {
    _totalScore += score;
 
    if (_questionIndex < _questions.length) {
      print('Iside if  $_questionIndex');
      setState(() {
        _questionIndex = _questionIndex + 1;
      });
      print('Current questionIndex $_questionIndex');
    } else {
      print('Inside else $_questionIndex');
    }
    _customEvent(_questionIndex, score);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Wel come ' + widget.userName),
      ),
      body: _questionIndex < _questions.length
          ? Quiz(
              answerQuestion: _answerQuestion,
              questionIndex: _questionIndex,
              questions: _questions,
            )
          : Result(widget.userName, _totalScore, _restartQuiz, _logoutQuiz),
    ));
  }
}