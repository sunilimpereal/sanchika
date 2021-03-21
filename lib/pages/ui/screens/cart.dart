import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rive/rive.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';
import 'package:sanchika/localization/localization_methods.dart';
import 'package:sanchika/model/cart_model.dart';
import 'package:sanchika/pages/ui/widget/cart_card.dart';
import 'package:sanchika/pages/ui/widget/checkout.dart';
import 'package:sanchika/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatefulWidget with NavigationStates {
  final Function onMenuTap;
  final Function onMenuItemClicked;

  const Cart({Key key, this.onMenuTap, this.onMenuItemClicked})
      : super(key: key);
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  Future<List<CartItem>> cartItems;
  double cartTotal;

  Future<List<CartItem>> getCart() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.getString('userId');
    APIService apiService = new APIService();
    List<CartItem> cartitems = await apiService.getCartItems(userId);

    return cartitems;
  }

  Artboard _riveArtboard;
  RiveAnimationController _controller;
  @override
  void initState() {
    super.initState();
    cartItems = getCart();
    rootBundle.load('assets/rive/wishlist.riv').then((value) async {
      final file = RiveFile();
      if (file.import(value)) {
        final artboard = file.mainArtboard;
        artboard.addController(_controller = SimpleAnimation('Animation 1'));
        setState(() {
          _riveArtboard = artboard;
          _controller.isActive = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: leading(),
        elevation: 0,
        title: GestureDetector(
          onTap: () {},
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    getTranslated(context, "My_Cart"),
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins'),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  FutureBuilder(
                    future: getCart(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<CartItem> cartitems = snapshot.data;
                        cartitems.map((e) {
                          setState(() {
                            cartTotal = cartTotal+double.parse(e.totalAmount);
                          });
                        });
                        String number = snapshot.data.length.toString();
                        return Text(
                          "$number items",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
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
      body: FutureBuilder(
        future: getCart(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  CartItem cartItem = snapshot.data[index];
                  return CartCard(productId: cartItem.productId,qty:cartItem.quantity,);
                });
          } else {
            const spinkit = SpinKitDoubleBounce(
              color: Color(0xff032e6b),
              size: 50.0,
            );
            return Center(child: spinkit);
          }
        },
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
                    "₹${cartTotal??0}",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            FutureBuilder(
                future: cartItems,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckoutPage(
                                    cartItem: snapshot.data[0],
                                  )),
                        );
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 0.0, bottom: 3, top: 3),
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
                    );
                  }
                })
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
