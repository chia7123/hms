import 'package:flutter/material.dart';
import 'package:huawei_account/huawei_account.dart';
import 'package:sign_in_hms/main.dart';
class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}
class _LoginDemoState extends State<LoginDemo> {
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Account Login'),
          ),
          body: Center(
            child: InkWell(
              onTap: signInWithHuaweiAccount,
              child: Ink.image(
                image: AssetImage('assets/images/icon.jpg'),
                // fit: BoxFit.cover,
                width: 110,
                height: 110,
              ),
            ),
          )),
    );
  }
  void signInWithHuaweiAccount() async {
    AccountAuthParamsHelper authParamHelper = new AccountAuthParamsHelper();
    authParamHelper
      ..setIdToken()
      ..setAuthorizationCode()
      ..setAccessToken()
      ..setProfile()
      ..setEmail()
      ..setScopeList([Scope.openId, Scope.email, Scope.profile])
      ..setRequestCode(8888);
    try {
      final AuthAccount accountInfo =
          await AccountAuthService.signIn([AccountAuthParamsHelper h : authParamHelper]);
      setState(() {
        String accountDetails = accountInfo.displayName;
        String user = accountInfo.displayName;
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MyApp(user)));
      });
    } on Exception catch (exception) {
      print(exception.toString());
      print("error: " + exception.toString());
    }
  }
  Future signOut() async {
    final signOutResult = await AccountAuthService.signOut();
    if (signOutResult) {
      Route route = MaterialPageRoute(builder: (context) => MyApp('ac'));
      Navigator.pushReplacement(context, route);
      print('You are logged out');
    } else {
      print('Login_provider:signOut failed');
    }
  }
 
 
}