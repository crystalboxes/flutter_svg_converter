import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:provider/provider.dart';

import '../helper_widgets/custom_picture_view.dart';
import '../assets/icons.dart';
import '../helper_widgets/illustration_paint.dart';
import 'state.dart';

class StatsRow extends StatelessWidget {
  final Widget icon;
  final String text;
  final String tooltip;

  const StatsRow({Key key, this.icon, this.text, this.tooltip})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Tooltip(
            message: tooltip,
            child: Container(
              child: Center(
                child: icon,
              ),
              width: 30,
              height: 30,
            ),
          ),
          Text(text)
        ],
      ),
    );
  }
}

class StatsView extends StatelessWidget {
  const StatsView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<SVGToolState>(
        builder: (context, state, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: state.picture == null
              ? []
              : [
                  Text(
                    'Stats'.toUpperCase(),
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  StatsRow(
                    tooltip: 'Width',
                    icon: IllustrationPaint(
                      painter: WidthIcon(),
                      size: WidthIcon.size,
                    ),
                    text: state.picture.clipRect.width.toString(),
                  ),
                  StatsRow(
                    tooltip: 'Height',
                    icon: IllustrationPaint(
                      painter: HeightIcon(),
                      size: HeightIcon.size,
                    ),
                    text: state.picture.clipRect.height.toString(),
                  ),
                  StatsRow(
                    tooltip: 'Number of lines generated',
                    icon: IllustrationPaint(
                      painter: MetroLines(),
                      size: MetroLines.size,
                    ),
                    text: state.generatedSourceLines.length.toString(),
                  ),
                  Container(
                    height: 15,
                  ),
                  if (state.picture != null && state.picture.colors.length != 0)
                    Text(
                      'Colors'.toUpperCase(),
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  if (state.picture != null && state.picture.colors.length != 0)
                    Container(
                      constraints:
                          BoxConstraints(minHeight: 16, maxHeight: 16 * 4.0),
                      child: GridView.extent(
                        maxCrossAxisExtent: 16,
                        children: List.generate(
                          state.picture.colors.length,
                          (index) => Tooltip(
                            message: '#' +
                                state.picture.colors[index]
                                    .toString()
                                    .replaceAll('Color(0x', '')
                                    .substring(2)
                                    .replaceAll(')', '')
                                    .toUpperCase(),
                            child: Container(
                              padding: EdgeInsets.all(3),
                              child: Container(
                                width: 16,
                                height: 16,
                                color: state.picture.colors[index],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
        ),
      ),
    );
  }
}

class ResultView extends StatelessWidget implements TickerProvider {
  const ResultView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 20, right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x17000000),
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
      // constraints: BoxConstraints(minHeight: 329),
      child: AnimatedSize(
        vsync: this,
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 500),
        child: Consumer<SVGToolState>(
          builder: (context, value, child) => value.error != ''
              ? ResultErrorView(error: value.error)
              : value.isViewingImage
                  ? ResultImageView()
                  : value.generatedSourceLines != null
                      ? ResultCodeView(lines: value.generatedSourceLines)
                      : Container(),
        ),
      ),
    );
  }

  @override
  Ticker createTicker(onTick) {
    return Ticker(onTick);
  }
}

class ResultCodeView extends StatelessWidget {
  final List<String> lines;

  const ResultCodeView({Key key, this.lines}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ResultViewBase(
      title: 'Code',
      child: Container(
        padding: EdgeInsets.only(top: 10, right: 15, bottom: 15, left: 0),
        constraints: BoxConstraints(maxHeight: 400),
        child: ListView.builder(
          itemCount: lines.length,
          itemBuilder: (context, index) {
            return Container(
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: (index + 1).toString() + '  ',
                    style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: Color.fromARGB(255, 80, 80, 80)),
                  ),
                  TextSpan(
                    text: lines[index],
                    style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: Colors.grey),
                  )
                ]),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ResultViewBase extends StatelessWidget {
  final String title;
  final Widget child;

  const ResultViewBase({Key key, this.title, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Text(
              title,
              style: Theme.of(context).textTheme.headline3,
            ),
          child
        ],
      ),
    );
  }
}

class ResultErrorView extends StatelessWidget {
  final String error;

  const ResultErrorView({Key key, this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResultViewBase(
      title: 'Error',
      child: Container(
        padding: EdgeInsets.only(top: 20, right: 20, bottom: 20),
        child: Text(error),
      ),
    );
  }
}

class ResultImageView extends StatelessWidget {
  const ResultImageView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResultViewBase(
      title: 'Result',
      child: Container(
        margin: EdgeInsets.only(top: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                constraints: BoxConstraints(minHeight: 200),
                padding: EdgeInsets.only(
                  right: 40,
                ),
                child: ResultCanvasImageView(),
              ),
            ),
            Expanded(
              flex: 1,
              child: StatsView(),
            )
          ],
        ),
      ),
    );
  }
}

class ResultCanvasImageView extends StatelessWidget {
  const ResultCanvasImageView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<SVGToolState>(
        builder: (context, value, child) => RepaintBoundary(
          child: value.picture == null
              ? Container()
              : CustomPaint(
                  // size: Size(value.picture.clipRect.width,
                  //     value.picture.clipRect.height),
                  child: Container(),
                  isComplex: true,
                  willChange: false,
                  painter: CustomPicturePainter(value.picture,
                      drawTransparentGrid: true),
                ),
        ),
      ),
    );
  }
}
