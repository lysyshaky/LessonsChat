import 'package:flutter/material.dart';

class buttonWidet extends StatelessWidget {
  buttonWidet({
    this.colour,
    this.text,
    @required this.OnPress,
  });

  final Color colour;
  final Text text;
  final Function OnPress;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: OnPress,
          minWidth: 200.0,
          height: 42.0,
          child: text,
        ),
      ),
    );
  }
}
