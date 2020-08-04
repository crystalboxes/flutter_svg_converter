import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'assets/big_illustration.dart';
import 'constants.dart';
import 'illustration_paint.dart';
import 'svg_widget.dart';

import 'header.dart';
import 'app_ui/app_ui.dart';
import 'assets/illustrations.dart';
import 'util/theming.dart';

class SVGToolApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: customLightTheme,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SVGToolLayout(),
      ),
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

class ColumnSection extends StatelessWidget {
  final Widget illustration;
  final String text;
  final String heading;

  const ColumnSection(
      {@required this.illustration,
      @required this.text,
      @required this.heading});
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 280),
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            illustration,
            Container(
              margin: EdgeInsets.only(top: 25),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  heading,
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 22, left: 5, right: 5),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SVGToolLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SVGToolAppbar(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 150),
                  child: TitleScreen(),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 150),
                  constraints: BoxConstraints(maxWidth: layoutMaxWidth),
                  child: AboutColumns(),
                ),
                Container(
                  height: 110,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 150),
                  constraints:
                      BoxConstraints(maxWidth: layoutMaxWidth, minHeight: 600),
                  child: SVGToolAppUI(),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(top: 16, bottom: 16),
                          color: Colors.black,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Built with Flutter, based on flutter_svg. Made by @crystalboxes',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class AboutColumns extends StatelessWidget {
  const AboutColumns({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ColumnSection(
            illustration:
                IllustrationPaint(painter: GearsImage(), size: Size(172, 121)),
            heading: 'What is it?',
            text:
                'Flutter SVG Tool is an SVG converter that generates a Flutter widget code. It uses flutter_svg library to do the parsing and creating the sequence of canvas and path commands for rendering inside of the CustomPainter. No need for extra packages and loading at runtime!',
          ),
        ),
        Expanded(
          child: ColumnSection(
            illustration: IllustrationPaint(
                painter: WebIllustration(), size: Size(172, 121)),
            heading: 'Web Supported',
            text:
                'Generated code works with a web version of Flutter, so it eliminates the necessity of using hacks like rendering HTML Elements.',
          ),
        ),
        Expanded(
          child: ColumnSection(
            illustration: IllustrationPaint(
                painter: ColorPalletesImage(), size: Size(172, 121)),
            heading: 'Customizable',
            text:
                'SVG Tool extracts colors and additional properties into variables, which makes it simple to make quick changes to get the illustration or the icon fit into the look of your app.',
          ),
        ),
      ],
    );
  }
}

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
          onPressed: () {},
          child: Text('Get Started'),
        )
      ],
    );
  }
}
