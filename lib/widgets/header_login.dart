import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sanchika/utils/constants.dart';

class MyHeader extends StatefulWidget {
  final Widget child;
  final String textTop;
  final String textBottom;
  final double offset;
  const MyHeader(
      {Key key, this.child, this.textTop, this.textBottom, this.offset})
      : super(key: key);

  @override
  _MyHeaderState createState() => _MyHeaderState();
}

class _MyHeaderState extends State<MyHeader> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.only(left: 20, top: 50, right: 20, bottom: 0),
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            const BoxShadow(
              color: Colors.blue,
            ),
            const BoxShadow(
              color: Colors.white,
              spreadRadius: -12.0,
              blurRadius: 12.0,
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF3383CD),
              Color(0xFF11249F),
            ],
          ),
          image: DecorationImage(
            image: AssetImage("assets/images/virus.png"),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(height: 00),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -40,
                    left: -20,
                    child:widget.child,
                  ),
                  Positioned(
                    top: 20 - widget.offset / 2,
                    left: 200,
                    child: Text(
                      "${widget.textTop} \n${widget.textBottom}",
                      style: kHeadingTextStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(), // I dont know why it can't work without container
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
