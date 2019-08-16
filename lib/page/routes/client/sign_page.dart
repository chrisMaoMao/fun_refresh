import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fun_refresh/model/smash_model.dart';
import 'package:fun_refresh/tools/pic_tool.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignPage extends StatefulWidget {
  @override
  createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googlSignIn = GoogleSignIn();
  GoogleSignInAuthentication googleAuth;
  Future<FirebaseUser> _signIn(BuildContext context) async {
    final GoogleSignInAccount googleUser = await _googlSignIn.signIn();
    googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    AuthResult authResult =
        await _firebaseAuth.signInWithCredential(credential);
    final userDetails = authResult.user;
    ProviderDetails providerInfo = ProviderDetails(userDetails.providerId);

    List<ProviderDetails> providerData = List<ProviderDetails>();
    providerData.add(providerInfo);

    /* UserDetails details = UserDetails(
      userDetails.providerId,
      userDetails.displayName,
      userDetails.photoUrl,
      userDetails.email,
      providerData,
    ); */
    return userDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: SvgPicture.asset('$iconUri/google.svg'),
                  onPressed: () => _signIn(context).then(( user) {
                    print(user.email);
                    print("令牌" + googleAuth.accessToken);
                  }).catchError((e) => print(e)),
                ),
                Container(width: 32.0),
                IconButton(
                  icon: SvgPicture.asset('$iconUri/github.svg'),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
