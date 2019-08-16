import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignInAccount googleUser;
var isGoogleLoginSuccess = false;
final scaffoldKey = GlobalKey<ScaffoldState>();
final dialogPrefKey = 'dialog';
showSnackBar(text) {
  final snackbar = SnackBar(
    content: Text(text),
    duration: Duration(milliseconds: 300),
  );
  scaffoldKey.currentState.showSnackBar(snackbar);
}
