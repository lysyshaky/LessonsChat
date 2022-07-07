import 'dart:ffi';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lessons_chat/screens/login_screen.dart';
import 'package:lessons_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:lessons_chat/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = '/welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  int count;

  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    controller.forward();
    controller.addListener(() {
      setState(() {});
      count = (controller.value * 100).round();
    });
  }

//@override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color.fromARGB(255, 1, 61, 152).withOpacity(controller.value),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 200.0,
            ),
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: animation.value * 60,
                  ),
                ),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.w900,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Lessons Chat',
                        speed: const Duration(milliseconds: 400),
                      )
                    ],
                    totalRepeatCount: 1,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 42.0,
            ),
            buttonWidet(
                colour: Colors.lightBlueAccent,
                text: Text('Login'),
                OnPress: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                }),
            buttonWidet(
                colour: Colors.blueAccent,
                text: Text('Register'),
                OnPress: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                }),
            SizedBox(
              height: 250.0,
            ),
            Center(
              child: Text(
                '$count%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
