import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';
import 'package:sanchika/pages/ui/widget/home_crousal.dart';

class Offers extends StatefulWidget with NavigationStates {
  final Function onMenuTap;
  final Function onMenuItemClicked;

  const Offers({Key key, this.onMenuTap, this.onMenuItemClicked})
      : super(key: key);
  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          child: Icon(Icons.menu, color: Colors.black),
          onTap: widget.onMenuTap,
        ),
        title: Text(
          "Offers",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.only(top: 8),
            icon: Icon(
              Icons.favorite_rounded,
              color: Colors.grey[800],
              size: 24,
            ),
            onPressed: () {
              BlocProvider.of<NavigationBloc>(context)
                  .add(NavigationEvents.WishlistClickedEvent);
              widget.onMenuItemClicked();
            },
          ),
          IconButton(
            padding: EdgeInsets.only(top: 8),
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.grey[800],
              size: 26,
            ),
            onPressed: () {
              BlocProvider.of<NavigationBloc>(context)
                  .add(NavigationEvents.CartClickedEvent);
              widget.onMenuItemClicked();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ExpansionTile(
                title: Text(
                  "Sanchika Kitchen",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: Row(
                      children: [
                        Text(
                          "Daily Deals",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: Row(
                      children: [
                        Text(
                          "Top Promotions",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: Row(
                      children: [
                        Text(
                          "New Arrivals",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: Row(
                      children: [
                        Text(
                          "Frozen Foods",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              ExpansionTile(
                title: Text(
                  "Offers",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: Row(
                      children: [
                        Text(
                          "Daily Deals",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: Row(
                      children: [
                        Text(
                          "Top Promotions",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: Row(
                      children: [
                        Text(
                          "New Arrivals",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: Row(
                      children: [
                        Text(
                          "Frozen Foods",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              HomeCrousal(),
            ],
          ),
        ),
      ),
    );
  }
}
