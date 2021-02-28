import 'package:flutter/material.dart';

class ProgressHUD extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  final double opacity;
  final color;
  final Animation<Color> valueColor;
  ProgressHUD({
    Key key,
    this.child,
    this.inAsyncCall,
    this.opacity,
    this.color,
    this.valueColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = new List<Widget>();
    widgetList.add(child);
    if (inAsyncCall) {
      final modal = new Stack(
        children: [
          new Opacity(
            opacity: opacity,
            child: ModalBarrier(
              dismissible: false,
              color: color,
            ),
          ),
          new Center(
            child: new CircularProgressIndicator(),
          ),
        ],
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}
