import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fun_refresh/model/smash_model.dart';
import 'package:fun_refresh/tools/global.dart';
import 'package:fun_refresh/tools/pic_tool.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignPage extends StatefulWidget {
  @override
  createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  @override
  void initState() {
    print(isGoogleLoginSuccess);
    super.initState();
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googlSignIn = GoogleSignIn();
  GoogleSignInAuthentication googleAuth;
  Future<FirebaseUser> _signIn(BuildContext context) async {
    googleUser = await _googlSignIn.signIn();
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
        margin: EdgeInsets.only(bottom: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999.0)),
              color: Colors.transparent,
              elevation: 0.0,
              child: Image.network(
                isGoogleLoginSuccess == false ? '' : googleUser.photoUrl,
                width: 99.0,
                height: 99.0,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.all(32.0),
              width: MediaQuery.of(context).size.width * 0.7,
              height: 32.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.0),
                color: Colors.grey,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: SvgPicture.asset('$iconUri/google.svg'),
                  onPressed: () => _signIn(context).then((user) {
                    print("令牌：" + googleAuth.accessToken);
                    googleAuth.accessToken == null
                        ? isGoogleLoginSuccess = false
                        : isGoogleLoginSuccess = true;
                    print('登录情况：$isGoogleLoginSuccess');
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
