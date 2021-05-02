import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';
import 'package:sanchika/localization/localization_methods.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatefulWidget {
  final Animation<Offset> slideAnimation;
  final Animation<double> menuAnimation;
  final int selectedIndex;
  final Function onMenuItemClicked;

  const Menu(
      {Key key,
      this.slideAnimation,
      this.menuAnimation,
      this.selectedIndex,
      this.onMenuItemClicked})
      : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  String name = '';
  void getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String getname = preferences.getString('name');
    setState(() {
      if (getName != null) {
        name = getname;
      } else {
        name = '';
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          child: Container(
        color: Color(0xff005fb8),
        child: SlideTransition(
          position: widget.slideAnimation,
          child: ScaleTransition(
            scale: widget.menuAnimation,
            child: Container(
              child: Column(
                children: [
                  Align(
                    child: SizedBox(
                      height: 80,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                getTranslated(context, 'Hello,'),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                name??'',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            menuItem(
                              context: context,
                              navigationEvents:
                                  NavigationEvents.DashboardClickedEvent,
                              title: getTranslated(context, 'Home'),
                              icon: Icons.home,
                              selectednumber: 0,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            menuItem(
                              context: context,
                              navigationEvents:
                                  NavigationEvents.CategoriesClickedEvent,
                              title: getTranslated(context, 'Categories'),
                              icon: Icons.category,
                              selectednumber: 1,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            menuItem(
                              context: context,
                              navigationEvents:
                                  NavigationEvents.Offersclickedevent,
                              title: getTranslated(context, 'Offers'),
                              icon: Icons.local_offer,
                              selectednumber: 2,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            menuItem(
                              context: context,
                              navigationEvents:
                                  NavigationEvents.WishlistClickedEvent,
                              title: getTranslated(context, 'Wishlist'),
                              icon: Icons.favorite_rounded,
                              selectednumber: 3,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            menuItem(
                              context: context,
                              navigationEvents: NavigationEvents.CartClickedEvent,
                              title: getTranslated(context, 'My_Cart'),
                              icon: Icons.shopping_cart_rounded,
                              selectednumber: 4,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            menuItem(
                              context: context,
                              navigationEvents:
                                  NavigationEvents.MyOrdersclickedEvent,
                              title: getTranslated(context, 'Orders'),
                              icon: Icons.shopping_bag,
                              selectednumber: 5,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            menuItem(
                              context: context,
                              navigationEvents:
                                  NavigationEvents.ProfileClickedevent,
                              title: getTranslated(context, 'Profile'),
                              icon: Icons.person,
                              selectednumber: 6,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            menuItem(
                              context: context,
                              navigationEvents:
                                  NavigationEvents.HelpSupportClicked,
                              title: getTranslated(context, 'Help_Support'),
                              icon: Icons.help_center,
                              selectednumber: 7,
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector menuItem({
    final BuildContext context,
    final NavigationEvents navigationEvents,
    final String title,
    final IconData icon,
    final int selectednumber,
  }) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<NavigationBloc>(context).add(navigationEvents);
        widget.onMenuItemClicked();
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              icon,
              color: widget.selectedIndex == selectednumber
                  ? Colors.white
                  : Colors.white70,
              size: 20,
            ),
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 18,
                color: widget.selectedIndex == selectednumber
                    ? Colors.white
                    : Colors.white70,
                fontWeight: widget.selectedIndex == selectednumber
                    ? FontWeight.w700
                    : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
