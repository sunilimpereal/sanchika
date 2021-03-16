import 'package:flutter/material.dart';
import 'package:sanchika/model/getProductDetail_model.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/services/api_service.dart';
import 'package:sanchika/utils/numericStepButton.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WishlistCard extends StatefulWidget {
  String productId;
  WishlistCard({this.productId});
  @override
  _WishlistCardState createState() => _WishlistCardState();
}

class _WishlistCardState extends State<WishlistCard> {
  Future<Product> getProductDetail() async {
    APIService apiService = APIService();
    List<Product> product =
        await apiService.getProductDetail(productId: widget.productId);
    return product[0];
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
                    discount(int.parse(product.slPrice)),
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
                            price1(int.parse(product.mrpPrice)),
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
                            maxValue: 20,
                            onChanged: (value) {
                              setState(() {
                                // count = value;
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
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(3.0, 2.0),
                                color: Colors.grey[200],
                                blurRadius: 3.0,
                                spreadRadius: 2.0,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.cancel,
                                  color: Colors.redAccent,
                                  size: 20,
                                ),
                                Text(
                                  ' Remove  ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Container(
                          width: 140,
                          decoration: BoxDecoration(
                            color: Color(0xff0B3666),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(3.0, 2.0),
                                color: Colors.grey[200],
                                blurRadius: 3.0,
                                spreadRadius: 2.0,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shopping_cart,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                Text(
                                  ' Add to Cart',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
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
    );
  }

  //scrached price
  Text price1(int price1) {
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

  discount(int discount) {
    if (discount != null) {
      return Positioned(
        top: 1,
        left: 0,
        child: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(5),
                topLeft: Radius.circular(5),
                bottomRight: Radius.circular(10)),
            color: Colors.red[300],
          ),
          child: Text(
            '${discount}% Off',
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
}
