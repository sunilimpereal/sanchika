import 'package:flutter/material.dart';
import 'package:sanchika/model/cart_model.dart';
import 'package:sanchika/model/getAddresss_model.dart';
import 'package:sanchika/model/orderItem_model.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/pages/ui/screens/payment/payment_page.dart';
import 'package:sanchika/pages/ui/screens/saveOrderDetails.dart';
import 'package:sanchika/services/api_service.dart';
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
  List<OrderItem> orderitems;
  void getOrderitems(){
    for(CartItem a in widget.cartItems){
      OrderItem orderItem;
      orderItem.totalQuantity = a.quantity.toString();
      orderItem.userId = userId;
      orderItem.orderDate = DateTime.now().toString();
    }
  }
  Future<String> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String uid = preferences.getString('userId');

    setState(() {
      userId = uid;
    });
    return userId;
  }


  double totalAmount;
   double saved=0;
  void getTotal() {
    double total = 0;
    double totalselling=0;
   
    for (CartItem item in widget.cartItems) {
      total += double.parse(item.totalAmount);
      totalselling +=item.mrp;
    }
    setState(() {
      saved = total - totalselling;
      totalAmount = total;
    });
  }

  Address address;
  Future getAddress(String userId) async {
    APIService apiService = APIService();
    await apiService.getAddress().then((value) {
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
      getAddress(userId);
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
            totalCard( total: totalAmount,saved: saved),
            SizedBox(height:50)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Payment(
                totalAmount: totalAmount,
              )),
            );
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
                  'Next',
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
                                image: NetworkImage(product.productImage))),
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
                                      product.productName,
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
                      mrp: double.parse(product.mrpPrice),
                      slp: double.parse(product.slPrice)),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.95,
          height: 140,
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
                  'Shipping Address',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    address != null
                        ? address?.asd1 +
                            ',' +
                            address?.city1 +
                            ',' +
                            address.state1 +
                            ',' +
                            address.pin1
                        : 'No address.update your address',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
                          offset: Offset(0, 3), // changes position of shadow
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
              )
            ],
          ),
        ),
      ],
    );
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

  Widget totalCard({double total,double saved}) {
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
                    fontSize: 18,
                    fontFamily: 'Poppins',
                  ),
                ),
              ]),
              SizedBox(height: 5),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
              ]),
              SizedBox(height: 5),
              Row(
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
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:sanchika/model/cart_model.dart';
// import 'package:sanchika/model/getAddresss_model.dart';
// import 'package:sanchika/pages/ui/widget/order_details.dart';
// import 'package:sanchika/services/api_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class CheckoutPage extends StatefulWidget {
//   CartItem cartItem;
//   CheckoutPage({this.cartItem});
//   @override
//   _CheckoutPageState createState() => _CheckoutPageState();
// }

// class _CheckoutPageState extends State<CheckoutPage> {
//     GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
//   String userId;
//   String email;

//   String name = '';
//   void getName() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     String getname = preferences.getString('name');
//     setState(() {
//       if (getName != null) {
//         name = getname;
//       } else {
//         name = '';
//       }
//     });
//   }
//     void getEmail() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     String getname = preferences.getString('email');
//     setState(() {
//       if (getName != null) {
//         email = getname;
//       } else {
//         email = '';
//       }
//     });
//   }
//   Future<String> getUserId() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     String uid = preferences.getString('userId');
//     String name = preferences.getString('name');
//     String email = preferences.getString('email');

//     setState(() {
//       userId = uid;
//       name = name;
//       email = preferences.getString('email');
//     });
//     return userId;
//   }

//   Address address;
//   Future getAddress(String userId) async {
//     APIService apiService = APIService();
//     await apiService.getAddress().then((value){
//  setState(() {
//       address = value;
//     });
//     });

//   }

//   @override
//   void initState() {
//     super.initState();
//     getUserId().then((value) {
//       getAddress(userId);
//     });
//     getName();
//     getEmail();
//   }

//   @override
//   Widget build(BuildContext context) {
//     int orderPhone;
//     print(userId);
//     print('name $name');
//         print('email $email');
//         setState(() {

//         });
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(
//             Icons.keyboard_arrow_left_rounded,
//             size: 35,
//             color: Colors.black,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text(
//           'Checkout',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.w400,
//             color: Colors.black,
//           ),
//         ),
//         actions: [
//           IconButton(
//             padding: EdgeInsets.only(top: 8),
//             icon: Icon(
//               Icons.shopping_cart,
//               size: 28,
//             ),
//             onPressed: () {
//             },
//           )
//         ],
//       ),
//       body: Form(
//         key: globalFormKey,
//               child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 60,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Color(0xffEDE2DC),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                       left: 16.0,
//                       top: 15,
//                     ),
//                     child: RichText(
//                       text: TextSpan(
//                           text: 'Have a coupan ?',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 18,
//                           ),
//                           children: [
//                             TextSpan(
//                                 text: ' Click here to enter your code',
//                                 style: TextStyle(
//                                   color: Colors.blueGrey,
//                                   fontSize: 18,
//                                 ))
//                           ]),
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.all(8),
//                 width: double.infinity,
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(
//                         left: 16.0,
//                         top: 15,
//                       ),
//                       child: Row(
//                         children: [
//                           Text(
//                             'Billing Details',
//                             style: TextStyle(
//                               fontSize: 19,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: TextFormField(
//                         controller: TextEditingController()..text= name??'',

//                         decoration: InputDecoration(
//                           labelText: 'First name*',
//                           fillColor: Colors.white,
//                           border: new OutlineInputBorder(
//                             gapPadding: 0,
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: new BorderSide(),
//                           ),
//                         ),
//                         onChanged: (val) {
//                           setState(() {});
//                         },
//                         validator: (val) {
//                           if (val.length == 0) {
//                             return 'Email cannot be empty';
//                           } else {
//                             return null;
//                           }
//                         },
//                         keyboardType: TextInputType.emailAddress,
//                         style: new TextStyle(
//                           fontFamily: 'Poppins',
//                         ),
//                       ),
//                     ),

//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: TextFormField(
//                         controller: TextEditingController()..text= address?.asd1,
//                         decoration: InputDecoration(
//                           labelText: '  address  ' ,
//                           fillColor: Colors.white,
//                           border: new OutlineInputBorder(
//                             gapPadding: 0,
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: new BorderSide(),
//                           ),
//                         ),
//                         onChanged: (val) {
//                           setState(() {});
//                         },
//                         validator: (val) {
//                           if (val.length == 0) {
//                             return 'Feild cannot be empty';
//                           } else {
//                             return null;
//                           }
//                         },
//                         keyboardType: TextInputType.emailAddress,
//                         style: new TextStyle(
//                           fontFamily: 'Poppins',
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: TextFormField(
//                           //  controller: TextEditingController()..text= address?.city1+' , ' +address?.state1??'',
//                         decoration: InputDecoration(
//                           labelText: '  Town/city  ',
//                           fillColor: Colors.white,
//                           border: new OutlineInputBorder(
//                             gapPadding: 0,
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: new BorderSide(),
//                           ),
//                         ),
//                         onChanged: (val) {
//                           setState(() {});
//                         },
//                         validator: (val) {
//                           if (val.length == 0) {
//                             return 'Feild cannot be empty';
//                           } else {
//                             return null;
//                           }
//                         },
//                         keyboardType: TextInputType.emailAddress,
//                         style: new TextStyle(
//                           fontFamily: 'Poppins',
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: TextFormField(
//                                controller: TextEditingController()..text= address?.pin1??'',
//                         decoration: InputDecoration(
//                           labelText: 'Pincode/ZIP',
//                           fillColor: Colors.white,
//                           border: new OutlineInputBorder(
//                             gapPadding: 0,
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: new BorderSide(),
//                           ),
//                         ),
//                         onChanged: (val) {
//                           setState(() {});
//                         },
//                         validator: (val) {
//                           if (val.length == 0) {
//                             return 'Feild cannot be empty';
//                           } else {
//                             return null;
//                           }
//                         },
//                         keyboardType: TextInputType.emailAddress,
//                         style: new TextStyle(
//                           fontFamily: 'Poppins',
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: TextFormField(
//                             controller: TextEditingController()..text= email??'',
//                         decoration: InputDecoration(
//                           labelText: 'email',
//                           fillColor: Colors.white,
//                           border: new OutlineInputBorder(
//                             gapPadding: 0,
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: new BorderSide(),
//                           ),
//                         ),
//                         onChanged: (val) {
//                           setState(() {});
//                         },
//                         validator: (val) {
//                           if (val.length == 0) {
//                             return 'Feild cannot be empty';
//                           } else {
//                             return null;
//                           }
//                         },
//                         keyboardType: TextInputType.emailAddress,
//                         style: new TextStyle(
//                           fontFamily: 'Poppins',
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           labelText: 'Phone',
//                           fillColor: Colors.white,
//                           border: new OutlineInputBorder(
//                             gapPadding: 0,
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: new BorderSide(),
//                           ),
//                         ),
//                         onChanged: (val) {
//                           setState(() {
//                             orderPhone = int.parse(val);
//                           });
//                         },
//                         validator: (val) {
//                           if (val.length == 0) {
//                             return 'feild cannot be empty';
//                           } else {
//                             return null;
//                           }
//                         },
//                         keyboardType: TextInputType.emailAddress,
//                         style: new TextStyle(
//                           fontFamily: 'Poppins',
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.all(8),
//                 width: double.infinity,
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(
//                         left: 16.0,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => OrderCheckout(
//                                       userId: userId,
//                                       productId: '500001',
//                                       price: '0',
//                                       orderCity: address.city1,
//                                       orderPaymentType: "COD",
//                                       orderShippingAddress: address.asd1+address.city1,
//                                       orderPhoneNumber: orderPhone,
//                                     )),
//                               );
//                             },
//                             child: Container(
//                               width: 200,
//                               height: 50,
//                               decoration: BoxDecoration(
//                                 color: Colors.green,
//                                 borderRadius: BorderRadius.circular(25),
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   'Continue',
//                                   style: TextStyle(
//                                     fontSize: 19,
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//     bool validateAndSave() {
//     final form = globalFormKey.currentState;
//     if (form.validate()) {
//       form.save();
//       return true;
//     }
//     return false;
//   }
// }

// class Payment extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//     );
//   }
// }
