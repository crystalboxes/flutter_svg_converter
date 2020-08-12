import 'package:dart_style/dart_style.dart';
import 'package:tuple/tuple.dart';

import '../../flutter_svg.dart';
import 'code_generator.dart';

Future<Tuple2<CustomPicture, String>> parseSvgSource(String svgSource) async {
  final DrawableRoot svgRoot = await svg.fromSvgString(svgSource, svgSource);
  final CustomPicture picture = svgRoot.toPicture() as CustomPicture;
  return Tuple2<CustomPicture, String>(
      picture, CustomPictureCodeGenerator(picture: picture).generateSource());
}

final formatter = new DartFormatter();
String formatCustomPainterSource(String src) => formatter.format(src);
