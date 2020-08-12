import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter_svg_converter/src/ui_proxies/string_representation.dart';

import 'custom_path.dart';

class CustomPicture implements Picture {
  final Picture _picture;
  final CustomCanvas _canvas;
  final colors = <Color>[];

  List<Command> get commands => _canvas._commands;
  Size clipRect = Size(0, 0);

  bool get hasBounds => !(clipRect.width < 0.0001 && clipRect.height < 0.0001);

  String makeCustomPainterSource() {
    // get first clipRect
    if (!hasBounds) {
      calculateBounds();
    }
    return stringRepresentationOf(this);
  }

  void calculateBounds() {
    for (var cmd in commands) {
      if (cmd.name == 'clipRect') {
        var r = cmd.args[0] as Rect;
        clipRect = Size(r.width, r.height);
        break;
      }
    }
  }

  CustomPicture(this._picture, this._canvas);

  @override
  int get approximateBytesUsed => _picture.approximateBytesUsed;

  @override
  void dispose() {
    _picture.dispose();
  }

  @override
  Future<Image> toImage(int width, int height) {
    return _picture.toImage(width, height);
  }
}

class CustomPictureRecorder implements PictureRecorder {
  CustomCanvas canvas;
  final PictureRecorder _pictureRecorder;
  PictureRecorder get recorder => _pictureRecorder;

  CustomPictureRecorder() : _pictureRecorder = PictureRecorder();

  @override
  Picture endRecording() {
    return CustomPicture(_pictureRecorder.endRecording(), canvas);
  }

  @override
  bool get isRecording => _pictureRecorder.isRecording;
}

class CustomCanvas implements Canvas {
  final Canvas a;

  final _commands = <Command>[];

  CustomCanvas(CustomPictureRecorder recorder, [Rect cullRect])
      : a = Canvas(recorder.recorder, cullRect) {
    recorder.canvas = this;
  }

  @override
  void clipPath(Path path, {bool doAntiAlias = true}) {
    _commands.add(
      Command(
        name: 'clipPath',
        args: <dynamic>[
          path,
        ],
        optional: [
          <dynamic>['doAntiAlias', doAntiAlias],
        ],
        callback: (Canvas canvas) {
          canvas.clipPath(path, doAntiAlias: doAntiAlias);
        },
      ),
    );

    a.clipPath(path, doAntiAlias: doAntiAlias);
  }

  @override
  void clipRRect(RRect rrect, {bool doAntiAlias = true}) {
    _commands.add(
      Command(
        name: 'clipRRect',
        args: <dynamic>[
          rrect,
        ],
        callback: (Canvas canvas) {
          canvas.clipRRect(rrect, doAntiAlias: doAntiAlias);
        },
        optional: [
          <dynamic>['doAntiAlias', doAntiAlias],
        ],
      ),
    );
    a.clipRRect(rrect, doAntiAlias: doAntiAlias);
  }

  @override
  void clipRect(Rect rect,
      {ClipOp clipOp = ClipOp.intersect, bool doAntiAlias = true}) {
    _commands.add(
      Command(
        name: 'clipRect',
        args: <dynamic>[
          rect,
        ],
        callback: (Canvas canvas) {
          canvas.clipRect(rect, clipOp: clipOp, doAntiAlias: doAntiAlias);
        },
        optional: [
          <dynamic>['doAntiAlias', doAntiAlias],
          <dynamic>['clipOp', clipOp],
        ],
      ),
    );

    a.clipRect(rect, clipOp: clipOp, doAntiAlias: doAntiAlias);
  }

  @override
  void drawArc(Rect rect, double startAngle, double sweepAngle, bool useCenter,
      Paint paint) {
    _commands.add(
      Command(
        name: 'drawArc',
        args: <dynamic>[
          rect,
          startAngle,
          sweepAngle,
          useCenter,
          paint,
        ],
        callback: (Canvas canvas) {
          canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
        },
        optional: [],
      ),
    );

    a.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
  }

