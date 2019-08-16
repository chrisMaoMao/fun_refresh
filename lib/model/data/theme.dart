import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fun_refresh/tools/global.dart';

// 文字样式
$Text(String text) =>
    Text(text, style: TextStyle(color: Colors.black38), textScaleFactor: 0.8);
final baseTextStyle = const TextStyle(fontFamily: 'Poppins');
final smallTextStyle = commonTextStyle.copyWith(fontSize: 9.0);
final commonTextStyle = baseTextStyle.copyWith(
    color: const Color(0xffb6b2df),
    fontSize: 14.0,
    fontWeight: FontWeight.w400);
final titleTextStyle = baseTextStyle.copyWith(
    color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600);
final headerTextStyle = baseTextStyle.copyWith(
    color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w400);
final drawerTxT0 = TextStyle(
    color: Colors.white70, fontSize: 20.0, fontWeight: FontWeight.w600);
final drawerTxT1 =
    TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600);
final drawerSelectedColor = Color(0xff4AC8EA);
final whiteTxT = TextStyle(color: Colors.white);

// 颜色
final primary = Color(0xff1b82d2);

// 迷你微件
// 关闭图标
get xClose => InkWell(
      borderRadius: BorderRadius.circular(32.0),
      onTap: () => scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('不感兴趣?'),
            backgroundColor: Colors.cyan[200],
            duration: Duration(milliseconds: 666),
            action: SnackBarAction(
              label: '屏蔽关键词,减少推荐',
              onPressed: () {},
            ),
          )),
      child: Container(
          width: 24.0,
          height: 24.0,
          child: Icon(Icons.close, color: Colors.black12, size: 16.0)),
    );
