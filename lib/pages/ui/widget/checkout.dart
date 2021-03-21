import 'package:flutter/material.dart';
import 'package:sanchika/model/cart_model.dart';
import 'package:sanchika/model/getAddresss_model.dart';
import 'package:sanchika/pages/ui/widget/order_details.dart';
import 'package:sanchika/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutPage extends StatefulWidget {
  CartItem cartItem;
  CheckoutPage({this.cartItem});
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
    GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  String userId;
  String email;


  String name = '';
  void getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String getname = preferences.getString('name');
    setState(() {
      if (getName != null) {
        name = getname;
      } else {
        name = '';
      }
    });
  }
    void getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String getname = preferences.getString('email');
    setState(() {
      if (getName != null) {
        email = getname;
      } else {
        email = '';
      }
    });
  }
  Future<String> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String uid = preferences.getString('userId');
    String name = preferences.getString('name');
    String email = preferences.getString('email');

    setState(() {
      userId = uid;
      name = name;
      email = preferences.getString('email');
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
    getUserId().then((value) {
      getAddress(userId);
    });
    getName();
    getEmail();
  }

  @override
  Widget build(BuildContext context) {
    int orderPhone;
    print(userId);
    print('name $name');
        print('email $email');
        setState(() {
          
        });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left_rounded,
            size: 35,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Checkout',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.only(top: 8),
            icon: Icon(
              Icons.shopping_cart,
              size: 28,
            ),
            onPressed: () {
            },
          )
        ],
      ),
      body: Form(
        key: globalFormKey,
              child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xffEDE2DC),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      top: 15,
                    ),
                    child: RichText(
                      text: TextSpan(
                          text: 'Have a coupan ?',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          children: [
                            TextSpan(
                                text: ' Click here to enter your code',
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 18,
                                ))
                          ]),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        top: 15,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Billing Details',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: TextEditingController()..text= name??'',

                        decoration: InputDecoration(
                          labelText: 'First name*',
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            gapPadding: 0,
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        onChanged: (val) {
                          setState(() {});
                        },
                        validator: (val) {
                          if (val.length == 0) {
                            return 'Email cannot be empty';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: new TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                 
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: TextEditingController()..text= address?.asd1,
                        decoration: InputDecoration(
                          labelText: '  address  ' ,
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            gapPadding: 0,
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        onChanged: (val) {
                          setState(() {});
                        },
                        validator: (val) {
                          if (val.length == 0) {
                            return 'Feild cannot be empty';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: new TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                           controller: TextEditingController()..text= address?.city1+' , ' +address?.state1??'',
                        decoration: InputDecoration(
                          labelText: '  Town/city  ',
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            gapPadding: 0,
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        onChanged: (val) {
                          setState(() {});
                        },
                        validator: (val) {
                          if (val.length == 0) {
                            return 'Feild cannot be empty';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: new TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                               controller: TextEditingController()..text= address?.pin1??'',
                        decoration: InputDecoration(
                          labelText: 'Pincode/ZIP',
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            gapPadding: 0,
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        onChanged: (val) {
                          setState(() {});
                        },
                        validator: (val) {
                          if (val.length == 0) {
                            return 'Feild cannot be empty';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: new TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                            controller: TextEditingController()..text= email??'',
                        decoration: InputDecoration(
                          labelText: 'email',
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            gapPadding: 0,
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        onChanged: (val) {
                          setState(() {});
                        },
                        validator: (val) {
                          if (val.length == 0) {
                            return 'Feild cannot be empty';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: new TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Phone',
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            gapPadding: 0,
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        onChanged: (val) {
                          setState(() {
                            orderPhone = int.parse(val);
                          });
                        },
                        validator: (val) {
                          if (val.length == 0) {
                            return 'feild cannot be empty';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: new TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderCheckout(
                                      userId: userId,
                                      productId: '500001',
                                      price: '0',
                                      orderCity: address.city1,
                                      orderPaymentType: "COD",
                                      orderShippingAddress: address.asd1+address.city1,
                                      orderPhoneNumber: orderPhone,
                                    )),
                              );
                            },
                            child: Container(
                              width: 200,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child: Text(
                                  'Continue',
                                  style: TextStyle(
                                    fontSize: 19,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
    bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
