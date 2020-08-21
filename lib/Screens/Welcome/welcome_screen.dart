import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Welcome/components/body.dart';
import 'package:flutter_auth/Screens/dashboard.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoginState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }

  checkLoginState() async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'access_token');

    if(token != null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (BuildContext context) => Dashboard()
      ), (route) => false);
    }
  }
}
