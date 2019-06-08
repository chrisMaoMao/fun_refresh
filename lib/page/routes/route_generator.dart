import 'package:flutter/material.dart';
import 'package:fun_refresh/page/i18n/i18n.dart';
import '../export_page_pkg.dart';

class RouteGenerator {
  static Route<dynamic> generator(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return _skipRoute(SplashPage());
      case '/home':
        return _skipRoute(I18nContainer(key: i18nKey, child: HomePage()));
      case '/detail':
        return _skipRoute(DetailPage(args: args));
      case '/browser':
        return _skipRoute(Browser(args: args));
      case '/sign':
        return _skipRoute(SignPage(args: args));
      case '/reward':
        return _skipRoute(RewardPage());
      case '/chat':
        return _skipRoute(ChatPage(args: args));
      case '/profile':
        return _skipRoute(ProfilePage(args: args));
      case '/profile':
        return _skipRoute(SearchPanel());
      default:
        return errorRoutes();
    }
  }

  static Route<dynamic> errorRoutes() =>
      _skipRoute(Scaffold(body: Center(child: Text('跳转错误'))));
}

_skipRoute(Widget build) => MaterialPageRoute(builder: (context) => build);

pushNamed(BuildContext context, String name, {Object args}) =>
    Navigator.of(context).pushNamed('$name', arguments: args);

pushReplacementNamed(BuildContext context, String name, {Object arguments}) =>
    Navigator.of(context).pushReplacementNamed('$name', arguments: arguments);
