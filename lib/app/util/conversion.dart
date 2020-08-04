import 'package:dart_style/dart_style.dart';
import 'package:tuple/tuple.dart';

import '../../flutter_svg.dart';

String makeCustomPainterClassSource(String paintBody,
        [String className = 'SvgImage']) =>
    '''import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class $className extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
   $paintBody
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}''';

Future<Tuple2<CustomPicture, String>> parseSvgSource(String svgSource) async {
  final DrawableRoot svgRoot = await svg.fromSvgString(svgSource, svgSource);
  final CustomPicture picture = svgRoot.toPicture() as CustomPicture;
  return Tuple2<CustomPicture, String>(
      picture, picture.makeCustomPainterSource());
}

final formatter = new DartFormatter();
String formatCustomPainterSource(String src) => formatter.format(src);
