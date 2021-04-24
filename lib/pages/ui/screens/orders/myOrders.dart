import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';
import 'package:sanchika/localization/localization_methods.dart';
import 'package:sanchika/model/myOrders.dart';
import 'package:sanchika/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyOrders extends StatefulWidget with NavigationStates {
  final Function onMenuTap;
  final Function onMenuItemClicked;

  const MyOrders({Key key, this.onMenuTap, this.onMenuItemClicked})
      : super(key: key);
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  List<OrderSummary> myOrders = [];
  Future<List<OrderSummary>> getOrders(String userId) async {
    APIService apiService = new APIService();
    List<OrderSummary> orders = await apiService.getMyOrders(userId: userId);

    return orders;
  }

  String userId;
  Future<String> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String uid = preferences.getString('userId');
    setState(() {
      userId = uid;
    });
  }

  APIService apiService = APIService();

  @override
  void initState() {
    getUserId().then((value) {
      print(userId);
      getOrders(userId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            getTranslated(context, "Orders"),
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            Stack(
              children: [
                IconButton(
                  padding: EdgeInsets.only(top: 0),
                  icon: Icon(
                    Icons.favorite_rounded,
                    color: Color(0xff032e6b).withAlpha(180),
                    size: 24,
                  ),
                  onPressed: () {
                    BlocProvider.of<NavigationBloc>(context)
                        .add(NavigationEvents.WishlistClickedEvent);
                    // widget.onMenuItemClicked();
                  },
                ),
                FutureBuilder(
                    future: apiService.countWishlist(userId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (int.parse(snapshot.data) > 0) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 25),
                            child: Container(
                              height: 18,
                              width: 18,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xff032e6b),
                              ),
                              child: Center(
                                child: Text(
                                  snapshot.data,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      } else {
                        return SizedBox();
                      }
                    }),
              ],
            ),
            Stack(
              children: [
                IconButton(
                  padding: EdgeInsets.only(top: 8),
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Color(0xff032e6b).withAlpha(180),
                    size: 24,
                  ),
                  onPressed: () {
                    BlocProvider.of<NavigationBloc>(context)
                        .add(NavigationEvents.CartClickedEvent);
                    // widget.onMenuItemClicked();
                  },
                ),
                FutureBuilder(
                    future: apiService.cartlength(uid: userId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (int.parse(snapshot.data) > 0) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 25),
                            child: Container(
                              height: 18,
                              width: 18,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xff032e6b),
                              ),
                              child: Center(
                                child: Text(
                                  snapshot.data,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      } else {
                        return SizedBox();
                      }
                    }),
              ],
            ),
          ],
          leading: leading(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
              future: getOrders(userId),
              builder: (context, snapshot) {
                List<OrderSummary> orders = snapshot.data;
                print(orders);
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        return myordertile(orderSummary: orders[index]);
                      });
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ));
  }

  ListTile myordertile({OrderSummary orderSummary}) {
    return ListTile(
      title: Text(
        orderSummary.orderId ?? "",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(orderSummary.orderDate),
      leading: Image(
        image: AssetImage('assets/images/order.png'),
      ),
      trailing: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              orderSummary.orderStatus,
              style: TextStyle(
                color: orderSummary.orderStatus == 'delivered'
                    ? Colors.green
                    : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(Icons.keyboard_arrow_right_rounded),
          ],
        ),
      ),
    );
  }

  InkWell leading() {
    if (widget.onMenuTap == null) {
      return InkWell(
        child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
        onTap: () {
          Navigator.pop(context);
        },
      );
    }
    return InkWell(
      child: Icon(Icons.menu, color: Colors.black),
      onTap: widget.onMenuTap,
    );
  }
}
