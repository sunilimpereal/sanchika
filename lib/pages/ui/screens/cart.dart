import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/pages/ui/widget/cart_card.dart';
import 'package:sanchika/pages/ui/widget/checkout.dart';

class Cart extends StatefulWidget with NavigationStates {
  final Function onMenuTap;
  final Function onMenuItemClicked;

  const Cart({Key key, this.onMenuTap, this.onMenuItemClicked})
      : super(key: key);
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: leading(),
        elevation: 0,
        title: Column(
          children: [
            Text(
              "Your Cart",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins'),
            ),
            SizedBox(height: 4),
            Text(
              "4 items",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w300,
                fontSize: 12,
              ),
            )
          ],
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.only(top: 8),
            icon: Icon(
              Icons.favorite_rounded,
              color: Colors.grey[500],
              size: 24,
            ),
            onPressed: () {
              BlocProvider.of<NavigationBloc>(context)
                  .add(NavigationEvents.WishlistClickedEvent);
              widget.onMenuItemClicked();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // CartCard(
          //   product: product0,
          // ),
          // CartCard(
          //   product: product1,
          // ),
          // CartCard(
          //   product: product2,
          // ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(3.0, 2.0),
              color: Colors.grey[400],
              blurRadius: 3.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        height: 55,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4.0, bottom: 3, top: 3),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.35,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    "₹390",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckoutPage()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 0.0, bottom: 3, top: 3),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.55,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff0b3666),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(3.0, 2.0),
                        color: Colors.grey[200],
                        blurRadius: 3.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white70,
                          ),
                        ),
                        Text(
                          'Checkout',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
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
