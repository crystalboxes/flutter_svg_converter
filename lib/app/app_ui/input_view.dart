import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'state.dart';

class InputView extends StatelessWidget {
  const InputView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 329),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Input',
            style: Theme.of(context).textTheme.headline2,
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            constraints: BoxConstraints(maxHeight: 325),
            child: Consumer<SVGToolState>(
              builder: (context, state, child) => DecoratedTextFormField(
                onChanged: (text) => state.setInputSource(text),
                initialValue: state.inputSource,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DecoratedTextFormField extends StatelessWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  const DecoratedTextFormField({this.initialValue, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(6),
      padding: EdgeInsets.all(0),
      strokeWidth: 1,
      color: Color(0x47000000),
      dashPattern: const <double>[4, 4],
      child: Container(
        padding: EdgeInsets.only(
          top: 14,
          left: 15,
          bottom: 12,
          right: 50,
        ),
        child: TextFormField(
          decoration: InputDecoration(
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.all(0),
          ),
          style:
              TextStyle(fontFamily: 'monospace', fontSize: 11, height: 13 / 11),
          maxLines: null,
          keyboardType: TextInputType.multiline,
          onChanged: onChanged,
          initialValue: initialValue,
        ),
      ),
    );
  }
}
