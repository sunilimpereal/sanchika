import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';

class Profile extends StatefulWidget with NavigationStates {
  final Function onMenuTap;
  final Function onMenuItemClicked;

  const Profile({Key key, this.onMenuTap, this.onMenuItemClicked})
      : super(key: key);
  @override
  PprofileState createState() => PprofileState();
}

class PprofileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.only(top: 0),
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
          Stack(
            children: [
              IconButton(
                padding: EdgeInsets.only(top: 8),
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.grey[800],
                  size: 24,
                ),
                onPressed: () {
                  BlocProvider.of<NavigationBloc>(context)
                      .add(NavigationEvents.CartClickedEvent);
                  widget.onMenuItemClicked();
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 25),
                child: Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red,
                  ),
                  child: Center(
                    child: Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: InkWell(
            child: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onTap: widget.onMenuTap,
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Color(0xff0B3666).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(3.0, 2.0),
                        color: Colors.blue[100],
                        blurRadius: 2.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                  child: Container(
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: 200,
                                    child: Row(
                                      children: [
                                        Text(
                                          'Name',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Container(
                                    width: 200,
                                    child: Row(
                                      children: [
                                        Text(
                                          'email@gmail.com',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 89,
                                width: 89,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(350),
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/user.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Container(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(3.0, 2.0),
                      color: Colors.grey[100],
                      blurRadius: 2.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: ListTile(
                  tileColor: Colors.white,
                  leading: Icon(Icons.pin_drop),
                  title: Text('Address'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  subtitle: Text('3057 Creek Road,Madison,TN'),
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(3.0, 2.0),
                      color: Colors.grey[300],
                      blurRadius: 2.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: ListTile(
                  tileColor: Colors.white,
                  leading: Icon(Icons.history),
                  title: Text('My Orders'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(3.0, 2.0),
                      color: Colors.grey[300],
                      blurRadius: 2.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: ListTile(
                  tileColor: Colors.white,
                  leading: Icon(Icons.call),
                  title: Text('customer Support'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(3.0, 2.0),
                      color: Colors.grey[300],
                      blurRadius: 2.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: ListTile(
                  tileColor: Colors.white,
                  leading: Icon(Icons.notifications),
                  title: Text('Notifaction'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(3.0, 2.0),
                      color: Colors.grey[300],
                      blurRadius: 2.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: ListTile(
                  tileColor: Colors.white,
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
