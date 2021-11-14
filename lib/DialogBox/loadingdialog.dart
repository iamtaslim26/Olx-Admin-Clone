import 'package:flutter/material.dart';
import 'package:olx_admin_practice_app/loadingWidget.dart';

class LoadingDialogBox extends StatelessWidget {

  final String message;

  const LoadingDialogBox({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize:  MainAxisSize.min,
        children: [
          Center(child: circularProgress()),

          SizedBox(height: 10,),
          Text("Please Wait")

        ],
      ),
    );
  }
}
