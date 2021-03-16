import 'dart:math';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/model/wishlist_model.dart';
import 'package:sanchika/pages/ui/widget/product_view.dart';
import 'package:sanchika/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

class ProductCard extends StatefulWidget {
  List<WishlistItem> wishlist;
  Product product;
  final translator = GoogleTranslator();
  Function onMenuItemClicked;
  ProductCard({this.product,this.wishlist, this.onMenuItemClicked});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  String _selectedValue;
 
  // tratlate function to malylam and retun the product item
  Future<Product> translate(Product product) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.getString('language') == 'malayalam') {
      Product productmal = widget.product;
      final translator = GoogleTranslator();
      translator.translate(widget.product.productName, to: 'ml').then((result) {
        productmal.productName = result.text;
        translator
            .translate(widget.product.productDescription, to: 'ml')
            .then((result) {
          productmal.productDescription = result.text;
          translator
              .translate(widget.product.productDescription, to: 'ml')
              .then((result) {
            productmal.productDescription = result.text;
            setState(() {
              
            });
          });
        });
      });

      return productmal;
    }
    return product;
  }
  // //A
  //Animation for button
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
  }

  //dispose for animation
  @override
  void dispose() {
    super.dispose();
  }

  ButtonState stateTextWithIcon = ButtonState.idle;

  @override
  Widget build(BuildContext context) {
    bool isInWishlist=false;
    return FutureBuilder(
      future: translate(widget.product),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          for(WishlistItem item in widget.wishlist??[]){
            print('checking');
            if(item.productId==snapshot.data.productId){
              print('present');
               return _cardUi(context: context, product: snapshot.data,inwishlist: true);
            }
          }
          return _cardUi(context: context, product: snapshot.data,inwishlist: isInWishlist);
        } else {
          return Container();
        }
      },
    );
  }

  @override
  Widget _cardUi({BuildContext context, Product product, bool inwishlist}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          
          MaterialPageRoute(
            
              builder: (context) => ProductView(
                    inWishlist: inwishlist,
                    product: product,
                    onMenuItemClicked: widget.onMenuItemClicked,
                  )),
        );
      },
      child: Container(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(8.0),
                height: MediaQuery.of(context).size.height * .35,
                width: MediaQuery.of(context).size.width * 0.43,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Hero(
                      tag: 'image' + product.productName,
                      child: Container(
                        height: MediaQuery.of(context).size.height * .28 * 0.6,
                        width: MediaQuery.of(context).size.width * 0.45 - 5,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 0.0, right: 0.0, bottom: 0.0),
                          child: Stack(children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(
                                    image: NetworkImage(widget.product.productImage),
                                    fit: BoxFit.contain),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.maxFinite,
                      child: Text(
                        product.productName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        // Text(
                        //   widget.product.type == null ? '' : widget.product.type,
                        //   style: TextStyle(
                        //     fontSize: 14,
                        //     fontFamily: 'Poppins',
                        //     fontWeight: FontWeight.w600,
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '₹${product.slPrice}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            price1(int.parse(product.mrpPrice)),
                          ],
                        ),
                        //TODO:
                        // dropdown(),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //button
                    Container(
                      width: 130,
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
                        onPressed: (){
                          addToCart(productId: product.productId,userId:userId );
                        },
                        state: stateTextWithIcon,
                      ),
                    ),

                    //OLD ADD Button
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.all(2.0),
                    //       child: Container(
                    //         width: 134,
                    //         height: 38,
                    //         padding: EdgeInsets.all(4),
                    //         decoration: BoxDecoration(
                    //             color: Color(0xff0B3666).withOpacity(0.9),
                    //             borderRadius: BorderRadius.circular(50)),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             Text(
                    //               " ADD ",
                    //               style: TextStyle(
                    //                 color: Colors.white,
                    //                 fontWeight: FontWeight.w400,
                    //               ),
                    //             ),
                    //             Icon(
                    //               Icons.add_shopping_cart_rounded,
                    //               size: 18,
                    //               color: Colors.white,
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // )
                  ],
                ),
              ),
            ),
            discount(int.parse(product.slPrice)),
            Positioned(
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: FavoriteButton(
                  isFavorite: inwishlist,
                  iconSize: 28,
                  valueChanged: (_) {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Container dropdown() {
  //   if (widget.product.type == null || widget.product.typeList == null) {
  //     return Container();
  //   } else {
  //     List<String> _typeList = widget.product.typeList;
  //     _selectedValue = widget.product.typeList[0];
  //     return Container(
  //       child: Center(
  //         child: DropdownButton<String>(
  //           value: _selectedValue,
  //           items: _typeList.map((String value) {
  //             return new DropdownMenuItem(
  //               value: value,
  //               child: new Text(value),
  //             );
  //           }).toList(),
  //           onChanged: (newValue) {
  //             setState(() {
  //               _selectedValue = newValue;
  //             });
  //           },
  //           dropdownColor: Colors.grey[200],
  //           style: TextStyle(
  //               fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
  //         ),
  //       ),
  //     );
  //   }
  // }

  Text price1(int price1) {
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

  discount(int discount) {
    if (discount != null) {
      return Positioned(
        top: 10,
        left: 10,
        child: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(5),
                topLeft: Radius.circular(15),
                bottomRight: Radius.circular(10)),
            color: Colors.red[600],
          ),
          child: Text(
            '${discount}% Off',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  void addToCart({String productId,String userId})  async {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
      setState(() {
          stateTextWithIcon = ButtonState.loading;
      });
      
        bool added;
        APIService apiService = APIService();
        added = await apiService.addItemToCart(productId: productId,userId: userId).then((value) {
          if(value== true){
            setState(() {
              stateTextWithIcon = ButtonState.success;
            });
          }
             if(value== false){
            setState(() {
              stateTextWithIcon = ButtonState.fail;
            });
          }
        });
        if(added){
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
