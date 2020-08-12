import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart' show Ticker, TickerProvider;
import 'package:flutter_svg_tool/app/util/conversion.dart';
import 'package:provider/provider.dart';

import 'clipboard_button.dart';
import 'state.dart';

class Controls extends StatelessWidget implements TickerProvider {
  const Controls({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x17000000),
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(32),
        ),
      ),
      padding: EdgeInsets.only(top: 20, bottom: 5),
      child: AnimatedSize(
        alignment: Alignment.centerLeft,
        vsync: this,
        curve: Curves.easeOut,
        duration: Duration(milliseconds: 150),
        child: Consumer<SVGToolState>(
          builder: (context, state, child) => Column(
            children: [
              SideMenuButton(
                onPressed: state.isViewingImage
                    ? null
                    : () {
                        state.setIsViewingImage(true);
                      },
                title: state.isViewingImage ? null : 'Show Image',
                icon: Icon(
                  Icons.image,
                  color: state.isViewingImage
                      ? Theme.of(context).selectedRowColor
                      : Theme.of(context).primaryColor,
                ),
              ),
              SideMenuButton(
                title: !state.isViewingImage ? null : 'Show Code',
                onPressed: !state.isViewingImage
                    ? null
                    : () {
                        state.setIsViewingImage(false);
                      },
                icon: Icon(Icons.code,
                    color: !state.isViewingImage
                        ? Theme.of(context).selectedRowColor
                        : Theme.of(context).primaryColor),
              ),
              if (!state.isViewingImage)
                ClipboardButton(
                  generatedSource: state.generatedSource,
                ),
              if (!state.isViewingImage)
                SideMenuButton(
                  title: 'Format with dart_style',
                  onPressed: () {
                    state.setGeneratedSource(
                        formatCustomPainterSource(state.generatedSource));
                  },
                  icon: Icon(Icons.format_indent_increase),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Ticker createTicker(onTick) {
    // TODO: implement createTicker
    return Ticker(onTick);
  }
}

const sideMenuButtonMargin = 15.0;

class SideMenuButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;
  final String title;

  const SideMenuButton({Key key, this.icon, this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: sideMenuButtonMargin),
      child: onPressed == null
          ? IconButton(
              onPressed: onPressed,
              tooltip: title,
              icon: icon,
            )
          : Material(
              shape: CircleBorder(),
              child: IconButton(
                onPressed: onPressed,
                tooltip: title,
                icon: icon,
              ),
            ),
    );
  }
}
