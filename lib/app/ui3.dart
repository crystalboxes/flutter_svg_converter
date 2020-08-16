import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'assets/big_illustration.dart';
import 'title_screen.dart';
import 'util/constants.dart';
import 'helper_widgets/illustration_paint.dart';
import 'router.dart';
import 'helper_widgets/svg_widget.dart';

import 'header.dart';
import 'app_ui/app_ui.dart';
import 'assets/illustrations.dart';
import 'util/theming.dart';

class SVGToolApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SVG Tool',
      theme: customLightTheme,
      onGenerateRoute: onGenerateRoute,
    );
  }
}

class SVGToolMainPage extends StatelessWidget {
  final Widget body;

  const SVGToolMainPage({Key key, this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: body == null ? SVGToolLayout() : body,
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
  final bool isMinimal;

  const SVGToolLayout({Key key, this.isMinimal = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var bodyWidgets = [
      Container(
        height: 50,
      )
    ];
    if (!isMinimal) {
      bodyWidgets = [
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
      ];
    }
    return Container(
      child: Column(
        children: [
          SVGToolAppbar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        ...bodyWidgets,
                        Container(
                          margin: EdgeInsets.only(bottom: 150),
                          constraints: BoxConstraints(
                              maxWidth: layoutMaxWidth, minHeight: 600),
                          child: SVGToolAppUI(
                            showsCodeOnInit: isMinimal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isMinimal)
                    Container(
                      height: 200,
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
      ),
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
