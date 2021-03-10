import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:flutter/services.dart';
class ErrorPage extends StatefulWidget {
  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  Artboard _riveArtboard;
  RiveAnimationController _controller;
  void initState(){
    super.initState();
    rootBundle.load('assets/rive/login.riv').then((value) async{
      final file =RiveFile();
      if(file.import(value)){
        final artboard = file.mainArtboard;
        artboard.addController(_controller = SimpleAnimation('loop'));
        setState(() {
          _riveArtboard = artboard;
          _controller.isActive = true ;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: Center(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 180.0),
              child: Container(
                child: _riveArtboard == null? const SizedBox():Rive(artboard: _riveArtboard,fit: BoxFit.contain,)),
            ),
            Positioned (
              bottom: 200,
              left: 50,
              child: Container(
                width: 350,
                child: Text('Sorry the server is down,Please Try again later',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 23),))),
          ],
        ),
      ), 
    );
  }
}