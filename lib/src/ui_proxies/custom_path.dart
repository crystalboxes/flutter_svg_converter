import 'dart:typed_data';
import 'dart:ui';

import 'package:meta/meta.dart';

typedef void CanvasCallback(Canvas canvas);

class Command {
  final String name;
  final List<dynamic> args;
  final List<List<dynamic>> optional;
  final CanvasCallback callback;

  Command({this.name, this.args, this.optional, @required this.callback});
}

class CustomPath implements Path {
  Path _path = Path();

  Path get internalPath => _path;

  List<Command> commands = [];

  @override
  PathFillType fillType;

  @override
  void addArc(Rect oval, double startAngle, double sweepAngle) {
    commands.add(
      Command(
        name: 'addArc',
        args: <dynamic>[
          oval,
          startAngle,
          sweepAngle,
        ],
        callback: null,
      ),
    );
    _path.addArc(oval, startAngle, sweepAngle);
  }

  @override
  void addOval(Rect oval) {
    commands.add(
      Command(
        name: 'addOval',
        args: <dynamic>[
          oval,
        ],
        callback: null,
      ),
    );

    _path.addOval(oval);
  }

  @override
  void addPath(Path path, Offset offset, {Float64List matrix4}) {
    commands.add(
      Command(
        name: 'addPath',
        args: <dynamic>[
          path,
          offset,
          matrix4,
        ],
        callback: null,
      ),
    );

    _path.addPath(path, offset, matrix4: matrix4);
  }

  @override
  void addPolygon(List<Offset> points, bool close) {
    commands.add(
      Command(
        name: 'addPolygon',
        args: <dynamic>[
          points,
          close,
        ],
        callback: null,
      ),
    );

    _path.addPolygon(points, close);
  }

  @override
  void addRRect(RRect rrect) {
    commands.add(
      Command(
        name: 'addRRect',
        args: <dynamic>[
          rrect,
        ],
        callback: null,
      ),
    );

    _path.addRRect(rrect);
  }

  @override
  void addRect(Rect rect) {
    commands.add(
      Command(
        name: 'addRect',
        args: <dynamic>[
          rect,
        ],
        callback: null,
      ),
    );

    _path.addRect(rect);
  }

  @override
  void arcTo(
      Rect rect, double startAngle, double sweepAngle, bool forceMoveTo) {
    commands.add(
      Command(
        name: 'arcTo',
        args: <dynamic>[
          rect,
          startAngle,
          sweepAngle,
          forceMoveTo,
        ],
        callback: null,
      ),
    );
    _path.arcTo(rect, startAngle, sweepAngle, forceMoveTo);
  }

  @override
  void arcToPoint(Offset arcEnd,
      {Radius radius = Radius.zero,
      double rotation = 0.0,
      bool largeArc = false,
      bool clockwise = true}) {
    commands.add(
      Command(name: 'arcToPoint', callback: null, args: <dynamic>[
        arcEnd,
      ], optional: <List<dynamic>>[
        <dynamic>['radius', radius],
        <dynamic>['largeArc', largeArc],
        <dynamic>['clockwise', clockwise],
      ]),
    );
    _path.arcToPoint(
      arcEnd,
      radius: radius,
      rotation: rotation,
      largeArc: largeArc,
      clockwise: clockwise,
    );
  }

  @override
  void close() {
    commands.add(
      Command(
        name: 'close',
        callback: null,
      ),
    );
    _path.close();
  }

  @override
  PathMetrics computeMetrics({bool forceClosed = false}) {
    print('unimplemented computeMetrics');
    return _path.computeMetrics(forceClosed: forceClosed);
  }

  @override
  void conicTo(double x1, double y1, double x2, double y2, double w) {
    commands.add(
      Command(
        name: 'conicTo',
        args: <dynamic>[
          x1,
          y1,
          x2,
          y2,
          w,
        ],
        callback: null,
      ),
    );

    _path.conicTo(x1, y1, x2, y2, w);
  }

  @override
  bool contains(Offset point) {
    print('unimplemented contains');
    return _path.contains(point);
  }

  @override
  void cubicTo(
      double x1, double y1, double x2, double y2, double x3, double y3) {
    commands.add(
      Command(
        name: 'cubicTo',
        args: <dynamic>[
          x1,
          y1,
          x2,
          y2,
          x3,
          y3,
        ],
        callback: null,
      ),
    );

    _path.cubicTo(x1, y1, x2, y2, x3, y3);
  }

