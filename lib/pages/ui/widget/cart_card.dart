import 'package:flutter/material.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/pages/ui/widget/product_view.dart';
import 'package:sanchika/pages/ui/widget/stepper.dart';
import 'package:sanchika/services/api_service.dart';
import 'package:shimmer/shimmer.dart';

class CartCard extends StatefulWidget {
  final String productId;
  final String userId;
  final int qty;
  final Function() notifyParent;
  CartCard({this.productId, this.qty, this.userId, this.notifyParent});
  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  Future<Product> productDetail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<Product> getProductDetail() async {
      APIService apiService = APIService();
      List<Product> product =
          await apiService.getProductDetail(productId: widget.productId);
      print(widget.productId);
      return product[0];
    }

    return FutureBuilder(
      future: getProductDetail(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return cartCardUi(context, snapshot.data);
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
    );
  }

  @override
  Widget cartCardUi(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductView(
             inWishlist: true,
                    product: product,
                    userId: widget.userId,
                
          )),
        );
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              width: 1,
              color: Colors.white,
            ))),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.158 + 15,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(3.0),
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  width:
                                      MediaQuery.of(context).size.width * 0.26,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      image: NetworkImage(
                                        product?.pdmIm1 ?? '',
                                      ),
                                      fit: BoxFit.contain,
                                    )),
                                  ),
                                ),
                                discount(
                                    mrp: double.parse(product?.mrpPr ?? '0'),
                                    slp: double.parse(product?.slPrc ?? '0')),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Container(
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width * 0.65,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(0),
                                    width: MediaQuery.of(context).size.width *
                                        0.65,
                                    height: 60,
                                    color: Colors.white,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.65,
                                            child: Text(
                                              product?.pdmPdtNm,
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(0),
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: 45,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "₹${product?.slPrc ?? 0}",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            price1(double.parse(
                                                product.mrpPr ?? '0')),
                                          ],
                                        ),
                                        Container(
                                          child: Container(
                                              color: Colors.transparent,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              child: StepperTouch(
                                                initialValue: 1,
                                                direction: Axis.horizontal,
                                                withSpring: true,
                                                onChanged: (int value) {},
                                              )),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Positioned(
              top: -10,
              right: -5,
              child: IconButton(
                icon: Icon(
                  Icons.clear,
                  color: Colors.grey,
                  size: 18,
                ),
                onPressed: () {
                  removeCartitem(uid: widget.userId, pid: widget.productId);
                },
              ))
        ],
      ),
    );
  }

  //scrached price
  Text price1(double price1) {
    if (price1 != null) {
      return Text(
        '₹$price1',
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

  void removeCartitem({String uid, String pid}) async {
    print('pid $pid');

    APIService apiService = new APIService();
    await apiService.removeCartItem(userId: uid, pid: pid).then((value) {
      if (value == true) {
        widget.notifyParent();
        setState(() {});
      } else {
        print('false');
      }
    });
  }

  discount({double mrp, double slp}) {
    int discount = 0;
    if (mrp != slp) {
      discount = (((mrp - slp) / mrp) * 100).round();
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
}
