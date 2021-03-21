import 'package:flutter/material.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:sanchika/model/getProductDetail_model.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/pages/ui/screens/wishlist.dart';
import 'package:sanchika/services/api_service.dart';
import 'package:sanchika/utils/numericStepButton.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistCard extends StatefulWidget {
  String productId;
  final Function() notifyParent;
  WishlistCard({this.productId, this.notifyParent});
  @override
  _WishlistCardState createState() => _WishlistCardState();
}

class _WishlistCardState extends State<WishlistCard> {
  int qty;
  ButtonState stateTextWithIcon = ButtonState.idle;
  ButtonState stateTextWithIconRemove = ButtonState.idle;
  Future<Product> getProductDetail() async {
    APIService apiService = APIService();
    List<Product> product =
        await apiService.getProductDetail(productId: widget.productId);
    return product[0];
  }

  String userId;
  Future<String> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String uid = preferences.getString('userId');
    setState(() {
      userId = uid;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserId();
    print(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getProductDetail(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _wishlistcardUi(context, snapshot.data);
          } else {
            const spinkit = SpinKitDoubleBounce(
              color: Colors.white,
              size: 50.0,
            );
            return spinkit;
          }
        });
  }

  @override
  Widget _wishlistcardUi(BuildContext context, Product product) {
    return Container(
      padding: EdgeInsets.all(8),
      height: MediaQuery.of(context).size.height * 0.20,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(3.0, 2.0),
            color: Colors.grey[200],
            blurRadius: 3.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.09,
                        width: MediaQuery.of(context).size.width * 0.20,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: NetworkImage(product.productImage)),
                        ),
                      ),
                    ),
                    discount(mrp: double.parse(product.mrpPrice),slp: double.parse(product.slPrice)),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.72,
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.72,
                    padding: EdgeInsets.all(0),
                    color: Colors.white,
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  color: Colors.white,
                                  width: MediaQuery.of(context).size.width *
                                      0.72 *
                                      0.75,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.72 *
                                                  0.75,
                                              child: Text(
                                                product.productName,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // productType(widget.product.type),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(0),
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "₹${product.slPrice}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            price1(double.parse(product.mrpPrice)),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(3.0, 2.0),
                                color: Colors.grey[200],
                                blurRadius: 3.0,
                                spreadRadius: 2.0,
                              ),
                            ],
                          ),
                          child: NumericStepButton(
                            initialValue: 1,
                            maxValue: 20,
                            onChanged: (value) {
                              setState(() {
                                qty = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 130,
                        height: 40,
                        child: ProgressButton.icon(
                          progressIndicatorSize: 24.0,
                          iconedButtons: {
                            ButtonState.idle: IconedButton(
                              text: "Remove",
                              icon: Icon(Icons.cancel,
                                  size: 21, color: Colors.white),
                              color: Colors.redAccent[100],
                            ),
                            ButtonState.loading: IconedButton(
                              text: "Loading",
                              icon: Icon(Icons.blur_circular),
                              color: Colors.redAccent[100],
                            ),
                            ButtonState.fail: IconedButton(
                                text: "Failed",
                                icon: Icon(Icons.cancel, color: Colors.white),
                                color: Colors.red.shade300),
                            ButtonState.success: IconedButton(
                                text: "Removed",
                                icon: Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                ),
                                color: Colors.green.shade400)
                          },
                          onPressed: () {
                            print(product.productId);
                            removeWishlistItem(
                              pid: product.productId,
                              uid: userId,
                            );
                          },
                          state: stateTextWithIconRemove,
                        ),
                      ),
                      SizedBox(width: 6),
                      Container(
                        width: 130,
                        height: 40,
                        child: ProgressButton.icon(
                          progressIndicatorSize: 28.0,
                          iconedButtons: {
                            ButtonState.idle: IconedButton(
                              text: "Add to Cart",
                              icon: Icon(Icons.shopping_cart_outlined,
                                  size: 21, color: Colors.white),
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
                            print(product.productId);
                            addToCart(
                              productId: product.productId,
                              userId: userId,
                              productName: product.productName,
                              quantity: qty,
                              mrpPrice: double.parse(product.mrpPrice),
                              slPrice: double.parse(product.slPrice),
                              grandTotal: double.parse(product.slPrice) * qty,
                            );
                          },
                          state: stateTextWithIcon,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //scrached price
  Text price1(double price1) {
    if (price1 != null) {
      return Text(
        '₹${price1}',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.normal,
          decoration: TextDecoration.lineThrough,
          color: Colors.black,
        ),
      );
    } else {
      return Text('');
    }
  }

  // Container productType(String s) {
  //   String _selectedValue =
  //       widget.product.typeList == null ? '' : widget.product.typeList[0];
  //   if (widget.product.type != null || widget.product.typeList != null) {
  //     return Container(
  //       color: Colors.white,
  //       child: Center(
  //         child: DropdownButton<String>(
  //           value: s == null ? '' : s,
  //           items: widget.product.typeList.map((String value) {
  //             return new DropdownMenuItem(
  //               value: value,
  //               child: new Text(value),
  //             );
  //           }).toList(),
  //           onChanged: (newValue) {
  //             setState(() {
  //               _selectedValue = s;
  //             });
  //           },
  //           dropdownColor: Colors.grey[200],
  //           style: TextStyle(
  //               fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
  //         ),
  //       ),
  //     );
  //   } else {
  //     return Container();
  //   }
  // }


 discount({double mrp,double slp}) {
   int discount =0;
   if(mrp!=slp){
    int discount = (((mrp - slp)/mrp)*100).round();
   }else{
     
   }
    if (discount>0) {
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

  void removeWishlistItem({String uid, String pid}) async {
    print('pid $pid');
    switch (stateTextWithIconRemove) {
      case ButtonState.idle:
        setState(() {
          stateTextWithIconRemove = ButtonState.loading;
        });
        bool removed;
        APIService apiService = new APIService();
        await apiService.removeWishlistitem(uid: uid, pid: pid).then((value) {
          if (value == true) {
            setState(() {
              stateTextWithIconRemove = ButtonState.success;
            });
          } else {
            stateTextWithIconRemove = ButtonState.fail;
          }
        });
        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        break;
      case ButtonState.fail:
        setState(() {
          stateTextWithIconRemove = ButtonState.idle;
        });
    }
    setState(() {
      stateTextWithIconRemove = stateTextWithIconRemove;
    });

    widget.notifyParent();
  }

  void addToCart(
      {String productId,
      String userId,
      int quantity,
      String productName,
      double mrpPrice,
      double slPrice,
      double grandTotal}) async {
    print('productId $productId');
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
