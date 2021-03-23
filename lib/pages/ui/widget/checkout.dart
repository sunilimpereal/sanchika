
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sanchika/model/cart_model.dart';
import 'package:sanchika/model/getAddresss_model.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/pages/ui/screens/payment_page.dart';
import 'package:sanchika/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Checkoutpage extends StatefulWidget {
  CartItem cartItem;
  Checkoutpage({this.cartItem});
  @override
  _CheckoutpageState createState() => _CheckoutpageState();
}

class _CheckoutpageState extends State<Checkoutpage> {
  APIService apiService;
  String userId;
  Future<String> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String uid = preferences.getString('userId');

    setState(() {
      userId = uid;
    });
    return userId;
  }
  Address address;
  Future getAddress(String userId) async {
    APIService apiService = APIService();
    await apiService.getAddress().then((value){
 setState(() {
      address = value;
    });
    });
  }
  @override
  void initState() {
    super.initState();
    apiService = APIService();
     getUserId().then((value) {
      getAddress(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
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
            productview(),
            SizedBox(height: 40),
            totalCard(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GestureDetector(
          onTap: (){
               Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Payment(
                                     
                                    )),
                              );
          },
                  child: Container(
            width: 250,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:Color(0xff032e6b),
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

  Widget productview() {
    return FutureBuilder(
        future:
            apiService.getProductDetail(productId: widget.cartItem.productId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Product product = snapshot.data[0];
            return Container(
              padding: EdgeInsets.all(4),
              height: 130,
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
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Column(
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
                                    'Qty ${widget.cartItem.quantity}',
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    widget.cartItem.productWeight,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '₹ ${widget.cartItem.totalAmount}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
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
            return CircularProgressIndicator();
          }
        });
  }

  Widget addressDisplay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.95,
          height: 160,
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
                    address !=null? address?.asd1+','+address?.city1+','+address.state1+','+address.pin1: 'No address.update your address',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height:10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 140,
                    height: 40,
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
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.edit),
                          Text(
                            'Edit Address',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
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

  Widget totalCard() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
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
                  '₹${widget.cartItem.totalAmount}',
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
                    '₹ 0.0',
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
