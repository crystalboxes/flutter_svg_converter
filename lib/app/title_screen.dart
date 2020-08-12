import 'package:flutter/material.dart';

import 'assets/big_illustration.dart';
import 'helper_widgets/svg_widget.dart';

class TitleScreen extends StatelessWidget {
  const TitleScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 100),
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: SVGWidget(
                          rasterize: true,
                          size: Size(440, 440),
                          source: bigIllustrationSvg,
                        ),
                      )
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 434),
                      child: TitleText(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/app-only');
          },
          child: Text('Get Started'),
        )
      ],
    );
  }
}

class TitleText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Flutter SVG Tool',
            style: Theme.of(context).textTheme.headline1,
          ),
          Container(
            margin: EdgeInsets.only(top: 7),
            child: Text(
              'Transform your SVG into Dart code',
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  .apply(color: Theme.of(context).secondaryHeaderColor),
            ),
          ),
        ],
      ),
    );
  }
}
