import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../dashboard.dart';

class LoginBodyState extends StatefulWidget {
  @override
  _LoginBodyStateState createState() => _LoginBodyStateState();
}

class _LoginBodyStateState extends State<LoginBodyState> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;

  void _showDialog(title, body) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(body),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Form(
      key: _formKey,
      child: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/login.svg",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "Your Email",
                onChanged: (value) {
                  _email = value;
                },
              ),
              RoundedPasswordField(
                onChanged: (value) {
                  _password = value;
                },
              ),
              RoundedButton(
                text: "LOGIN",
                press: () async {
                  final form = _formKey.currentState;
                  form.save();

                  final storage = new FlutterSecureStorage();

//                  try {
//                    String token = await storage.read(key: 'access_token');
//                    Response response = await Dio(BaseOptions(
//                      connectTimeout: 5000,
//                      receiveTimeout: 100000,
//                      // 5s
//                      headers: {
//                        HttpHeaders.userAgentHeader: "dio",
//                        HttpHeaders.authorizationHeader: 'Bearer $token'
//                      },
//                      contentType: Headers.jsonContentType,
//                      // Transform the response data to a String encoded with UTF8.
//                      // The default value is [ResponseType.JSON].
//                      responseType: ResponseType.plain,
//                    )).get(
//                        'http://ec2-13-229-60-36.ap-southeast-1.compute.amazonaws.com/api/commons'
//                    );
//                    print(jsonDecode(response.toString()));
//                  } catch (e) {
//                    print(e);
//                  }
//                  return;

                  if (form.validate()) {
                    try {
                      Response response = await Dio().post(
                          'http://ec2-13-229-60-36.ap-southeast-1.compute.amazonaws.com/api/auth/login',
                          data: {
                            'email': _email,
                            'password': _password
                          }
                      );

                      if(response.statusCode == 200) {
                        Map data = jsonDecode(response.toString());

                        await storage.write(key: 'access_token', value: data['access_token']);
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                            builder: (BuildContext context) => Dashboard()
                        ), (route) => false);
//
//                      print(await storage.read(key: 'access_token'));
                      } else {
                        _showDialog('Alert', 'Email or password is incorrect!');
                      }
                    } catch(e) {
                      _showDialog('Alert', 'Login failed!');
                    }
                  }
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

