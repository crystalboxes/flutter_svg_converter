import 'dart:math';

import 'package:flutter/material.dart';

import '../flutter_svg.dart';

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
