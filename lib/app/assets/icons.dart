import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class FlutterIcon extends CustomPainter {
  static const size = Size(29.1, 35.998);
  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(min(size.width / 29.1, size.height / 29.1));
    canvas.save();
    canvas.clipRect(
      Rect.fromLTWH(0, 0, 29.1, 35.998),
      doAntiAlias: true,
      clipOp: ClipOp.intersect,
    );
    canvas.save();
    canvas.transform(
      Float64List.fromList([
        1,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        1,
        0,
        -3.45,
        0,
        0,
        1,
      ]),
    );
    canvas.drawPath(
      () {
        var path = Path();
        path.moveTo(
          21.471,
          0,
        );
        path.lineTo(
          3.45,
          18,
        );
        path.lineTo(
          9,
          23.55,
        );
        path.lineTo(
          32.526,
          0.018000000000000002,
        );
        path.lineTo(
          21.491,
          0.018000000000000002,
        );
        path.close();
        path.moveTo(
          21.492,
          16.608,
        );
        path.lineTo(
          11.785,
          26.293,
        );
        path.lineTo(
          21.491,
          36,
        );
        path.lineTo(
          32.55,
          36,
        );
        path.lineTo(
          22.86,
          26.3,
        );
        path.lineTo(
          32.55,
          16.61,
        );
        path.lineTo(
          21.493,
          16.61,
        );
        path.close();
        return path;
      }(),
      Paint()..color = Color.fromARGB(255, 0, 0, 0),
    );
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class MdCopyIcon extends CustomPainter {
  static const size = Size(16.962, 21);
  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(min(size.width / 16.962, size.height / 21));
    canvas.save();
    canvas.clipRect(
      Rect.fromLTWH(0, 0, 16.962, 21),
      doAntiAlias: true,
      clipOp: ClipOp.intersect,
    );
    canvas.save();
    canvas.transform(
      Float64List.fromList([
        1,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        1,
        0,
        -6.188,
        -3.375,
        0,
        1,
      ]),
    );
    canvas.drawPath(
      () {
        var path = Path();
        path.moveTo(
          16.688,
          3.375,
        );
        path.lineTo(
          10.655,
          3.375,
        );
        path.cubicTo(
          9.53990280626526,
          3.3611070004143304,
          8.624722145197707,
          4.253900659009586,
          8.611000050188206,
          5.369000031292589,
        );
        path.lineTo(
          8.611,
          5.8,
        );
        path.lineTo(
          8.232,
          5.8,
        );
        path.cubicTo(
          7.117673845427006,
          5.786102489771549,
          6.20281639428451,
          6.677685680904548,
          6.188000036066035,
          7.792000045414761,
        );
        path.lineTo(
          6.188,
          22.331,
        );
        path.cubicTo(
          6.1977766354020405,
          23.455795299337872,
          7.1072044362598765,
          24.36522310019571,
          8.2319999287845,
          24.37499978913049,
        );
        path.lineTo(
          18.732,
          24.375,
        );
        path.cubicTo(
          19.847099481460273,
          24.36127804705734,
          20.739893140055536,
          23.446097385989788,
          20.72600012079907,
          22.331000130153626,
        );
        path.lineTo(
          20.726,
          21.951999999999998,
        );
        path.lineTo(
          21.154999999999998,
          21.951999999999998,
        );
        path.cubicTo(
          22.270099495582446,
          21.938278032935163,
          23.1628931541777,
          21.02309737186761,
          23.149000134921238,
          19.90800011603145,
        );
        path.lineTo(
          23.148999999999997,
          9.837,
        );
        path.close();
        path.moveTo(
          16.688,
          5.6259999999999994,
        );
        path.lineTo(
          20.898,
          9.835999999999999,
        );
        path.lineTo(
          16.688,
          9.835999999999999,
        );
        path.close();
        path.moveTo(
          19.110999999999997,
          22.326,
        );
        path.cubicTo(
          19.123560731973015,
          22.548692814589604,
          18.9545424859923,
          22.740008982203662,
          18.73199981713307,
          22.754999777859442,
        );
        path.lineTo(
          8.232,
          22.755,
        );
        path.cubicTo(
          7.999608380840035,
          22.74438649604107,
          7.813614151567331,
          22.558392266768365,
          7.803000165367116,
          22.32600047314959,
        );
        path.lineTo(
          7.802999999999999,
          7.792,
        );
        path.cubicTo(
          7.817990719480752,
          7.569457255073128,
          8.00930688709481,
          7.40043900909241,
          8.231999919636955,
          7.412999927632258,
        );
        path.lineTo(
          8.610999999999999,
          7.412999999999999,
        );
        path.lineTo(
          8.610999999999999,
          20.313,
        );
        path.cubicTo(
          8.538582765834636,
          20.766590235367666,
          8.687995591904505,
          21.227405063534306,
          9.012794729065119,
          21.552204200694923,
        );
        path.cubicTo(
          9.337593866225733,
          21.877003337855538,
          9.798408694392373,
          22.026416163925404,
          10.251999641024044,
          21.953999231276036,
        );
        path.lineTo(
          19.110999999999997,
          21.954,
        );
        path.close();
        path.moveTo(
          21.534,
          19.903,
        );
        path.cubicTo(
          21.546560708319024,
          20.12569283824359,
          21.377542462338308,
          20.31700900585765,
          21.15499979347908,
          20.33199980151343,
        );
        path.lineTo(
          10.654999999999998,
          20.331999999999997,
        );
        path.cubicTo(
          10.422608432190096,
          20.321386444691004,
          10.23661420291739,
          20.1353922154183,
          10.226000216717175,
          19.903000421799526,
        );
        path.lineTo(
          10.225999999999997,
          5.369,
        );
        path.cubicTo(
          10.24099069582676,
          5.1464572787271194,
          10.432306863440818,
          4.9774390327464015,
          10.654999895982963,
          4.98999995128625,
        );
        path.lineTo(
          15.071999999999997,
          4.989999999999999,
        );
        path.lineTo(
          15.071999999999997,
          11.451999999999998,
        );
        path.lineTo(
          21.534,
          11.451999999999998,
        );
        path.close();
        return path;
      }(),
      Paint()..color = Color.fromARGB(255, 0, 0, 0),
    );
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class MetroLines extends CustomPainter {
  static const size = Size(14.039, 9.827);
  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(min(size.width / 14.039, size.height / 9.827));
    canvas.save();
    canvas.clipRect(
      Rect.fromLTWH(0, 0, 14.039, 9.827),
      doAntiAlias: true,
      clipOp: ClipOp.intersect,
    );
    canvas.save();
    canvas.transform(
      Float64List.fromList([
        1,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        1,
        0,
        -8.355,
        -9.64,
        0,
        1,
      ]),
    );
    canvas.drawPath(
      () {
        var path = Path();
        path.moveTo(
          9.057,
          11.044,
        );
        path.lineTo(
          21.692,
          11.044,
        );
        path.cubicTo(
          22.078599466062823,
          11.044000058541975,
          22.392000135844086,
          10.730599388760712,
          22.392000135844086,
          10.344000070462904,
        );
        path.cubicTo(
          22.392000135844086,
          9.957400752165096,
          22.078599466062823,
          9.644000082383833,
          21.692000147765015,
          9.644000082383833,
        );
        path.lineTo(
          9.057,
          9.644,
        );
        path.cubicTo(
          8.670400743398105,
          9.644000082383833,
          8.357000073616842,
          9.957400752165096,
          8.357000073616842,
          10.344000070462904,
        );
        path.cubicTo(
          8.357000073616842,
          10.730599388760712,
          8.670400743398105,
          11.044000058541975,
          9.057000061695913,
          11.044000058541975,
        );
        path.close();
        path.moveTo(
          21.692,
          12.444,
        );
        path.lineTo(
          9.057,
          12.444,
        );
        path.cubicTo(
          8.670400743398105,
          12.44400010145732,
          8.357000073616842,
          12.757400771238583,
          8.357000073616842,
          13.14400008953639,
        );
        path.cubicTo(
          8.357000073616842,
          13.530599407834199,
          8.670400743398105,
          13.844000077615462,
          9.057000061695913,
          13.844000077615462,
        );
        path.lineTo(
          21.692,
          13.844000000000001,
        );
        path.cubicTo(
          22.078599466062823,
          13.844000077615462,
          22.392000135844086,
          13.530599407834199,
          22.392000135844086,
          13.14400008953639,
        );
        path.cubicTo(
          22.392000135844086,
          12.757400771238583,
          22.078599466062823,
          12.44400010145732,
          21.692000147765015,
          12.44400010145732,
        );
        path.close();
        path.moveTo(
          21.692,
          15.252,
        );
        path.lineTo(
          9.057,
          15.252,
        );
        path.cubicTo(
          8.670400743398105,
          15.252000120585299,
          8.357000073616842,
          15.565400790366562,
          8.357000073616842,
          15.95200010866437,
        );
        path.cubicTo(
          8.357000073616842,
          16.33859942696218,
          8.670400743398105,
          16.652000096743443,
          9.057000061695913,
          16.652000096743443,
        );
        path.lineTo(
          21.692,
          16.652,
        );
        path.cubicTo(
          22.078599466062823,
          16.652000096743443,
          22.392000135844086,
          16.33859942696218,
          22.392000135844086,
          15.95200010866437,
        );
        path.cubicTo(
          22.392000135844086,
          15.565400790366562,
          22.078599466062823,
          15.252000120585299,
          21.692000147765015,
          15.252000120585299,
        );
        path.close();
        path.moveTo(
          21.692,
          18.060000000000002,
        );
        path.lineTo(
          9.057,
          18.060000000000002,
        );
        path.cubicTo(
          8.670400743398105,
          18.06000013971328,
          8.357000073616842,
          18.373400809494544,
          8.357000073616842,
          18.760000127792352,
        );
        path.cubicTo(
          8.357000073616842,
          19.14659944609016,
          8.670400743398105,
          19.460000115871424,
          9.057000061695913,
          19.460000115871424,
        );
        path.lineTo(
          21.692,
          19.46,
        );
        path.cubicTo(
          22.078599466062823,
          19.460000115871424,
          22.392000135844086,
          19.14659944609016,
          22.392000135844086,
          18.760000127792352,
        );
        path.cubicTo(
          22.392000135844086,
          18.373400809494544,
          22.078599466062823,
          18.06000013971328,
          21.692000147765015,
          18.06000013971328,
        );
        path.close();
        return path;
      }(),
      Paint()..color = Color(0xFFABABAB),
    );
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class HeightIcon extends CustomPainter {
  static const size = Size(10.762, 17.219);
  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(min(size.width / 10.762, size.height / 17.219));
    canvas.save();
    canvas.clipRect(
      Rect.fromLTWH(0, 0, 10.762, 17.219),
      doAntiAlias: true,
      clipOp: ClipOp.intersect,
    );
    canvas.drawPath(
      () {
        var path = Path();
        path.moveTo(
          5.381,
          0,
        );
        path.lineTo(
          0,
          6.457,
        );
        path.lineTo(
          4.3,
          6.457,
        );
        path.lineTo(
          4.3,
          10.757,
        );
        path.lineTo(
          0,
          10.757,
        );
        path.lineTo(
          5.381,
          17.214,
        );
        path.lineTo(
          10.762,
          10.756999999999998,
        );
        path.lineTo(
          6.462000000000001,
          10.756999999999998,
        );
        path.lineTo(
          6.462000000000001,
          6.456999999999998,
        );
        path.lineTo(
          10.762,
          6.456999999999998,
        );
        path.close();
        return path;
      }(),
      Paint()..color = Color(0xFFABABAB),
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class WidthIcon extends CustomPainter {
  static const size = Size(17.219, 10.762);
  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(min(size.width / 17.219, size.height / 10.762));
    canvas.save();
    canvas.clipRect(
      Rect.fromLTWH(0, 0, 17.219, 10.762),
      doAntiAlias: true,
      clipOp: ClipOp.intersect,
    );
    canvas.drawPath(
      () {
        var path = Path();
        path.moveTo(
          6.457,
          0,
        );
        path.lineTo(
          0,
          5.381,
        );
        path.lineTo(
          6.457,
          10.762,
        );
        path.lineTo(
          6.457,
          6.462000000000001,
        );
        path.lineTo(
          10.757,
          6.462000000000001,
        );
        path.lineTo(
          10.757,
          10.762,
        );
        path.lineTo(
          17.214,
          5.381,
        );
        path.lineTo(
          10.762,
          0,
        );
        path.lineTo(
          10.762,
          4.3,
        );
        path.lineTo(
          6.462000000000001,
          4.3,
        );
        path.close();
        return path;
      }(),
      Paint()..color = Color(0xFFABABAB),
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
