import 'package:flutter/material.dart';
import 'package:huawei_account/huawei_account.dart';
import 'package:sign_in_hms/home.dart';

void main() {
   runApp(MyApp());
 }
  
 class MyApp extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       title: 'AccountKit',
       theme: ThemeData(
         primarySwatch: Colors.blue,
         visualDensity: VisualDensity.adaptivePlatformDensity,
       ),
       home: MyHomePage(title: 'Account Kit'),
     );
   }
 }
  
 class MyHomePage extends StatefulWidget {
   MyHomePage({Key key, this.title}) : super(key: key);
   final String title;
  
   @override
   _MyHomePageState createState() => _MyHomePageState();
 }
  
 class _MyHomePageState extends State<MyHomePage> {
   List<String> logs = [];
  
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text(widget.title),
       ),
       body: new Stack(
         fit: StackFit.expand,
         children: <Widget>[
           new Image(
             image: new AssetImage("assets/images/mobile.png"),
             fit: BoxFit.cover,
           ),
           new Form(
               child: new Container(
             padding: const EdgeInsets.all(60.0),
             child: new Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 new TextField(
                   decoration: new InputDecoration(
                       labelText: "Enter Email", focusColor: Colors.white),
                   keyboardType: TextInputType.emailAddress,
                 ),
                 new TextField(
                   decoration: new InputDecoration(labelText: "Enter Password"),
                   keyboardType: TextInputType.text,
                 ),
                 new Padding(
                   padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                 ),
                 new MaterialButton(
                   minWidth: 100.0,
                   height: 40.0,
                   onPressed: () => {print('object')},
                   color: Colors.red,
                   textColor: Colors.white,
                   child: Text("LOGIN", style: TextStyle(fontSize: 20)),
                 ),
                 new Padding(
                   padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                 ),
                 Text(
                   '( OR )',
                   textAlign: TextAlign.center,
                   overflow: TextOverflow.ellipsis,
                   style: TextStyle(
                       fontWeight: FontWeight.bold,
                       color: Colors.white,
                       fontSize: 15),
                 ),
                 new Padding(
                   padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                 ),
                 new MaterialButton(
                   child: Text(
                     " HUAWEI SIGN IN",
                     style: TextStyle(fontSize: 20),
                   ),
                   minWidth: 100.0,
                   height: 40.0,
                   onPressed: _onSinIn,
                   color: Colors.red,
                   textColor: Colors.white,
                   padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                 )
               ],
             ),
           ))
         ],
       ),
     );
   }
  
   void _onSinIn() async {
     AccountAuthParamsHelper authParamHelper = new AccountAuthParamsHelper();
     authParamHelper
       ..setIdToken()
       ..setAuthorizationCode()
       ..setAccessToken()
       ..setProfile()
       ..setEmail()
       ..setScopeList([Scope.openId]);
     try {
       final AuthAccount accountInfo = await AccountAuthService.signIn(authParamHelper);
       setState(() {
         Navigator.push(
           context,
           MaterialPageRoute(
               builder: (context) => Home(accountInfo)),
         );
         _showToast(context);
         logs.add(accountInfo.displayName);
       });
     } on Exception catch (exception) {
       print(exception.toString());
       logs.add(exception.toString());
     }
   }
  
   void _showToast(BuildContext context) {
     final scaffold = Scaffold.of(context);
     scaffold.showSnackBar(
       SnackBar(
         content: const Text('Successfully Loged In'),
         action: SnackBarAction(
             label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
       ),
     );
   }
 }