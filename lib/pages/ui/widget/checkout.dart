import 'package:flutter/material.dart';
import 'package:sanchika/pages/ui/widget/order_details.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
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
                  SizedBox(
                    height: 0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Last name',
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
                      decoration: InputDecoration(
                        labelText: 'Street address*',
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
                      decoration: InputDecoration(
                        labelText: 'Street address *',
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
                      decoration: InputDecoration(
                        labelText: 'Town/city*',
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
                                  builder: (context) => OrderCheckout()),
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
    );
  }
}
