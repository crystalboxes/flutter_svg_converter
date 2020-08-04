import 'package:flutter/material.dart';

import 'constants.dart';
import 'assets/icons.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
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
          text: TextSpan(children: [
            TextSpan(
              text: 'SVG Tool',
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .apply(color: Theme.of(context).secondaryHeaderColor),
            )
          ]),
        ),
      ],
    );
  }
}

class Menu extends StatelessWidget {
  Widget getMenuItem(String text) => Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Text(text),
      );
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        getMenuItem('About'),
        getMenuItem('Github'),
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
                constraints: BoxConstraints(maxWidth: layoutMaxWidth),
                // color: Colors.orange,
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
