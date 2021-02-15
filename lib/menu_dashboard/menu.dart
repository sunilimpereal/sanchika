import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
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
                    child: Text(
                      "Hello ,\n Name",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
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
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.DashboardClickedEvent);
                            widget.onMenuItemClicked();
                          },
                          child: Text(
                            "Home",
                            style: TextStyle(
                                color: widget.selectedIndex == 0
                                    ? Colors.white
                                    : Colors.white70,
                                fontSize: 22,
                                fontWeight: widget.selectedIndex == 0
                                    ? FontWeight.w800
                                    : FontWeight.normal),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.CategoriesClickedEvent);
                            widget.onMenuItemClicked();
                          },
                          child: Text(
                            "Categories",
                            style: TextStyle(
                                color: widget.selectedIndex == 1
                                    ? Colors.white
                                    : Colors.white70,
                                fontSize: 22,
                                fontWeight: widget.selectedIndex == 1
                                    ? FontWeight.w900
                                    : FontWeight.normal),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.CategoriesClickedEvent);
                            widget.onMenuItemClicked();
                          },
                          child: Text(
                            "Offers",
                            style: TextStyle(
                                color: widget.selectedIndex == 2
                                    ? Colors.white
                                    : Colors.white70,
                                fontSize: 22,
                                fontWeight: widget.selectedIndex == 2
                                    ? FontWeight.w900
                                    : FontWeight.normal),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.WishlistClickedEvent);
                            widget.onMenuItemClicked();
                          },
                          child: Text(
                            "Wishlist",
                            style: TextStyle(
                                color: widget.selectedIndex == 2
                                    ? Colors.white
                                    : Colors.white70,
                                fontSize: 22,
                                fontWeight: widget.selectedIndex == 2
                                    ? FontWeight.w900
                                    : FontWeight.normal),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.CartClickedEvent);
                            widget.onMenuItemClicked();
                          },
                          child: Text(
                            "My Cart",
                            style: TextStyle(
                                color: widget.selectedIndex == 3
                                    ? Colors.white
                                    : Colors.white70,
                                fontSize: 22,
                                fontWeight: widget.selectedIndex == 3
                                    ? FontWeight.w900
                                    : FontWeight.normal),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.MyOrdersclickedEvent);
                            widget.onMenuItemClicked();
                          },
                          child: Text(
                            "My Orders",
                            style: TextStyle(
                                color: widget.selectedIndex == 4
                                    ? Colors.white
                                    : Colors.white70,
                                fontSize: 22,
                                fontWeight: widget.selectedIndex == 4
                                    ? FontWeight.w900
                                    : FontWeight.normal),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.ProfileClickedevent);
                            widget.onMenuItemClicked();
                          },
                          child: Text(
                            "Profile",
                            style: TextStyle(
                                fontSize: 22,
                                color: widget.selectedIndex == 5
                                    ? Colors.white
                                    : Colors.white70,
                                fontWeight: widget.selectedIndex == 5
                                    ? FontWeight.w900
                                    : FontWeight.normal),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.SettingsClickedevent);
                            widget.onMenuItemClicked();
                          },
                          child: Text(
                            "Settings",
                            style: TextStyle(
                                color: widget.selectedIndex == 6
                                    ? Colors.white
                                    : Colors.white70,
                                fontSize: 22,
                                fontWeight: widget.selectedIndex == 6
                                    ? FontWeight.w900
                                    : FontWeight.normal),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "etc",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
