import 'package:flutter/material.dart';
import 'package:huawei_account/huawei_account.dart';

class Home extends StatelessWidget {
  final AuthAccount contentInfo;
  Home(this.contentInfo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('Hi'),),
    );
  }
}
