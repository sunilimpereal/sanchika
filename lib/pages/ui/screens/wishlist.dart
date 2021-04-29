import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';
import 'package:sanchika/localization/localization_methods.dart';
import 'package:sanchika/model/cart_model.dart';
import 'package:sanchika/model/wishlist_model.dart';
import 'package:sanchika/pages/ui/widget/wishlist_card.dart';
import 'package:sanchika/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rive/rive.dart';
import 'package:flutter/services.dart';

class Wishlist extends StatefulWidget with NavigationStates {
  const Wishlist({Key key, this.onMenuTap, this.onMenuItemClicked})
      : super(key: key);

  final Function onMenuItemClicked;
  final Function onMenuTap;

  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  String userId;
  APIService apiService;
  Future<String> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String uid = preferences.getString('userId');
    setState(() {
      userId = uid;
    });
    return uid;
  }

  List<CartItem> cartItems;
  Future<List<CartItem>> getCart(String userId) async {
    APIService apiService = new APIService();
    List<CartItem> cartitems = await apiService.getCartItems(userId);
    setState(() {
      cartItems = cartitems;
    });
    return cartitems;
  }

  Artboard _riveArtboard;
  RiveAnimationController _controller;

  @override
  void initState() {
    super.initState();
    getUserId().then((value) {
        getCart(value);
    });
    apiService = APIService();
    print(userId);
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
  void dispose() {
    super.dispose();
  }

  reload() {
    setState(() {
      userId = userId;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<List<WishlistItem>> getWishlist(String userId) async {
      APIService apiService = new APIService();
      List<WishlistItem> allWishlistItems =
          await apiService.getWishList(userId: userId);
      print(allWishlistItems);
      return allWishlistItems;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: GestureDetector(
          onTap: () {
            setState(() {});
          },
          child: Text(
            getTranslated(context, "Wishlist"),
            style: TextStyle(color: Colors.black),
          ),
        ),
        leading: leading(),
        actions: [
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
                  widget.onMenuItemClicked();
                },
              ),
              FutureBuilder(
                  future: apiService.cartlength(uid: userId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
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
                  }),
            ],
          ),
        ],
      ),
      body: Container(
          child: FutureBuilder(
        future: getWishlist(userId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length != 0) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  WishlistItem item = snapshot.data[index];
                  return
                  
                  WishlistCard(
                    productId: item.productId,
                    cartItems: cartItems,
                    notifyParent: reload,
                  );
                  //  Column(
                  //   children: [
                  //     Text(item.productId),
                  //     Text("${item.userId}"),
                  //     Text(''),
                  //   ],
                  // );
                },
              );
            } else {
              return Center(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0.0),
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
                        'No Items In Wishlist',
                        style: TextStyle(
                          color: Colors.blue.shade400,
                          fontSize: 27,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Explore More'),
                      )
                    ],
                  ),
                ),
              );
            }
          } else {
            const spinkit = SpinKitDoubleBounce(
              color: Color(0xff032e6b),
              size: 50.0,
            );
            return Center(child: spinkit);
          }
        },
      )),
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
