import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg_converter/app/conversion.dart';
import '../flutter_svg.dart';
import 'get_tiger.dart';

class Ui2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Retrieve Text Input'),
        ),
        body: MyApp3(),
      ),
    );
  }
}

class MyApp3 extends StatefulWidget {
  const MyApp3({
    Key key,
  }) : super(key: key);

  @override
  _MyApp3State createState() => _MyApp3State();
}

class _MyApp3State extends State<MyApp3> {
  String svgSource;
  CustomPicture resultPicture;
  String resultSource;

  @override
  void initState() {
    svgSource = getTiger();
    _convert();
    super.initState();
  }

  void _convert() {
    parseSvgSource(svgSource).then((value) {
      setState(() {
        resultPicture = value.item1;
        resultSource = makeCustomPainterClassSource(value.item2);
      });
    }).catchError((err) {
      // TODO error case
      print('err');
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: ButtonRow(
              onConvert:
                  svgSource != null && svgSource.isNotEmpty ? _convert : null,
              onFormat: resultSource != null && resultSource.isNotEmpty
                  ? () {
                      setState(() {
                        resultSource = formatCustomPainterSource(resultSource);
                      });
                    }
                  : null,
              onCopyToClipboard: resultSource != null && resultSource.isNotEmpty
                  ? () {
                      ////
                      Clipboard.setData(ClipboardData(text: resultSource));
                    }
                  : null,
            ),
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 500,
                    child: TextFormField(
                      initialValue: getTiger(),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                      onChanged: (text) {
                        setState(() {
                          svgSource = text;
                          resultPicture = null;
                          resultSource = null;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ResultView(
                    source: resultSource,
                    picture: resultPicture,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ResultView extends StatefulWidget {
  final String source;
  final CustomPicture picture;

  const ResultView({Key key, this.source, this.picture}) : super(key: key);

  @override
  _ResultViewState createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  bool isShowingImage = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CheckboxListTile(
          title: Text('Show Image'),
          onChanged: (val) {
            setState(() {
              isShowingImage = val;
            });
          },
          value: isShowingImage,
        ),
        Container(
          height: 500,
          child: isShowingImage
              ? CustomPictureView(
                  picture: widget.picture,
                )
              : SourceList(
                  source: widget.source,
                ),
        )
      ],
    );
  }
}

class CustomPicturePainter extends CustomPainter {
  final CustomPicture picture;
  CustomPicturePainter(this.picture);

  @override
  void paint(Canvas canvas, Size size) {
    if (picture != null) {
      if (picture.hasBounds) {
        canvas.scale(min(size.width / picture.clipRect.width,
            size.height / picture.clipRect.height));
      }
      for (var cmd in picture.commands) {
        if (cmd.callback != null) {
          cmd.callback(canvas);
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class CustomPictureView extends StatelessWidget {
  final CustomPicture picture;

  const CustomPictureView({Key key, this.picture}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return picture == null
        ? Container()
        : CustomPaint(
            painter: CustomPicturePainter(picture), child: Container());
  }
}

class SourceList extends StatelessWidget {
  final List<String> items;
  SourceList({@required String source})
      : this.items = source != null ? source.split('\n') : [];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Container(
            child: Wrap(
          direction: Axis.horizontal,
          children: [
            Container(
              child: Text(
                index.toString(),
                style: TextStyle(
                    fontFamily: 'monospace', fontSize: 12, color: Colors.grey),
              ),
              padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
            ),
            Text(
              items[index],
              style: TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ],
        ));
      },
    );
  }
}

typedef void ButtonRowCallback();

class ButtonRow extends StatelessWidget {
  final ButtonRowCallback onConvert;
  final ButtonRowCallback onFormat;
  final ButtonRowCallback onCopyToClipboard;

  const ButtonRow({this.onConvert, this.onFormat, this.onCopyToClipboard});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FlatButton(
          onPressed: onConvert,
          child: Text('Convert'),
        ),
        FlatButton(
          onPressed: onFormat,
          child: Text('Format'),
        ),
        FlatButton(
          onPressed: onCopyToClipboard,
          child: Text('Copy to Clipboard'),
        )
      ],
    );
  }
}
