import 'dart:math';
import 'dart:ui';

import 'package:dart_style/dart_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg_converter/flutter_svg.dart';

import 'flutter_svg.dart';
import 'app/get_tiger.dart';
import 'app/new_ui.dart';

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
    print('render');
    if (pic != null) {
      print('render2');

      if (pic.hasBounds) {
        print('$size, ${pic.clipRect}');
        canvas.scale(min(size.width / pic.clipRect.width,
            size.height / pic.clipRect.height));
      }
      for (var cmd in pic.commands) {
        if (cmd.callback != null) {
          print(
              '${cmd.name}: ${cmd.args.toString()} ${cmd.optional.toString()}');
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
  String source = 's';
  final formatter = new DartFormatter();
  TextEditingController _controller;

  String status = '';

  CustomPicture pic;

  static Future<List<dynamic>> makePic(String svgSrc) async {
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
    makePic('''
    
  <svg height="400" width="450">
<path id="lineAB" d="M 100 350 l 150 -300" stroke="red" stroke-width="3" fill="none" />
  <path id="lineBC" d="M 250 50 l 150 300" stroke="red" stroke-width="3" fill="none" />
  <path d="M 175 200 l 150 0" stroke="green" stroke-width="3" fill="none" />
  <path d="M 100 350 q 150 -300 300 0" stroke="blue" stroke-width="5" fill="none" />
  <!-- Mark relevant points -->
  <g stroke="black" stroke-width="3" fill="black">
    <circle id="pointA" cx="100" cy="350" r="3" />
    <circle id="pointB" cx="250" cy="50" r="3" />
    <circle id="pointC" cx="400" cy="350" r="3" />
  </g>
  <!-- Label the points -->
  <g font-size="30" font-family="sans-serif" fill="black" stroke="none" text-anchor="middle">
    <text x="100" y="350" dx="-30">A</text>
    <text x="250" y="50" dy="-10">B</text>
    <text x="400" y="350" dx="30">C</text>
  </g>
  Sorry, your browser does not support inline SVG.
</svg>
    
    ''').then((value) {
      setState(() {
        status = '';
        pic = value[0] as CustomPicture;
        pic.findBounds();
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
                size: Size(500, 511),
                painter: SvgPainter(pic),
              )
            ],
          ),
        ),
      ),
    );
  }
}
