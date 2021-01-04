import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  final BuildContext context;
  final String title;
  String message;
  String positive;
  String negative;
  GestureTapCallback positiveCallback;
  GestureTapCallback negativeCallback;

  AlertDialog _alertDialog;

  CustomDialog({@required this.context, @required this.title, this.message, this.positive, this.positiveCallback, this.negative, this.negativeCallback}) {
    final okButton = FlatButton(
      child: Text(positive),
      onPressed: positiveCallback,
    );

    if (negative == null) {
      _alertDialog = AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [okButton],
      );
    } else {
      final cancelButton = FlatButton(
        child: Text(negative),
        onPressed: negativeCallback,
      );

      _alertDialog = AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [okButton, cancelButton],
      );
    }
  }

  Future<void> show() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) {
        return _alertDialog;
      },
    );
  }
}