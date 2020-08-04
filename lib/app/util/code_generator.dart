// svg code tansformer

import 'dart:ui';

import '../../flutter_svg.dart';

class CustomPictureCodeGenerator {
  final CustomPicture picture;
  CustomPictureCodeGenerator({this.picture});

  Size _size;

  String generateSource() {
    picture.calculateBounds();

    _size = picture.clipRect;

    return '';
  }
}
