import 'package:flutter/material.dart';

class IllustrationPaint extends StatelessWidget {
  final CustomPainter painter;
  final Size size;

  const IllustrationPaint({
    Key key,
    @required this.painter,
    @required this.size,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: painter,
        size: size,
        isComplex: true,
        willChange: false,
      ),
    );
  }
}
