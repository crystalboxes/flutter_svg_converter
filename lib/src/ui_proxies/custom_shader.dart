import 'package:flutter/cupertino.dart';

var shaderMap = <Shader, String>{};

class CustomShader implements Shader {
  final Shader shader;
  final String constructionSource;

  CustomShader(this.shader, this.constructionSource);
}
