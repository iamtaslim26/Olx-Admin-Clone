import 'package:flutter/material.dart';
import 'package:olx_admin_practice_app/Login/login_page.dart';

class ErrorDialogBox extends StatelessWidget {

  final String message;

  const ErrorDialogBox({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content:Text(message),
      actions: [
        ElevatedButton(
          onPressed: (){
            Route newRoute = MaterialPageRoute(
                builder: (context) => LoginPage()
            );
            Navigator.pushReplacement(context, newRoute);
          },
          child: Text("Ok"),
        ),
      ],
    );
  }
}
