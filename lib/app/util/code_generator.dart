import 'dart:ui';

import '../../src/ui_proxies/custom_shader.dart';

import '../../src/ui_proxies/string_representation.dart';
import '../../src/ui_proxies/custom_path.dart';
import '../../flutter_svg.dart';

String _makeCustomPainterClassSource(
        String paintBody, String colors, String size,
        [String className = 'SvgImage']) =>
    '''import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class $className extends CustomPainter {
  
  $colors

  $size

  @override
  void paint(Canvas canvas, Size size) {
   $paintBody
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}''';

class CustomPictureCodeGenerator {
  final CustomPicture picture;
  CustomPictureCodeGenerator({this.picture});

  int _nextColor = 0;
  final _colors = <Color, String>{};
  final _colorsArray = <Color>[];

  String _joinCanvasCommands(List<Command> commands) {
    var out = '';
    for (var cmd in commands) {
      out += 'canvas.${cmd.name}(';

      if (cmd.args != null && cmd.args.length != 0) {
        out += '\n';
        for (var arg in cmd.args) {
          if (arg is Paint) {
            out += _paintToString(arg);
          } else {
            out += '' + stringRepresentationOf(arg);
          }
          out += ',\n';
        }
      }

      if (cmd.optional != null) {
        for (var arg in cmd.optional) {
          out += (arg[0] as String) + ': ';
          if (arg[1] is Paint) {
            out += '${_paintToString(arg[1])},\n';
          } else {
            out += '${stringRepresentationOf(arg[1])},\n';
          }
        }
      }

      out += ');\n';
    }

    return out;
  }

  String generateSource() {
    picture.calculateBounds();
    picture.colors.clear();

    // hashmap all colors
    final commands = picture.commands;
    for (var command in commands) {
      for (int x = 0; x < command.args.length; x++) {
        if (command.args[x] is Paint) {
          var color = (command.args[x] as Paint).color;
          if (!_colors.containsKey(color)) {
            final newName = 'color${_nextColor++}';
            _colors[color] = newName;
            _colorsArray.add(color);
            picture.colors.add(color);
          }
        }
      }
    }

    var pic = picture;
    var cmds = _joinCanvasCommands(pic.commands);
    if (pic.hasBounds) {
      cmds =
          'canvas.scale(min(size.width / ${pic.clipRect.width}, size.height / ${pic.clipRect.height}));\n' +
              cmds;
    }

    cmds =
        cmds.split('\n').fold('', (value, element) => '$value\n    $element');

    var colArray = 'const colors = <Color>[\n';

    _colorsArray.forEach((element) {
      colArray += '    ${stringRepresentationOf(element)},\n';
    });
    colArray += '];';

    return _makeCustomPainterClassSource(
        cmds,
        'static const size = Size(${picture.clipRect.width.toString()}, ${picture.clipRect.height.toString()});',
        colArray);
  }

  String _paintToString(Paint paint) {
    var defaultPaint = Paint();
    var p2 = '''Paint()''';

    if (false || defaultPaint.blendMode != paint.blendMode) {
      p2 += '\n  ..blendMode = ${stringRepresentationOf(paint.blendMode)}';
    }
    if (true || defaultPaint.color != paint.color) {
      p2 += '\n  ..color = colors[${_colorsArray.indexOf(paint.color)}]';
    }

    if (false || defaultPaint.colorFilter != paint.colorFilter) {
      p2 += '\n  ..colorFilter = ${stringRepresentationOf(paint.colorFilter)}';
    }
    if (false || defaultPaint.filterQuality != paint.filterQuality) {
      p2 +=
          '\n  ..filterQuality = ${stringRepresentationOf(paint.filterQuality)}';
    }
    if (false || defaultPaint.imageFilter != paint.imageFilter) {
      p2 += '\n  ..imageFilter = ${stringRepresentationOf(paint.imageFilter)}';
    }
    if (false || defaultPaint.invertColors != paint.invertColors) {
      p2 +=
          '\n  ..invertColors = ${stringRepresentationOf(paint.invertColors)}';
    }
    if (false || defaultPaint.isAntiAlias != paint.isAntiAlias) {
      p2 += '\n  ..isAntiAlias = ${stringRepresentationOf(paint.isAntiAlias)}';
    }
    if (false || defaultPaint.maskFilter != paint.maskFilter) {
      p2 += '\n  ..maskFilter = ${stringRepresentationOf(paint.maskFilter)}';
    }
    if (false || defaultPaint.strokeCap != paint.strokeCap) {
      p2 += '\n  ..strokeCap = ${stringRepresentationOf(paint.strokeCap)}';
    }
    if (false || defaultPaint.strokeJoin != paint.strokeJoin) {
      p2 += '\n  ..strokeJoin = ${stringRepresentationOf(paint.strokeJoin)}';
    }
    if (false || defaultPaint.strokeWidth != paint.strokeWidth) {
      p2 += '\n  ..strokeWidth = ${stringRepresentationOf(paint.strokeWidth)}';
    }
    if (false || defaultPaint.style != paint.style) {
      p2 += '\n  ..style = ${stringRepresentationOf(paint.style)}';
    }
    try {
      p2 +=
          '\n  ..strokeMiterLimit = ${stringRepresentationOf(paint.strokeMiterLimit)}';
    } catch (e) {}
    if (paint.shader != null) {
      p2 += '\n  ..shader = ${shaderMap[paint.shader]}';
    }

    return p2;
  }
}
