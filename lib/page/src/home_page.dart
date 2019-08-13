import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_refresh/components/anchor_bar.dart';
import 'package:fun_refresh/components/circle_floating_menu.dart';
import 'package:fun_refresh/components/collapse_drawer.dart';
import 'package:fun_refresh/components/floating_button.dart';
import 'package:fun_refresh/components/marquee.dart';
import 'package:fun_refresh/model/data/local_asset.dart';
import 'package:fun_refresh/model/smash_model.dart';
import 'package:fun_refresh/page/i18n/i18n.dart';
import 'package:fun_refresh/tools/common.dart';
import '../export_page_pkg.dart';

class HomePage extends StatefulWidget {
  @override
  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentNav = 0;
  var _marqueeController = MarqueeController();
  List<String> get navTexts => [
        '${I18n.of(context).news}',
        '${I18n.of(context).video}',
        '${I18n.of(context).more}',
        '${I18n.of(context).msg}',
      ];
  @override
  Widget build(BuildContext context) => Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        drawer: CollaplseDrawer(),
        body: _skipPage(_currentNav),
        floatingActionButton: CircleFloatingMenu(
          menuSelected: (index) {
            scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text('$index'),
            ));
          },
          startAngle: degToRad(-160.0),
          endAngle: degToRad(-20.0),
          floatingButton: FloatingButton(
            icon: Icons.add,
            size: 30.0,
            color: Colors.redAccent,
          ),
          subMenus: [
            FloatingButton(
              icon: Icons.widgets,
            ),
            FloatingButton(
              icon: Icons.book,
            ),
            FloatingButton(
              icon: Icons.translate,
            ),
            FloatingButton(
              icon: Icons.alarm_add,
            ),
            FloatingButton(
              icon: Icons.bluetooth,
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnchorBar(
          notchedShape: CircularNotchedRectangle(),
          items: _getNavItemsBTM,
          notchMargin: 8.0,
          onTabSelected: (index) => setState(() => _currentNav = index),
          color: Colors.black54,
          backgroundColor: Colors.white,
          selectedColor: Theme.of(context).accentColor,
          centerItem: GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(top: 12.0),
              height: 24.0,
              child: Center(
                child: Marquee(
                  textList: [
                    '当前室外:💧16℃',
                    '今天:💧16℃~26℃',
                    '冷热适宜很舒适😎',
                    '🔆04:51~18:52🌙'
                  ],
                  fontSize: 10.0,
                  controller: _marqueeController,
                ),
              ),
            ),
          ),
        ),
      );
  get _getNavItemsBTM => [
        NavItemBTM(iconPath: _currentNavIcon(0), text: _navTitleBTM(0)),
        NavItemBTM(iconPath: _currentNavIcon(1), text: _navTitleBTM(1)),
        NavItemBTM(iconPath: _currentNavIcon(2), text: _navTitleBTM(2)),
        NavItemBTM(iconPath: _currentNavIcon(3), text: _navTitleBTM(3))
      ];
  _navTitleBTM(index) => navTexts[index]; // 点击索引切换文字颜色
  _currentNavIcon(currentIndex) => currentIndex == _currentNav
      ? navIcons[currentIndex][1]
      : navIcons[currentIndex][0];
  _skipPage(index) {
    switch (index) {
      case 0:
        return NewsPage();
      case 1:
        return VideoPage();
      case 2:
        return ExtensionPage();
      case 3:
        return MessagePage();
      default:
        return NewsPage();
    }
  }
}
