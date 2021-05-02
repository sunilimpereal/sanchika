import 'dart:math';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:sanchika/model/addToCart_model.dart';
import 'package:sanchika/model/cart_model.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/model/wishlist_model.dart';
import 'package:sanchika/pages/ui/widget/product_view.dart';
import 'package:sanchika/pages/ui/widget/stepper.dart';
import 'package:sanchika/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

class ProductCard extends StatefulWidget {
  List<WishlistItem> wishlist;
  List<CartItem> cartItems;
  Product product;
  Function reload;

  final translator = GoogleTranslator();
  Function onMenuItemClicked;
  ProductCard(
      {this.product,
      this.wishlist,
      this.cartItems,
      this.reload,
      this.onMenuItemClicked});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  String _selectedValue;
  AddtocartRequest addtocartRequest;

  // tratlate function to malylam and retun the product item
  Future<Product> translate(Product product) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.getString('language') == 'malayalam') {
      Product productmal = new Product();
      productmal = widget.product;
      final translator = GoogleTranslator();
      translator.translate(widget.product.pdmPdtNm, to: 'ml').then((result) {
        productmal.pdmPdtNm = result.text;
        translator
            .translate(widget.product.pdmPdtDscr, to: 'ml')
            .then((result) {
          productmal.pdmPdtDscr = result.text;
          translator
              .translate(widget.product.pdmPdtDscr, to: 'ml')
              .then((result) {
            productmal.pdmPdtDscr = result.text;
            setState(() {});
          });
        });
      });

      return productmal;
    }
    return product;
  }

  // //A
  //Animation for button
  bool incart = false;
  String userId;
  Future<String> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String uid = preferences.getString('userId');
    setState(() {
      userId = uid;
    });
  }

  void checkCart() {
    for (CartItem c in widget.cartItems ?? []) {
      if (c.productId == widget.product.pdmPdtId) {
        setState(() {
          incart = true;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getUserId();
    print(widget.product.pdmPdtId);
    checkCart();
  }

  //dispose for animation
  @override
  void dispose() {
    super.dispose();
  }

  ButtonState stateTextWithIcon = ButtonState.idle;

  @override
  Widget build(BuildContext context) {
    bool isInWishlist = false;
    return FutureBuilder(
      future: translate(widget.product),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          for (WishlistItem item in widget.wishlist ?? []) {
            print('checking');
            if (item.productId == snapshot.data.pdmPdtId) {
              print('present');
              return _cardUi(
                  context: context, product: snapshot.data, inwishlist: true);
            }
          }
          return _cardUi(
              context: context,
              product: snapshot.data,
              inwishlist: isInWishlist);
        } else {
          return Container();
        }
      },
    );
  }

  @override
  Widget _cardUi({BuildContext context, Product product, bool inwishlist}) {
    return Material(
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductView(
                            inWishlist: inwishlist,
                            product: product,
                            userId: userId,
                            cartItems: widget.cartItems,
                            onMenuItemClicked: widget.onMenuItemClicked,
                          )),
                );
              },
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 2,
                      shadowColor: Colors.grey[100],
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 0),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          padding: EdgeInsets.all(.0),
                          height: MediaQuery.of(context).size.height * .32,
                          width: MediaQuery.of(context).size.width * 0.43,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6.0, vertical: 6.0),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Hero(
                                    tag: 'image' + product.pdmPdtId,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .28 *
                                              0.6,
                                      width: MediaQuery.of(context).size.width *
                                              0.45 -
                                          5,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0.0, right: 0.0, bottom: 0.0),
                                        child: Stack(children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      widget.product.pdmIm1),
                                                  fit: BoxFit.contain),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.maxFinite,
                                          child: Text(
                                            product.pdmPdtNm,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '₹${product.slPrc ?? '0'}',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                // price1(double.parse(
                                                //         widget.product?.mrpPr ??
                                                //             "10") ??
                                                //     0),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //Stepper buttom
                  button(),
                  discount(
                      mrp: double.parse(product?.mrpPr ?? '0') ?? 0,
                      slp: double.parse(product?.slPrc ?? "0") ?? 0),
                  Positioned(
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: FavoriteButton(
                        isFavorite: inwishlist,
                        iconSize: 28,
                        valueChanged: (value) {
                          if (!inwishlist) {
                            AddWishlistRequest addWishlistRequest =
                                AddWishlistRequest();
                            addWishlistRequest.userId = int.parse(userId);
                            addWishlistRequest.productId = product.pdmPdtId;
                            APIService apiService = new APIService();
                            apiService
                                .addToWishlist(addWishlistRequest)
                                .then((value) {
                              if (value == true) {
                                widget.reload;
                                setState(() {
                                  inwishlist = true;
                                });
                              }
                            });
                          } else {}
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),

            //button
          ],
        ),
      ),
    );
  }

  Text price1(double price1) {
    if (price1 != null) {
      return Text(
        '₹${price1}',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.normal,
          decoration: TextDecoration.lineThrough,
        ),
      );
    } else {
      return Text('');
    }
  }

  Widget button() {
    if (incart) {
      return Positioned(
        bottom: 0,
        left: 8,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              color: Colors.transparent,
              height: 40,
              width: MediaQuery.of(context).size.width * 0.43,
              child: StepperTouch(
                initialValue: 1,
                direction: Axis.horizontal,
                withSpring: true,
                onChanged: (int value) {},
              )),
        ),
      );
    } else {
      return Positioned(
        bottom: 0,
        left: 15,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.40,
            height: 40,
            child: ProgressButton.icon(
              progressIndicatorSize: 28.0,
              iconedButtons: {
                ButtonState.idle: IconedButton(
                  text: "Add to Cart",
                  icon: Icon(Icons.shopping_cart_outlined,
                      size: 23, color: Colors.white),
                  color: Color(0xff032e6b),
                ),
                ButtonState.loading: IconedButton(
                  text: "Loading",
                  icon: Icon(Icons.blur_circular),
                  color: Color(0xff032e6b),
                ),
                ButtonState.fail: IconedButton(
                    text: "Failed",
                    icon: Icon(Icons.cancel, color: Colors.white),
                    color: Colors.red.shade300),
                ButtonState.success: IconedButton(
                    text: "Added",
                    icon: Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                    color: Colors.green.shade400)
              },
              onPressed: () {
                print(widget.product.pdmPdtId);
                print(widget.product.mrpPr);
                print(widget.product.slPrc);
                addToCart(
                    productId: widget.product.pdmPdtId,
                    userId: userId,
                    mrpPrice: double.parse(widget.product.mrpPr ?? '0'),
                    slPrice: double.parse(widget.product.slPrc ?? '0'),
                    productName: widget.product.pdmPdtNm,
                    quantity: 1,
                    grandTotal: double.parse(widget.product.slPrc ?? '0'));
              },
              state: stateTextWithIcon,
            ),
          ),
        ),
      );
    }
  }

  discount({double mrp, double slp}) {
    int discount = 0;
    if (mrp != slp) {
      if (mrp != 0) {
        discount = (((mrp - slp) / mrp) * 100).round();
      }
    } else {}
    if (discount > 0) {
      return Positioned(
        top: 5,
        left: 7,
        child: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(5),
                topLeft: Radius.circular(15),
                bottomRight: Radius.circular(10)),
            color: Colors.red,
          ),
          child: Text(
            '$discount% Off',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  void addToCart(
      {String productId,
      String userId,
      int quantity,
      String productName,
      double mrpPrice,
      double slPrice,
      double grandTotal}) async {
    print('userId $userId');
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        setState(() {
          stateTextWithIcon = ButtonState.loading;
        });

        bool added;
        APIService apiService = APIService();

        await apiService
            .addItemToCart(
                productId: productId,
                productName: productName,
                price: mrpPrice,
                slPrice: slPrice,
                userId: userId,
                grandTotal: grandTotal,
                quantity: quantity)
            .then((value) {
          if (value == true) {
            setState(() {
              stateTextWithIcon = ButtonState.success;
            });
            setState(() {
              incart = true;
            });
          }
          if (value == false) {
            setState(() {
              stateTextWithIcon = ButtonState.fail;
            });
          }
        });
        if (added) {
          setState(() {
            stateTextWithIcon = ButtonState.success;
            print('added $added');
          });
        }

        // Future.delayed(Duration(seconds: 1), () {
        //   setState(() {
        //     stateTextWithIcon = Random.secure().nextBool()
        //         ? ButtonState.success
        //         : ButtonState.fail;
        //   });
        // });

        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        break;
      case ButtonState.fail:
        stateTextWithIcon = ButtonState.idle;
        break;
    }
    setState(() {
      stateTextWithIcon = stateTextWithIcon;
    });
  }
}
