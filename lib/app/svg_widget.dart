import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg_converter/app/custom_picture_view.dart';
import 'package:flutter_svg_converter/app/util/conversion.dart';
import 'dart:ui' as ui;
import '../flutter_svg.dart';

class ImagePainter extends CustomPainter {
  final ui.Image image;

  ImagePainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(min(size.width / image.width, size.height / image.height));
    canvas.drawImage(image, Offset(0, 0), Paint());
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class SVGWidget extends StatefulWidget {
  final String source;
  final Size size;
  final bool rasterize;

  const SVGWidget({this.source, this.size, this.rasterize = false});
  @override
  _SVGWidgetState createState() => _SVGWidgetState();
}

class _SVGWidgetState extends State<SVGWidget> {
  CustomPicture _customPicture;

  double width;
  double height;

  @override
  void initState() {
    parseSvgSource(widget.source).then((value) {
      setState(() {
        _customPicture = value.item1;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _customPicture == null
        ? Container()
        : RepaintBoundary(
            child: CustomPaint(
              isComplex: true,
              willChange: false,
              size: widget.size == null ? _customPicture.clipRect : widget.size,
              painter: CustomPicturePainter(_customPicture),
            ),
          );
  }
}
