import 'package:flutter/material.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';

class Profile extends StatefulWidget with NavigationStates {
  final Function onMenuTap;

  const Profile({Key key, this.onMenuTap}) : super(key: key);
  @override
  PprofileState createState() => PprofileState();
}

class PprofileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                InkWell(
                  child: Icon(Icons.menu, color: Colors.black),
                  onTap: widget.onMenuTap,
                ),
                Text("Profile")
              ],
            )
          ],
        ),
      ),
    );
  }
}
