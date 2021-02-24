import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';

class MyOrders extends StatefulWidget with NavigationStates {
  final Function onMenuTap;
  final Function onMenuItemClicked;

  const MyOrders({Key key, this.onMenuTap, this.onMenuItemClicked})
      : super(key: key);
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "My Orders",
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // expansionTile(),
              myordertile(
                  orderid: 'ORD1121', date: 'Jun 15,2020', status: 'Delivered'),
              myordertile(
                  orderid: 'ORD1121', date: 'Jun 15,2020', status: 'Pending')
            ],
          ),
        ),
      ),
    );
  }

  ListTile myordertile({String orderid, String date, String status}) {
    return ListTile(
      title: Text(
        orderid,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(date),
      leading: Image(
        image: AssetImage('assets/images/order.png'),
      ),
      trailing: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              status,
              style: TextStyle(
                color: status == 'Delivered' ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(Icons.keyboard_arrow_right_rounded),
          ],
        ),
      ),
    );
  }

  ExpansionTile expansionTile() {
    return ExpansionTile(
      title: Row(
        children: [
          Column(
            children: [
              Text(
                "Order (12/2/20)",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "20 items            ",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '₹2000',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Pending",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
