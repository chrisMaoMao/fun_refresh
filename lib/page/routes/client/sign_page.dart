import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignPage extends StatefulWidget {
  final Map args;
  SignPage({this.args});
  @override
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          // 白色块
          Container(width: width, height: height),
          // 蓝色块
          Container(
            width: width,
            height: height * 0.46,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF58BFE6), Color(0xFF69CBF3)],
                  begin: FractionalOffset.bottomLeft,
                  end: FractionalOffset.topRight,
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          // 黑色块
          Positioned(
            top: 0.0,
            right: 0.0,
            child: Container(
              width: width * 0.36,
              height: height * 0.38,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF3C3F47), Color(0xFF535763)],
                    begin: FractionalOffset.bottomLeft,
                    end: FractionalOffset.topRight,
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
            ),
          ),
          // 橙色块
          Container(
            width: width * 0.64,
            height: height * 0.2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFFFFAE3E), Color(0xFFFFB050)],
                  begin: FractionalOffset.bottomLeft,
                  end: FractionalOffset.topRight,
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                  width: width * 0.18,
                  height: height * 0.13,
                  child: Icon(CupertinoIcons.back,
                      size: 32.0, color: Colors.white))),
          Positioned(
            bottom: height * 0.15,
            right: width * 0.1,
            child: Container(
              width: width * 0.2,
              height: width * 0.2,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: FractionalOffset.bottomLeft,
                      end: FractionalOffset.topRight,
                      colors: [Color(0xFF3D4048), Color(0xFF545C67)]),
                  shape: BoxShape.circle),
              child: Center(
                  child: Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 38.0,
              )),
            ),
          ),
          Positioned(
            bottom: height * 0.18,
            left: width * 0.1,
            child: Text(
              'Sign in',
              style: TextStyle(
                color: Color(0xFF3D4048),
                fontWeight: FontWeight.bold,
                fontSize: 34.0,
              ),
            ),
          ),
          Positioned(
            bottom: height * 0.06,
            left: width * 0.1,
            child: Text(
              'Sign up',
              style: TextStyle(
                color: Color(0xFF3D4048),
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          Positioned(
            bottom: height * 0.06,
            right: width * 0.1,
            child: Text(
              'Forgot Passwords',
              style: TextStyle(
                color: Color(0xFF3D4048),
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          Positioned(
            top: height * 0.06,
            left: width * 0.1,
            child: Text(
              'Welcome Back',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 52.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
