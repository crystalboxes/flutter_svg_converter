import 'dart:typed_data';

import '../../flutter_svg.dart';
import 'custom_canvas.dart';
import 'custom_path.dart';
import 'dart:ui';

import 'custom_shader.dart';

String joinCommands(String forName, List<Command> commands) {
  var out = '';
  for (var cmd in commands) {
    out += '$forName.${cmd.name}(';

    if (cmd.args != null && cmd.args.length != 0) {
      out += '\n';
      for (var arg in cmd.args) {
        out += '' + stringRepresentationOf(arg) + ',\n';
      }
    }

    if (cmd.optional != null) {
      for (var arg in cmd.optional) {
        out += (arg[0] as String) + ': ${stringRepresentationOf(arg[1])},\n';
      }
    }

    out += ');\n';
  }

  return out;
}

String paintToString(Paint paint) {
  var defaultPaint = Paint();
  var p2 = '''Paint()''';

  if (false || defaultPaint.blendMode != paint.blendMode) {
    p2 += '..blendMode = ${stringRepresentationOf(paint.blendMode)}';
  }
  if (true || defaultPaint.color != paint.color) {
    p2 += '..color = ${stringRepresentationOf(paint.color)}';
  }

  if (false || defaultPaint.colorFilter != paint.colorFilter) {
    p2 += '..colorFilter = ${stringRepresentationOf(paint.colorFilter)}';
  }
  if (false || defaultPaint.filterQuality != paint.filterQuality) {
    p2 += '..filterQuality = ${stringRepresentationOf(paint.filterQuality)}';
  }
  if (false || defaultPaint.imageFilter != paint.imageFilter) {
    p2 += '..imageFilter = ${stringRepresentationOf(paint.imageFilter)}';
  }
  if (false || defaultPaint.invertColors != paint.invertColors) {
    p2 += '..invertColors = ${stringRepresentationOf(paint.invertColors)}';
  }
  if (false || defaultPaint.isAntiAlias != paint.isAntiAlias) {
    p2 += '..isAntiAlias = ${stringRepresentationOf(paint.isAntiAlias)}';
  }
  if (false || defaultPaint.maskFilter != paint.maskFilter) {
    p2 += '..maskFilter = ${stringRepresentationOf(paint.maskFilter)}';
  }
  if (false || defaultPaint.strokeCap != paint.strokeCap) {
    p2 += '..strokeCap = ${stringRepresentationOf(paint.strokeCap)}';
  }
  if (false || defaultPaint.strokeJoin != paint.strokeJoin) {
    p2 += '..strokeJoin = ${stringRepresentationOf(paint.strokeJoin)}';
  }
  if (false || defaultPaint.strokeWidth != paint.strokeWidth) {
    p2 += '..strokeWidth = ${stringRepresentationOf(paint.strokeWidth)}';
  }
  if (false || defaultPaint.style != paint.style) {
    p2 += '..style = ${stringRepresentationOf(paint.style)}';
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

String stringRepresentationOf(dynamic object) {
  switch (object.runtimeType as Type) {
    case CustomPath:
      String out = '(){\n';
      out += 'var path = Path();\n';

      out += joinCommands('path', (object as CustomPath).commands);

      out += 'return path;\n';
      out += '}()';
      return out;
    case bool:
      return (object as bool) ? 'true' : 'false';

    case ClipOp:
      switch (object as ClipOp) {
        case ClipOp.difference:
          return 'ClipOp.difference';
        case ClipOp.intersect:
          return 'ClipOp.intersect';
      }
      return '';
    case Rect:
      final Rect r = object as Rect;
      return 'Rect.fromLTWH(${r.left}, ${r.top}, ${r.width}, ${r.height})';
    case double:
      return (object as double).toString();
    case int:
      return (object as int).toString();
    case Null:
      return 'null';
    case PaintingStyle:
      switch (object as PaintingStyle) {
        case PaintingStyle.fill:
          return 'PaintingStyle.fill';
        case PaintingStyle.stroke:
          return 'PaintingStyle.stroke';
      }
      return '';
    case FilterQuality:
      switch (object as FilterQuality) {
        case FilterQuality.high:
          return 'FilterQuality.high';
        case FilterQuality.low:
          return 'FilterQuality.low';
        case FilterQuality.medium:
          return 'FilterQuality.medium';
        case FilterQuality.none:
          return 'FilterQuality.none';
      }
      return '';
    case StrokeCap:
      switch (object as StrokeCap) {
        case StrokeCap.butt:
          return 'StrokeCap.butt';
        case StrokeCap.round:
          return 'StrokeCap.round';
        case StrokeCap.square:
          return 'StrokeCap.square';
      }
      return '';

    case BlendMode:
      // TODO support blend modes
      return 'BlendMode.srcOver';
    case StrokeJoin:
      switch (object as StrokeJoin) {
        case StrokeJoin.bevel:
          return 'StrokeJoin.bevel';
        case StrokeJoin.miter:
          return 'StrokeJoin.miter';
        case StrokeJoin.round:
          return 'StrokeJoin.round';
      }
      return '';
    case Color:
      var c = object as Color;
      return 'Color.fromARGB(${c.alpha}, ${c.red}, ${c.green}, ${c.blue})';
    case Paint:
      return paintToString(object as Paint);

    case TileMode:
      switch (object as TileMode) {
        case TileMode.clamp:
          return 'TileMode.clamp';
        case TileMode.repeated:
          return 'TileMode.repeated';
        case TileMode.mirror:
          return 'TileMode.mirror';
      }
      return '';

    case Offset:
      var offset = object as Offset;
      var dx = stringRepresentationOf(offset.dx);
      var dy = stringRepresentationOf(offset.dy);
      return 'Offset(${dx}, ${dy})';
    case CustomPicture:
      var pic = object as CustomPicture;
      var commands = joinCommands('canvas', pic.commands);
      if (pic.hasBounds) {
        return 'canvas.scale(min(size.width / ${pic.clipRect.width}, size.height / ${pic.clipRect.width}));\n' +
            commands;
      }
      return commands;

    default:
      if (object.runtimeType.toString() == 'Float64List') {
        var l = object as Float64List;
        var o = 'Float64List.fromList([';
        for (var v in l) {
          o += v.toString() + ', ';
        }
        o += '])';
        return o;
      } else if (object.runtimeType.toString() == 'SurfacePaint') {
        return paintToString(object as Paint);
      } else if (object.runtimeType.toString() == 'EngineParagraph' ||
          object.runtimeType.toString() == 'Paragraph') {
        return '''
        () {
          var pb = ParagraphBuilder(ParagraphStyle())..addText('Unimplemented');
          return pb.build();
        }()
        ''';
      } else if (object.runtimeType.toString() == 'List<Color>') {
        var l = object as List<Color>;
        return '<Color>[${l.fold<String>('', (value, element) => '$value' + stringRepresentationOf(element) + ', ')}]';
      } else if (object.runtimeType.toString().startsWith('List<')) {
        var l = object as List<dynamic>;
        return '[${l.fold<String>('', (value, element) => '$value' + stringRepresentationOf(element) + ', ')}]';
      } else {
        throw ('couldnt find ${object.runtimeType}');
      }
  }
}
