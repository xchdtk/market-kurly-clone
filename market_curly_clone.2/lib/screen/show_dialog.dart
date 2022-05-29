import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showDialogAlertMoveScroll(context, controller, title, onPressed) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          actions: [
            CupertinoDialogAction(
                child: const Text("확인"), onPressed: onPressed),
          ],
        );
      });
}

void showDialogAlert(context, title, onPressed) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          actions: [
            CupertinoDialogAction(
                child: const Text("확인"), onPressed: onPressed),
          ],
        );
      });
}
