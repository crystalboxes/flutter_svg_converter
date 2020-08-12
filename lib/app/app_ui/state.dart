import 'package:flutter/material.dart';
import '../../flutter_svg.dart';
import '../util/conversion.dart';

class SVGToolState with ChangeNotifier {
  SVGToolState.initializeWith(String svgSource) {
    setInputSource(svgSource);
  }

  String inputSource;
  CustomPicture picture;
  String generatedSource = '';
  List<String> generatedSourceLines;

  String error;

  bool isViewingImage = true;

  _transformSource(String input) {
    parseSvgSource(input).then((value) {
      setPicture(value.item1);
      setGeneratedSource(value.item2);
    }).catchError((error) => setError(error));
  }

  setError(dynamic inError) {
    error = inError.toString();
    notifyListeners();
  }

  setIsViewingImage(bool value) {
    isViewingImage = value;
    notifyListeners();
  }

  setInputSource(String source) {
    inputSource = source;
    picture = null;
    generatedSource = '';
    generatedSourceLines = null;
    error = '';

    _transformSource(source);
    notifyListeners();
  }

  setPicture(CustomPicture incomingPicture) {
    picture = incomingPicture;
    notifyListeners();
  }

  setGeneratedSource(String incomingGeneratedSource) {
    generatedSource = incomingGeneratedSource;
    generatedSourceLines = generatedSource.split('\n');
    notifyListeners();
  }
}