  @override
  void extendWithPath(Path path, Offset offset, {Float64List matrix4}) {
    print('unimplemented extendWithPath');
    _path.extendWithPath(path, offset, matrix4: matrix4);
  }

  @override
  Rect getBounds() {
    // print('unimplemented getBounds');
    return _path.getBounds();
  }

  @override
  void lineTo(double x, double y) {
    commands.add(
      Command(
        name: 'lineTo',
        args: <dynamic>[
          x,
          y,
        ],
        callback: null,
      ),
    );

    _path.lineTo(x, y);
  }

  @override
  void moveTo(double x, double y) {
    commands.add(
      Command(
        name: 'moveTo',
        args: <dynamic>[
          x,
          y,
        ],
        callback: null,
      ),
    );
    _path.moveTo(x, y);
  }

  @override
  void quadraticBezierTo(double x1, double y1, double x2, double y2) {
    commands.add(
      Command(
        name: 'quadraticBezierTo',
        args: <dynamic>[
          x1,
          y1,
          x2,
          y2,
        ],
        callback: null,
      ),
    );
    _path.quadraticBezierTo(x1, y1, x2, y2);
  }

  @override
  void relativeArcToPoint(Offset arcEndDelta,
      {Radius radius = Radius.zero,
      double rotation = 0.0,
      bool largeArc = false,
      bool clockwise = true}) {
    commands.add(
      Command(name: 'relativeArcToPoint', callback: null, args: <dynamic>[
        arcEndDelta,
      ], optional: [
        <dynamic>['radius', radius],
        <dynamic>['rotation', rotation],
        <dynamic>['largeArc', largeArc],
        <dynamic>['clockwise', clockwise],
      ]),
    );

    _path.relativeArcToPoint(arcEndDelta,
        radius: radius,
        rotation: rotation,
        largeArc: largeArc,
        clockwise: clockwise);
  }

  @override
  void relativeConicTo(double x1, double y1, double x2, double y2, double w) {
    commands.add(
      Command(
        name: 'relativeConicTo',
        callback: null,
        args: <dynamic>[
          x1,
          y1,
          x2,
          y2,
          w,
        ],
      ),
    );

    _path.relativeConicTo(x1, y1, x2, y2, w);
  }

  @override
  void relativeCubicTo(
      double x1, double y1, double x2, double y2, double x3, double y3) {
    commands.add(
      Command(
        name: 'relativeCubicTo',
        callback: null,
        args: <dynamic>[
          x1,
          y1,
          x2,
          y2,
          x3,
          y3,
        ],
      ),
    );

    _path.relativeCubicTo(x1, y1, x2, y2, x3, y3);
  }

  @override
  void relativeLineTo(double dx, double dy) {
    commands.add(
      Command(
        name: 'relativeLineTo',
        callback: null,
        args: <dynamic>[
          dx,
          dy,
        ],
      ),
    );

    _path.relativeLineTo(dx, dy);
  }

  @override
  void relativeMoveTo(double dx, double dy) {
    commands.add(
      Command(
        name: 'relativeMoveTo',
        callback: null,
        args: <dynamic>[
          dx,
          dy,
        ],
      ),
    );

    _path.relativeMoveTo(dx, dy);
  }

  @override
  void relativeQuadraticBezierTo(double x1, double y1, double x2, double y2) {
    commands.add(
      Command(
        name: 'relativeQuadraticBezierTo',
        callback: null,
        args: <dynamic>[
          x1,
          y1,
        ],
      ),
    );

    _path.relativeQuadraticBezierTo(x1, y1, x2, y2);
  }

  @override
  void reset() {
    commands.add(
      Command(
        name: 'reset',
        callback: null,
        args: <dynamic>[],
      ),
    );
    _path.reset();
  }

  @override
  Path shift(Offset offset) {
    print('unimplemented');
    return _path.shift(offset);
  }

  @override
  Path transform(Float64List matrix4) {
    commands.add(
      Command(
        name: 'transform',
        callback: null,
        args: <dynamic>[matrix4],
      ),
    );

    return _path.transform(matrix4);
  }
}
