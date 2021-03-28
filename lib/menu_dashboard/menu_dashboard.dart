import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';
import 'package:sanchika/menu_dashboard/dashboard.dart';
import 'package:sanchika/menu_dashboard/menu.dart';
import 'package:sanchika/pages/ui/screens/cart.dart';
import 'package:sanchika/pages/ui/screens/categories/categories.dart';
import 'package:sanchika/pages/ui/screens/help_support.dart';
import 'package:sanchika/pages/ui/screens/home/home.dart';
import 'package:sanchika/pages/ui/screens/orders/myOrders.dart';
import 'package:sanchika/pages/ui/screens/offers.dart';
import 'package:sanchika/pages/ui/screens/profile.dart';
import 'package:sanchika/pages/ui/screens/wishlist.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:sanchika/utils/constants.dart';


class MenuDashboard extends StatefulWidget {
  @override
  _MenuDashboardState createState() => _MenuDashboardState();
}

class _MenuDashboardState extends State<MenuDashboard>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onMenuTap() {
    setState(() {
      if (isCollapsed) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
      isCollapsed = !isCollapsed;
    });
  }

  void onMenuItemClicked() {
    setState(() {
      _controller.reverse();
    });
    isCollapsed = !isCollapsed;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: DoubleBackToCloseApp(
         snackBar: const SnackBar(
            content: Text('Tap back again to leave'),
          ),
              child: BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(
              onMenuTap: onMenuTap, onMenuItemClicked: onMenuItemClicked),
          child: Stack(
            children: [
              BlocBuilder<NavigationBloc, NavigationStates>(
                builder: (context, NavigationStates navigationState) {
                  return Menu(
                      slideAnimation: _slideAnimation,
                      menuAnimation: _menuScaleAnimation,
                      selectedIndex: findSelectedIndex(navigationState),
                      onMenuItemClicked: onMenuItemClicked);
                },
              ),
              Dashboard(
                duration: duration,
                onMenuTap: onMenuTap,
                scaleAnimation: _scaleAnimation,
                isCollapsed: isCollapsed,
                screenWidth: screenWidth,
                onMenuItemClicked: onMenuItemClicked,
                child: BlocBuilder<NavigationBloc, NavigationStates>(builder: (
                  context,
                  NavigationStates navigationState,
                ) {
                  return navigationState as Widget;
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int findSelectedIndex(NavigationStates navigationState) {
    if (navigationState is Home) {
      return 0;
    } else if (navigationState is Categories) {
      return 1;
    } else if (navigationState is Offers) {
      return 2;
    } else if (navigationState is Wishlist) {
      return 3;
    } else if (navigationState is Cart) {
      return 4;
    } else if (navigationState is MyOrders) {
      return 5;
    } else if (navigationState is Profile) {
      return 6;
    } else if (navigationState is HelpSupportPage) {
      return 7;
    } else {
      return 0;
    }
  }
}
