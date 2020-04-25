import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {

  String _text;
  Function _onPressed;

  AppButton(this._text, this._onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      child: RaisedButton(
        color: Colors.blue,
        child: Text(
          _text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        onPressed: _onPressed,
      ),
    );
  }
}
