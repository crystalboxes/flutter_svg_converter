import 'package:flutter/material.dart';
import 'package:flutter_svg_converter/app/util/get_tiger.dart';
import 'package:provider/provider.dart';

import 'app_controls.dart';
import 'input_view.dart';
import 'result_view.dart';
import 'state.dart';

class SVGToolAppUI extends StatelessWidget {
  final bool showsCodeOnInit;
  const SVGToolAppUI({
    Key key,
    this.showsCodeOnInit = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SVGToolState.initializeWith(getTiger())
        ..setIsViewingImage(!showsCodeOnInit),
      builder: (context, child) {
        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: InputView(),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 5,
                child: ResultView(),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Controls(),
            ],
          ),
        );
      },
    );
  }
}
