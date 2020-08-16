import 'package:flutter/material.dart';

import 'util/constants.dart';
import 'assets/icons.dart';
import 'package:url_launcher/url_launcher.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final newRouteName = '/';
        bool isNewRouteSameAsCurrent = false;

        Navigator.popUntil(context, ModalRoute.withName('/'));

        if (!isNewRouteSameAsCurrent) {
          Navigator.of(context).pushNamed(newRouteName);
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: 8),
            child: CustomPaint(
              size: FlutterIcon.size,
              painter: FlutterIcon(),
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'SVG Tool',
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .apply(color: Theme.of(context).secondaryHeaderColor),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Menu extends StatelessWidget {
  Widget getMenuItem(String text, String url) => Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: InkWell(child: Text(text), onTap: () => launch(url)),
      );
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // getMenuItem('About'),
        getMenuItem(
            'Github', 'https://github.com/crystalboxes/flutter_svg_tool'),
      ],
    );
  }
}

class SVGToolAppbar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  SVGToolAppbar({
    Key key,
  })  : preferredSize = Size.fromHeight(68.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        color: Colors.white,
        constraints: BoxConstraints(maxWidth: layoutMaxWidth),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                constraints: BoxConstraints(maxWidth: layoutMaxWidth),
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Logo()),
                    Expanded(child: Menu()),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
