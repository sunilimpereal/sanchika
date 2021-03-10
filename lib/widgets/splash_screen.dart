import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:flutter/services.dart';

class Splashscreen extends StatefulWidget {
  String logged;
  Splashscreen({this.logged});
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
   Artboard _riveArtboard;
  RiveAnimationController _controller;
  @override
  void initState() {
    super.initState();

     rootBundle.load('assets/rive/splash_screen.riv').then((value) async{
      final file =RiveFile();
      if(file.import(value)){
        final artboard = file.mainArtboard;
        artboard.addController(_controller = SimpleAnimation('logo fill'));
        setState(() {
          _riveArtboard = artboard;
          _controller.isActive = true ;
        });
      }
    });
    //   Future.delayed(Duration(seconds: 2), () {
    //   Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => widget.logged == null ? LoginPage() : MenuDashboard(),,
    //       ));
    // });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Container(color:Colors.white,child: _riveArtboard == null? const SizedBox():Rive(artboard: _riveArtboard,fit: BoxFit.contain,),)),
      
    );
  }
}