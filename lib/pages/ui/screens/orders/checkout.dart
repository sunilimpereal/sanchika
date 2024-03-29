import 'package:flutter/material.dart';
import 'package:sanchika/model/cart_model.dart';
import 'package:sanchika/model/getAddresss_model.dart';
import 'package:sanchika/model/getShippingDetail.dart';
import 'package:sanchika/model/multiitemSaveOrder.dart';
import 'package:sanchika/model/myInformation.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/pages/ui/screens/payment/payment_page.dart';
import 'package:sanchika/pages/ui/screens/saveOrderDetails.dart';
import 'package:sanchika/services/api_service.dart';
import 'package:sanchika/utils/CartToOrder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class Checkoutpage extends StatefulWidget {
  List<CartItem> cartItems;
  Checkoutpage({this.cartItems});
  @override
  _CheckoutpageState createState() => _CheckoutpageState();
}

class _CheckoutpageState extends State<Checkoutpage> {
  APIService apiService;
  String userId;
  List<OrderItem> orderItems = [];
  List<OrderItem> getOrderitems({ShippingAddress shippingAddress}) {
    print("first Name :${shippingAddress?.firstName}");
    ConvertCartToOrder conv = ConvertCartToOrder(
        userId: userId, cartItems: widget.cartItems, address: shippingAddress);
    orderItems =
        conv.convert(address: shippingAddress, cartItems: widget.cartItems);
    print(orderItems);
    return orderItems;
  }
  // http://sanchika.in:8081/sanchikaapi/sanchika/user/getShippingAddress?userId=1000

  Future<String> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String uid = preferences.getString('userId');

    setState(() {
      userId = uid;
    });
    return userId;
  }

  double totalAmount;
  double saved = 0;
  void getTotal() {
    double total = 0;
    double totalselling = 0;

    for (CartItem item in widget.cartItems) {
      total += double.parse(item.totalAmount);
      totalselling += item.mrp;
    }
    setState(() {
      saved = total - totalselling;
      totalAmount = total;
    });
  }

  ShippingAddress address;
  Future getAddress(String userId) async {
    APIService apiService = APIService();
    await apiService.getShippingDetail(userId).then((value) {
      setState(() {
        address = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    apiService = APIService();
    getTotal();
    getUserId().then((value) {
      apiService.getShippingDetail(userId).then((value) {
        if (value != null) {
          getOrderitems(shippingAddress: value);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(totalAmount);
    int offset = 0;
    int time = 800;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Checkout',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            progressBar(),
            SizedBox(height: 10),
            addressDisplay(),
            SizedBox(
              height: 10,
            ),
            productView(),
            SizedBox(height: 0),
            totalCard(total: totalAmount, saved: saved),
            SizedBox(height: 50)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GestureDetector(
          onTap: () {
            apiService.getShippingDetail(userId).then((value) {
              if (value != null) {
                List<OrderItem> orderitems =
                    getOrderitems(shippingAddress: value);
                apiService.multiItemOrder(data: orderitems).then((value) {
                  if (value != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Payment(
                                totalAmount: totalAmount,
                              )),
                    );
                  }
                });
              }
            });

            // APIService apiService = APIService();
            // getOrderitems();
            print(orderItems);
          },
          child: Container(
            width: 250,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xff032e6b),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Place Order & Pay',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget discount({double mrp, double slp}) {
    int discount = 0;
    if (mrp != slp) {
      discount = (((mrp - slp) / mrp) * 100).round();
    } else {}
    if (discount > 0) {
      return Positioned(
        top: 0,
        left: 0,
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

  Widget productView() {
    int offset = 0;
    int time = 800;

    return Container(
      height: 280,
      child: ListView.builder(
        itemCount: widget.cartItems.length,
        itemBuilder: (context, index) {
          offset += 30;
          time = 1600 + offset;
          return productCard(widget.cartItems[index],
              offset: offset, timer: time);
        },
      ),
    );
  }

  Widget productCard(CartItem cartitem, {int offset, int timer}) {
    return FutureBuilder(
        future: apiService.getProductDetail(productId: cartitem.productId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Product product = snapshot.data[0];
            return Container(
              padding: EdgeInsets.all(4),
              height: 110,
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 100,
                        height: 120,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            image: DecorationImage(
                                image: NetworkImage(product.pdmIm1))),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.58,
                                    child: Text(
                                      product.pdmPdtNm,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Qty ${cartitem.quantity}',
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    cartitem.productWeight,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    '₹ ${cartitem.totalAmount}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                height: 1,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  discount(
                      mrp: double.parse(product.mrpPr ?? "0"),
                      slp: double.parse(product.slPrc ?? '0')),
                ],
              ),
            );
          } else {
            return SizedBox(
              height: 120,
              width: MediaQuery.of(context).size.width * 0.95,
              child: Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.white,
                  period: Duration(milliseconds: timer),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    height: 120,
                    width: MediaQuery.of(context).size.width * 0.95,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.transparent,
                    ),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 100,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 15,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.58,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                        ),
                                        Container(
                                          height: 20,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                        )
                                      ],
                                    ),
                                    Divider(
                                      height: 1,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
            );
          }
        });
  }

  Widget addressDisplay() {
    return FutureBuilder(
        future: apiService.getShippingDetail(userId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ShippingAddress shippingDetail = snapshot.data;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(children: [
                        Icon(Icons.location_on),
                        SizedBox(width: 5),
                        Text(
                          'Shipping Details',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ]),
                      SizedBox(height: 5),
                      Row(children: [
                        SizedBox(width: 3),
                        Text(
                          "${shippingDetail?.firstName}" +
                              " " +
                              "${shippingDetail?.lastName}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ]),
                      SizedBox(height: 3),
                      Row(children: [
                        SizedBox(width: 3),
                        Text(
                          "${shippingDetail?.mobile}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ]),
                      SizedBox(height: 3),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Text(
                              shippingDetail.pin1 != null
                                  ? "${shippingDetail?.asd1}" +
                                      ',' +
                                      "${shippingDetail?.city1}" +
                                      ',' +
                                      "${shippingDetail.state1}" +
                                      ',' +
                                      "${shippingDetail.pin1}"
                                  : 'No address.update your address',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                padding: EdgeInsets.all(0),
                                icon: Icon(Icons.edit),
                                iconSize: 24,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SaveUserOrderdetail()),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        });
  }

  Widget progressBar() {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 5,
              width: MediaQuery.of(context).size.width * 0.32,
              decoration: BoxDecoration(
                  color: Color(0xff032e6b),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
            Container(
              height: 5,
              width: MediaQuery.of(context).size.width * 0.32,
              decoration: BoxDecoration(
                  color: Color(0xff032e6b).withOpacity(0.2),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
            Container(
              height: 5,
              width: MediaQuery.of(context).size.width * 0.32,
              decoration: BoxDecoration(
                  color: Color(0xff032e6b).withOpacity(0.2),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            )
          ],
        ));
  }

  Widget totalCard({double total, double saved}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'Total Price',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  '₹$totalAmount',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                  ),
                ),
              ]),
              SizedBox(height: 5),
              (() {
                return Container();
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shipping Price',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Text(
                        '₹ 0.0',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Poppins',
                        ),
                      )
                    ]);
              }()),
              SizedBox(height: 5),
              (() {
                return Container();
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Saved',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      '₹ $saved',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                      ),
                    )
                  ],
                );
              }()),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
