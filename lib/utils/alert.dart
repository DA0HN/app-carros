import 'package:flutter/material.dart';

alert(BuildContext context, String msg) {
  showDialog(
    barrierDismissible: false, // não fecha se clicar fora do cancelar
    context: context,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text("Carros"),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
                print("OK!");
              },
            )
          ],
        ),
      );
    },
  );
}