  @override
  void drawAtlas(Image atlas, List<RSTransform> transforms, List<Rect> rects,
      List<Color> colors, BlendMode blendMode, Rect cullRect, Paint paint) {
    _commands.add(
      Command(
        name: 'drawAtlas',
        args: <dynamic>[
          atlas,
          transforms,
          rects,
          colors,
          blendMode,
          cullRect,
          paint,
        ],
        callback: (Canvas canvas) {
          canvas.drawAtlas(
              atlas, transforms, rects, colors, blendMode, cullRect, paint);
        },
        optional: [],
      ),
    );
    a.drawAtlas(atlas, transforms, rects, colors, blendMode, cullRect, paint);
  }

  @override
  void drawCircle(Offset c, double radius, Paint paint) {
    _commands.add(
      Command(
        name: 'drawCircle',
        args: <dynamic>[
          c,
          radius,
          paint,
        ],
        callback: (Canvas canvas) {
          canvas.drawCircle(c, radius, paint);
        },
        optional: [],
      ),
    );

    a.drawCircle(c, radius, paint);
  }

  @override
  void drawColor(Color color, BlendMode blendMode) {
    _commands.add(
      Command(
        name: 'drawColor',
        args: <dynamic>[
          color,
          blendMode,
        ],
        optional: [],
        callback: (Canvas canvas) {
          canvas.drawColor(color, blendMode);
        },
      ),
    );
    a.drawColor(color, blendMode);
  }

  @override
  void drawDRRect(RRect outer, RRect inner, Paint paint) {
    _commands.add(
      Command(
        name: 'drawDRRect',
        args: <dynamic>[
          outer,
          inner,
          paint,
        ],
        optional: [],
        callback: (Canvas canvas) {
          canvas.drawDRRect(outer, inner, paint);
        },
      ),
    );
    a.drawDRRect(outer, inner, paint);
  }

  @override
  void drawImage(Image image, Offset offset, Paint paint) {
    _commands.add(
      Command(
        name: 'drawImage',
        args: <dynamic>[
          image,
          offset,
          paint,
        ],
        optional: [],
        callback: (Canvas canvas) {
          canvas.drawImage(image, offset, paint);
        },
      ),
    );
    a.drawImage(image, offset, paint);
  }

  @override
  void drawImageNine(Image image, Rect center, Rect dst, Paint paint) {
    _commands.add(
      Command(
        name: 'drawImageNine',
        args: <dynamic>[
          image,
          center,
          dst,
          paint,
        ],
        optional: [],
        callback: (Canvas canvas) {
          canvas.drawImageNine(image, center, dst, paint);
        },
      ),
    );

    a.drawImageNine(image, center, dst, paint);
  }

  @override
  void drawImageRect(Image image, Rect src, Rect dst, Paint paint) {
    _commands.add(
      Command(
        name: 'drawImageRect',
        args: <dynamic>[
          image,
          src,
          dst,
          paint,
        ],
        optional: [],
        callback: (Canvas canvas) {
          canvas.drawImageRect(image, src, dst, paint);
        },
      ),
    );

    a.drawImageRect(image, src, dst, paint);
  }

  @override
  void drawLine(Offset p1, Offset p2, Paint paint) {
    _commands.add(
      Command(
        name: 'drawLine',
        args: <dynamic>[
          p1,
          p2,
          paint,
        ],
        optional: [],
        callback: (Canvas canvas) {
          canvas.drawLine(p1, p2, paint);
        },
      ),
    );
    a.drawLine(p1, p2, paint);
  }

  @override
  void drawOval(Rect rect, Paint paint) {
    _commands.add(
      Command(
        name: 'drawOval',
        args: <dynamic>[
          rect,
          paint,
        ],
        optional: [],
        callback: (Canvas canvas) {
          canvas.drawOval(rect, paint);
        },
      ),
    );
    a.drawOval(rect, paint);
  }

