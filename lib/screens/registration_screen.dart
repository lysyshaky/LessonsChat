import 'package:lessons_chat/screens/chat_screen.dart';
import 'package:lessons_chat/screens/login_screen.dart';
import 'package:lessons_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:lessons_chat/components/rounded_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lessons_chat/constants.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = '/registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 1, 61, 152),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            Center(
              child: SizedBox(
                width: 250.0,
                child: TextLiquidFill(
                  text: 'Lessons Chat',
                  waveColor: Colors.white,
                  boxBackgroundColor: Color.fromARGB(255, 1, 61, 152),
                  textStyle: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                  boxHeight: 60.0,
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your email',
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your password',
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            buttonWidet(
                colour: Colors.blueAccent,
                text: Text('Register'),
                OnPress: () {
                  Navigator.pushNamed(context, ChatScreen.id);
                }),
          ],
        ),
      ),
    );
  }
}
