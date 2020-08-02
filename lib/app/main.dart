import 'dart:math';
import 'dart:ui';

import 'package:dart_style/dart_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg_converter/flutter_svg.dart';

import '../flutter_svg.dart';
import 'get_tiger.dart';
import 'new_ui.dart';

void main() {
  runApp(Ui2());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class SvgPainter extends CustomPainter {
  final CustomPicture pic;

  SvgPainter(@required this.pic);

  @override
  void paint(Canvas canvas, Size size) {
    if (pic != null) {
      if (pic.hasBounds) {
        canvas.scale(min(size.width / pic.clipRect.width,
            size.height / pic.clipRect.height));
      }
      for (var cmd in pic.commands) {
        if (cmd.callback != null) {
          cmd.callback(canvas);
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _MyAppState extends State<MyApp> {
  String source = '';
  final formatter = new DartFormatter();
  TextEditingController _controller;

  String status = '';

  CustomPicture pic;

  Future<List<dynamic>> makePic(String svgSrc) async {
    final DrawableRoot svgRoot = await svg.fromSvgString(svgSrc, svgSrc);
    final Picture picture = svgRoot.toPicture();
    String source = (picture as CustomPicture).makeCustomPainterSource();
    final className = 'SvgImage';
    source = '''
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';

class $className extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
   $source
  }

  @override
  bool shouldRepaint($className oldDelegate) => false;
}
        ''';

    return <dynamic>[
      (picture as CustomPicture)..findBounds(),
      source,
    ];
  }

  Future<String> getFormattedOutput(String src) async {
    return formatter.format(src);
  }

  void refresh() {
    makePic(getTiger()).then((value) {
      setState(() {
        status = '';
        pic = value[0] as CustomPicture;
        source = value[1] as String;
      });
    });
  }

  @override
  void initState() {
    _controller = TextEditingController(text: 'Initial value');
    refresh();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  FlatButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: source));
                    },
                    child: Text(status == '' ? 'Copy to clipboard12' : status),
                  ),
                  FlatButton(
                    child: Text('refresh'),
                    onPressed: refresh,
                  )
                ],
              ),
              Text(
                source.length > 500
                    ? source.substring(0, 500) + '\n...'
                    : source,
                style: TextStyle(fontFamily: 'monospace'),
              ),
              CustomPaint(
                size: Size(500, 500),
                painter: SvgPainter(pic),
              )
            ],
          ),
        ),
      ),
    );
  }
}
