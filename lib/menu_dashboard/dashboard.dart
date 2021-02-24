import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  final bool isCollapsed;
  final double screenWidth;
  final Duration duration;
  final Animation<double> scaleAnimation;
  final Function onMenuTap;
  final Function onMenuItemClicked;
  final Widget child;

  const Dashboard(
      {Key key,
      this.isCollapsed,
      this.screenWidth,
      this.duration,
      this.scaleAnimation,
      this.onMenuTap,
      this.child,
      this.onMenuItemClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.5 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: Material(
          animationDuration: duration,
          elevation: 8,
          borderOnForeground: true,
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(isCollapsed ? 0 : 30),
          child: GestureDetector(
              onTap: () {
                if (isCollapsed) {
                } else {
                  print('tap on dash');
                }
              },
              child: child),
        ),
      ),
    );
  }
}
