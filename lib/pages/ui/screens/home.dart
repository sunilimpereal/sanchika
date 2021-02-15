import 'package:flutter/material.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';
import 'package:sanchika/pages/ui/widget/product_card.dart';

class Home extends StatefulWidget with NavigationStates {
  final Function onMenuTap;

  const Home({Key key, this.onMenuTap}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                  height: 40,
                ),
              )
            ],
          ),
          actions: [],
          leading: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: InkWell(
              child: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onTap: widget.onMenuTap,
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Productcard(),
          ],
        ),
      ),
    );
  }
}
// Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   InkWell(
//                     child: Icon(Icons.menu, color: Colors.black),
//                     onTap: widget.onMenuTap,
//                   ),
//                   Text("Sanchika")
//                 ],
//               )
