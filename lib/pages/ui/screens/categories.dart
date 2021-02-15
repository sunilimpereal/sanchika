import 'package:flutter/material.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';

class Categories extends StatefulWidget with NavigationStates {
  final Function onMenuTap;

  const Categories({Key key, this.onMenuTap}) : super(key: key);
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            child: Icon(Icons.menu, color: Colors.black),
            onTap: widget.onMenuTap,
          ),
          title: Text("Categories"),
        ),
      ),
    );
    // return SingleChildScrollView(
    //   scrollDirection: Axis.vertical,
    //   physics: ClampingScrollPhysics(),
    //   child: Container(
    //     padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           mainAxisSize: MainAxisSize.max,
    //           children: [
    //             InkWell(
    //               child: Icon(Icons.menu, color: Colors.black),
    //               onTap: widget.onMenuTap,
    //             ),
    //             Text("Categories")
    //           ],
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
