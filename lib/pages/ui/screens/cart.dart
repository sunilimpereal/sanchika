import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rive/rive.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';
import 'package:sanchika/localization/localization_methods.dart';
import 'package:sanchika/model/cart_model.dart';
import 'package:sanchika/pages/ui/screens/orders/checkout.dart';
import 'package:sanchika/pages/ui/widget/cart_card.dart';
import 'package:sanchika/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

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
  double cartTotal = 0;
  String userId;
  Future<String> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String uid = preferences.getString('userId');
    setState(() {
      userId = uid;
    });
    return uid;
  }

  Future<List<CartItem>> getCartTotal(String userId) async {
    APIService apiService = new APIService();
    List<CartItem> cartitems = await apiService.getCartItems(userId);
    double total = 0;
    for (CartItem c in cartitems) {
      double it = double.parse(c.totalAmount);
      total = total + it;
    }
    setState(() {
      cartTotal = total;
    });

    return cartitems;
  }

  Artboard _riveArtboard;
  RiveAnimationController _controller;
  reload() {
    getCartTotal(userId);
    setState(() {
      userId = userId;
    });
  }

  APIService apiService = APIService();

  @override
  void initState() {
    apiService = APIService();
    getUserId().then((value) {
      getCartTotal(value);
    });
    super.initState();
    rootBundle.load('assets/rive/emptycart.riv').then((value) async {
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
    Future<List<CartItem>> getCart(String userId) async {
      APIService apiService = new APIService();
      List<CartItem> cartitems = await apiService.getCartItems(userId);
      return cartitems;
    }

    return Scaffold(
        backgroundColor: Colors.white,
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
                      future: getCart(userId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<CartItem> cartitems = snapshot.data;

                          String number = snapshot.data.length.toString();
                          return Text(
                            number == '1' ? "$number item" : "$number items ",
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
                    widget.onMenuItemClicked();
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
            IconButton(
                padding: EdgeInsets.only(bottom:10),
                icon: Icon(
                  Icons.remove_shopping_cart,
                  color: Color(0xff032e6b),
                       size: 24,
                ),
                onPressed: () {
                  apiService.clearCartItem(userId: userId).then((value) {
                    if(value!=null){
                      setState(() {
                        
                      });
                    }
                  });
                })
          ],
        ),
        body: FutureBuilder(
          future: getCart(userId),
          builder: (context, snapshot) {
            List<CartItem> cartitems = snapshot.data;

            if (snapshot.hasData) {
              if (snapshot.data.length != 0) {
                return ListView.builder(
                    cacheExtent: 100000,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      CartItem cartItem = snapshot.data[index];
                      return CartCard(
                        userId: userId,
                        productId: cartItem.productId,
                        qty: cartItem.quantity,
                        notifyParent: reload,
                      );
                    });
              } else {
                return Center(
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 30.0, right: 30),
                          child: Container(
                              height: 250,
                              child: _riveArtboard == null
                                  ? const SizedBox()
                                  : Rive(
                                      artboard: _riveArtboard,
                                      fit: BoxFit.contain,
                                    )),
                        ),
                        Text(
                          'No Items In Cart',
                          style: TextStyle(
                              color: Colors.blue.shade400,
                              fontSize: 27,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              }
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.158 + 15,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Shimmer.fromColors(
                          baseColor: Colors.grey[300],
                          highlightColor: Colors.white,
                          period: Duration(milliseconds: 1000),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.26,
                          ))
                    ],
                  ),
                ),
              );
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FutureBuilder(
            future: getCart(userId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<CartItem> cartitems = snapshot.data;
                if (cartitems.length > 0) {
                  return Container(
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
                          padding: const EdgeInsets.only(
                              left: 4.0, bottom: 3, top: 3),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                "₹$cartTotal",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        FutureBuilder(
                          future: getCart(userId),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Checkoutpage(
                                              cartItems: snapshot.data,
                                            )),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0.0, bottom: 3, top: 3),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.55,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              } else {
                return Container();
              }
            }));
  }

  Widget cartTot(String userId) {
    Future<List<CartItem>> getCart(String userId) async {
      APIService apiService = new APIService();
      List<CartItem> cartitems = await apiService.getCartItems(userId);
      return cartitems;
    }

    return FutureBuilder(
      future: getCart(userId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<CartItem> cartitems = snapshot.data;
          cartitems.map((e) {
            setState(() {
              cartTotal = cartTotal + double.parse(e.totalAmount);
            });
          });
          String number = snapshot.data.length.toString();
          return Padding(
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
                  "₹${cartTotal}",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  InkWell leading() {
    if (widget.onMenuTap == null) {
      return InkWell(
        child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
        onTap: () {
          Navigator.pop(context, true);
        },
      );
    }
    return InkWell(
      child: Icon(Icons.menu, color: Colors.black),
      onTap: widget.onMenuTap,
    );
  }
}
