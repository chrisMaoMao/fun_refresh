import 'package:flutter/material.dart';
import '../page/export_page_pkg.dart';

class ItemD {
  ItemD({@required this.title, @required this.iconPath});
  final String title;
  final String iconPath;
}

class NavItemBTM {
  NavItemBTM({this.text, this.iconPath});
  final String text;
  final String iconPath;
}

class NewsTab {
  // 标签页模型,灵活定制页面所用到的对象
  String text;
  NewsList newsList;
  NewsTab(this.text, this.newsList);
}


class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}