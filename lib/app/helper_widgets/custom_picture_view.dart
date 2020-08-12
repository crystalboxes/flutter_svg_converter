import 'dart:math';

import 'package:flutter/material.dart';

import '../../flutter_svg.dart';

class CustomPicturePainter extends CustomPainter {
  final CustomPicture picture;
  final bool drawTransparentGrid;
  CustomPicturePainter(this.picture, {this.drawTransparentGrid = false});

  @override
  void paint(Canvas canvas, Size size) {
    if (drawTransparentGrid) {
      const gridSize = 20;
      for (int x = 0; x < gridSize; x++) {
        bool col = x % 2 == 0;
        for (int y = 0; y < gridSize; y++) {
          canvas.drawRect(
              Rect.fromLTWH(
                  x * (size.width / gridSize),
                  y * (size.width / gridSize),
                  (size.width / gridSize),
                  (size.width / gridSize)),
              Paint()
                ..color = col ? Color.fromARGB(20, 0, 0, 0) : Colors.white);
          col = !col;
        }
      }
    }
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
