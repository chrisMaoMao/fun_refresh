import 'package:flutter/material.dart';

final scaffoldKey = GlobalKey<ScaffoldState>();
final dialogPrefKey = 'dialog';
showSnackBar(text) {
  final snackbar = SnackBar(
    content: Text(text),
    duration: Duration(milliseconds: 300),
  );
  scaffoldKey.currentState.showSnackBar(snackbar);
}