  @override
  void drawPaint(Paint paint) {
    _commands.add(
      Command(
        name: 'drawPaint',
        args: <dynamic>[
          paint,
        ],
        optional: [],
        callback: (Canvas canvas) {
          canvas.drawPaint(paint);
        },
      ),
    );
    a.drawPaint(paint);
  }

  @override
  void drawParagraph(Paragraph paragraph, Offset offset) {
    // TODO fix paragraphs
    // ignore: dead_code
    if (false) {
      _commands.add(
        Command(
          name: 'drawParagraph',
          args: <dynamic>[
            paragraph,
            offset,
          ],
          optional: [],
          callback: (Canvas canvas) {
            canvas.drawParagraph(paragraph, offset);
          },
        ),
      );
    }
    a.drawParagraph(paragraph, offset);
  }

  @override
  void drawPath(Path path, Paint paint) {
    _commands.add(
      Command(
        name: 'drawPath',
        args: <dynamic>[
          path,
          paint,
        ],
        optional: [],
        callback: (Canvas canvas) {
          if (path is CustomPath) {
            canvas.drawPath(path.internalPath, paint);
          } else {
            canvas.drawPath(path, paint);
          }
        },
      ),
    );

    if (path is CustomPath) {
      path = (path as CustomPath).internalPath;
    }
    a.drawPath(path, paint);
  }

  @override
  void drawPicture(Picture picture) {
    _commands.add(
      Command(
        name: 'drawPicture',
        args: <dynamic>[
          picture,
        ],
        optional: [],
        callback: (Canvas canvas) {
          canvas.drawPicture(picture);
        },
      ),
    );
    a.drawPicture(picture);
  }

  @override
  void drawPoints(PointMode pointMode, List<Offset> points, Paint paint) {
    _commands.add(
      Command(
        name: 'drawPoints',
        args: <dynamic>[
          pointMode,
          points,
          paint,
        ],
        optional: [],
        callback: (Canvas canvas) {
          canvas.drawPoints(pointMode, points, paint);
        },
      ),
    );
    a.drawPoints(pointMode, points, paint);
  }

  @override
  void drawRRect(RRect rrect, Paint paint) {
    _commands.add(
      Command(
        name: 'drawRRect',
        args: <dynamic>[
          rrect,
          paint,
        ],
        optional: [],
        callback: (Canvas canvas) {
          canvas.drawRRect(rrect, paint);
        },
      ),
    );
    a.drawRRect(rrect, paint);
  }

  @override
  void drawRawAtlas(Image atlas, Float32List rstTransforms, Float32List rects,
      Int32List colors, BlendMode blendMode, Rect cullRect, Paint paint) {
    _commands.add(
      Command(
        name: 'drawRawAtlas',
        args: <dynamic>[
          atlas,
          rstTransforms,
          rects,
          colors,
          blendMode,
          cullRect,
          paint,
        ],
        optional: [],
        callback: (Canvas canvas) {
          canvas.drawRawAtlas(
              atlas, rstTransforms, rects, colors, blendMode, cullRect, paint);
        },
      ),
    );
    a.drawRawAtlas(
        atlas, rstTransforms, rects, colors, blendMode, cullRect, paint);
  }

  @override
  void drawRawPoints(PointMode pointMode, Float32List points, Paint paint) {
    _commands.add(
      Command(
        name: 'drawRawPoints',
        args: <dynamic>[
          pointMode,
          points,
          paint,
        ],
        optional: [],
        callback: (Canvas canvas) {
          canvas.drawRawPoints(pointMode, points, paint);
        },
      ),
    );
    a.drawRawPoints(pointMode, points, paint);
  }

