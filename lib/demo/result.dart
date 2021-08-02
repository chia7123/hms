import 'package:flutter/material.dart';
class Result extends StatelessWidget {
  final int resulScore;
  final Function restarthandler, _logoutQuiz;
  final String userName;
  Result(this.userName, this.resulScore, this.restarthandler, this._logoutQuiz);
  String get resultPhrase {
    String resultText;
    if (resulScore <= 10) {
      resultText = '$userName is technically not strong';
    } else if (resulScore <= 20) {
      resultText = '$userName is technically good';
    } else if (resulScore <= 30) {
      resultText = '$userName is technically very good';
    } else {
      resultText = '$userName is technically excellent';
    }
    return resultText;
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          TextButton(
            child: Text('Restart again', style: TextStyle(fontSize: 22)),
            style: TextButton.styleFrom(primary: Colors.black38),
            onPressed: restarthandler,
          ),
          TextButton(
            child: Text('Logout', style: TextStyle(fontSize: 22)),
            style: TextButton.styleFrom(primary: Colors.black38),
            onPressed: _logoutQuiz,
          ),
        ],
      ),
    );
  }
}