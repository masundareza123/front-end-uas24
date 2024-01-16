import 'package:flutter/material.dart';
import 'package:uas_ppl_2024/views/home_view.dart';
import 'package:uas_ppl_2024/views/letter_view.dart';

import 'const.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homeViewRoute:
      return _pageRoute(routeName: settings.name, viewToShow: HomeView());
    case letterViewRoute:
      return _pageRoute(routeName: settings.name, viewToShow: LetterView());


    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text(
              'No route defined for ${settings.name}',
            ),
          ),
        ),
      );
  }
}

PageRoute _pageRoute({required String? routeName, required Widget viewToShow}) {
  return MaterialPageRoute(
      builder: (_) => viewToShow, settings: RouteSettings(name: routeName));
}
