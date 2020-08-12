import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../assets/icons.dart';
import '../helper_widgets/illustration_paint.dart';
import 'app_controls.dart';

const actionButtonMargin = 15.0;

class ClipboardButton extends StatelessWidget {
  final String generatedSource;

  const ClipboardButton({
    Key key,
    this.generatedSource,
  });

  @override
  Widget build(BuildContext context) {
    return SideMenuButton(
      onPressed: () {
        _showOverlay(context);
        Clipboard.setData(ClipboardData(text: generatedSource));
      },
      title: 'Copy to clipboard',
      icon: IllustrationPaint(
        painter: MdCopyIcon(),
        size: MdCopyIcon.size,
      ),
    );
  }

  void _showOverlay(BuildContext context) async {
    var overlayState = Overlay.of(context);
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    var entry = OverlayEntry(builder: (context) {
      return _OverlayWidget('Copied!', offset.dx - size.width - 25, offset.dy,
          size.height - actionButtonMargin);
    });

    overlayState.insert(entry);
    await Future.delayed(Duration(seconds: 2));
    entry.remove();
  }
}

class _OverlayWidget extends StatefulWidget {
  final String text;
  final double left;
  final double top;
  final double height;
  const _OverlayWidget(this.text, this.left, this.top, this.height);
  @override
  _OverlayWidgetState createState() => _OverlayWidgetState();
}

class _OverlayWidgetState extends State<_OverlayWidget>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 65), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(seconds: 1), () {
          if (mounted && controller.isCompleted) {
            controller?.reverse();
          }
        });
      }
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.left,
      top: widget.top,
      child: FadeTransition(
        opacity: animation,
        child: Material(
          color: Colors.transparent,
          child: Container(
            height: widget.height,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(6))),
                child: Text(
                  widget.text,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
