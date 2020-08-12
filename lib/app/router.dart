import 'package:flutter/material.dart';

import 'ui3.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
        builder: (_) => SVGToolMainPage(),
        settings: settings,
      );
    case '/app-only':
      return MaterialPageRoute(
        builder: (_) => SVGToolMainPage(
          body: SVGToolLayout(
            isMinimal: true,
          ),
        ),
        settings: settings,
      );
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}