  @override
  void drawRect(Rect rect, Paint paint) {
    _commands.add(
      Command(
        name: 'drawRect',
        args: <dynamic>[
          rect,
          paint,
        ],
        optional: [],
        callback: (Canvas canvas) {
          canvas.drawRect(rect, paint);
        },
      ),
    );
    a.drawRect(rect, paint);
  }

  @override
  void drawShadow(
      Path path, Color color, double elevation, bool transparentOccluder) {
    _commands.add(
      Command(
        name: 'drawShadow',
        args: <dynamic>[
          path,
          color,
          elevation,
          transparentOccluder,
        ],
        optional: [],
        callback: (Canvas canvas) {
          if (path is CustomPath) {
            canvas.drawShadow(
                path.internalPath, color, elevation, transparentOccluder);
          } else {
            canvas.drawShadow(path, color, elevation, transparentOccluder);
          }
        },
      ),
    );
    if (path is CustomPath) {
      path = (path as CustomPath).internalPath;
    }
    a.drawShadow(path, color, elevation, transparentOccluder);
  }

  @override
  void drawVertices(Vertices vertices, BlendMode blendMode, Paint paint) {
    _commands.add(
      Command(
        name: 'drawVertices',
        args: <dynamic>[
          vertices,
          blendMode,
          paint,
        ],
        optional: [],
        callback: (Canvas canvas) {
          canvas.drawVertices(vertices, blendMode, paint);
        },
      ),
    );
    a.drawVertices(vertices, blendMode, paint);
  }

  @override
  int getSaveCount() {
    return a.getSaveCount();
  }

  @override
  void restore() {
    _commands.add(
      Command(
        name: 'restore',
        args: <dynamic>[],
        optional: [],
        callback: (Canvas canvas) {
          canvas.restore();
        },
      ),
    );
    a.restore();
  }

  @override
  void rotate(double radians) {
    _commands.add(
      Command(
        name: 'rotate',
        args: <dynamic>[
          radians,
        ],
        optional: [],
        callback: (Canvas canvas) {
          canvas.rotate(radians);
        },
      ),
    );
    a.rotate(radians);
  }

  @override
  void save() {
    _commands.add(
      Command(
        name: 'save',
        args: <dynamic>[],
        optional: [],
        callback: (Canvas canvas) {
          canvas.save();
        },
      ),
    );
    a.save();
  }

  @override
  void saveLayer(Rect bounds, Paint paint) {
    _commands.add(
      Command(
        name: 'saveLayer',
        args: <dynamic>[
          bounds,
          paint,
        ],
        optional: [],
        callback: (Canvas canvas) {
          canvas.saveLayer(bounds, paint);
        },
      ),
    );
    a.saveLayer(bounds, paint);
  }

  @override
  void scale(double sx, [double sy]) {
    _commands.add(
      Command(
        name: 'scale',
        args: <dynamic>[
          sx,
          sy,
        ],
        optional: [],
        callback: (Canvas canvas) {
          canvas.scale(sx, sy);
        },
      ),
    );
    a.scale(sx, sy);
  }

  @override
  void skew(double sx, double sy) {
    _commands.add(
      Command(
        name: 'skew',
        args: <dynamic>[
          sx,
          sy,
        ],
        optional: [],
        callback: (Canvas canvas) {
          canvas.skew(sx, sy);
        },
      ),
    );
    a.skew(sx, sy);
  }

  @override
  void transform(Float64List matrix4) {
    _commands.add(
      Command(
        name: 'transform',
        args: <dynamic>[
          matrix4,
        ],
        optional: [],
        callback: (Canvas canvas) {
          canvas.transform(matrix4);
        },
      ),
    );
    a.transform(matrix4);
  }

  @override
  void translate(double dx, double dy) {
    _commands.add(
      Command(
        name: 'translate',
        args: <dynamic>[
          dx,
          dy,
        ],
        optional: [],
        callback: (Canvas canvas) {
          canvas.translate(dx, dy);
        },
      ),
    );
    a.translate(dx, dy);
  }
}
