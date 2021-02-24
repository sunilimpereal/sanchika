import 'package:flutter/material.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';

class HelpSupportPage extends StatelessWidget with NavigationStates {
  final Function onMenuTap;

  const HelpSupportPage({Key key, this.onMenuTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Help & Support",
          style: TextStyle(color: Colors.black),
        ),
        actions: [],
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: InkWell(
            child: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onTap: onMenuTap,
          ),
        ),
      ),
    );
  }
}
