import 'package:flutter/material.dart';

class TextError extends StatelessWidget {
  String _msg;

  Function onPressed;

  TextError(this._msg, {this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onPressed,
        child: Text(
          _msg,
          style: TextStyle(
            fontSize: 22,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
