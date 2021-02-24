import 'package:flutter/cupertino.dart';
import 'package:sanchika/pages/ui/screens/cart.dart';
import 'package:sanchika/pages/ui/screens/categories.dart';
import 'package:sanchika/pages/ui/screens/home.dart';
import 'package:bloc/bloc.dart';
import 'package:sanchika/pages/ui/screens/myOrders.dart';
import 'package:sanchika/pages/ui/screens/offers.dart';
import 'package:sanchika/pages/ui/screens/profile.dart';
import 'package:sanchika/pages/ui/screens/settings.dart';
import 'package:sanchika/pages/ui/screens/wishlist.dart';

enum NavigationEvents {
  DashboardClickedEvent,
  CategoriesClickedEvent,
  WishlistClickedEvent,
  CartClickedEvent,
  MyOrdersclickedEvent,
  SettingsClickedevent,
  ProfileClickedevent,
  Offersclickedevent,
  Productview
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  final Function onMenuTap;
  final Function onMenuItemClicked;

  NavigationBloc({this.onMenuItemClicked, this.onMenuTap});
  @override
  NavigationStates get initialState => Home(onMenuTap: onMenuTap);
  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.DashboardClickedEvent:
        yield Home(
          onMenuTap: onMenuTap,
          onMenuItemClicked: onMenuItemClicked,
        );
        break;
      case NavigationEvents.CategoriesClickedEvent:
        yield Categories(
          onMenuTap: onMenuTap,
        );
        break;
      case NavigationEvents.WishlistClickedEvent:
        yield Wishlist(
          onMenuTap: onMenuTap,
        );
        break;

      case NavigationEvents.CartClickedEvent:
        yield Cart(
          onMenuTap: onMenuTap,
        );
        break;
      case NavigationEvents.MyOrdersclickedEvent:
        yield MyOrders(
          onMenuTap: onMenuTap,
        );
        break;
      case NavigationEvents.ProfileClickedevent:
        yield Profile(
          onMenuTap: onMenuTap,
        );
        break;
      case NavigationEvents.SettingsClickedevent:
        yield Settings(
          onMenuTap: onMenuTap,
        );
        break;
      case NavigationEvents.Offersclickedevent:
        yield Offers(
          onMenuTap: onMenuTap,
        );
        break;
    }
  }
}
