import 'package:flutter/material.dart';

class Common {
  static showMessage(scaffoldKey, String message,
      [Duration duration = const Duration(seconds: 4)]) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(message),
      duration: duration,
      action: new SnackBarAction(
          label: 'CLOSE',
          onPressed: () => scaffoldKey.currentState.removeCurrentSnackBar()),
    ));
  }

  static showInfo(scaffoldKey, String message,
      [Duration duration = const Duration(seconds: 4)]) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(message),
      duration: duration,
      backgroundColor: Colors.blue,
      action: new SnackBarAction(
          label: 'CLOSE',
          onPressed: () => scaffoldKey.currentState.removeCurrentSnackBar()),
    ));
  }

  static showError(String message,
      [Duration duration = const Duration(seconds: 4)]) {
    final scaffoldKey = new GlobalKey<ScaffoldState>();
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(message),
      duration: duration,
      backgroundColor: Colors.red,
      action: new SnackBarAction(
          label: 'CLOSE',
          onPressed: () => scaffoldKey.currentState.removeCurrentSnackBar()),
    ));
  }

  static showSuccess(String message,
      [Duration duration = const Duration(seconds: 4)]) {
    final scaffoldKey = new GlobalKey<ScaffoldState>();
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(message),
      duration: duration,
      backgroundColor: Colors.green,
      action: new SnackBarAction(
          label: 'CLOSE',
          onPressed: () => scaffoldKey.currentState.removeCurrentSnackBar()),
    ));
  }

  static showLoading(scaffoldKey) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text('Loading...')));
  }
}
