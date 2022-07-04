import 'package:flutter/material.dart';
import 'package:lessons_chat/screens/welcome_screen.dart';
import 'package:lessons_chat/screens/login_screen.dart';
import 'package:lessons_chat/screens/registration_screen.dart';
import 'package:lessons_chat/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lessons_chat/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.black54),
          ),
        ),
        home: WelcomeScreen(),
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          ChatScreen.id: (context) => ChatScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
        });
  }
}
