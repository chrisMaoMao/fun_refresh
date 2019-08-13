import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fun_refresh/tools/pic_tool.dart';

// 闪屏页面
class SplashPage extends StatefulWidget {
  @override
  createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer _timer;
  int count = 3;
  startTime() async {
    //设置启动图生效时间
    var _duration = Duration(seconds: 1);
    Timer(_duration, () {
      // 空等1秒之后再计时
      _timer = Timer.periodic(Duration(milliseconds: 1000), (v) {
        count--;
        if (count == 0) {
          navigationPage();
        } else {
          setState(() {});
        }
      });
      return _timer;
    });
  }

  void navigationPage() {
    _timer.cancel();
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment(1.0, -1.0), // 右上角对齐
        children: [
          ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: Image.asset(
              '$picUri/splash.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 30.0, 10.0, 0.0),
            child: FlatButton(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
              onPressed: () => navigationPage(),
              color: Colors.grey[500],
              child: Text(
                "$count 跳过广告",
                style: TextStyle(color: Colors.white, fontSize: 12.0),
              ),
            ),
          )
        ],
      );
}
