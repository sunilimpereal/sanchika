import 'package:flutter/material.dart';
import 'package:sanchika/pages/ui/widget/admin_wait.dart';

class CheckAddress extends StatefulWidget {
  @override
  _CheckAddressState createState() => _CheckAddressState();
}

class _CheckAddressState extends State<CheckAddress> {
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
          'Address',
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
                    left: 0.0,
                    top: 0,
                  ),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                          text: 'Enter Your Address',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          children: [
                            TextSpan(
                                text: '',
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 18,
                                ))
                          ]),
                    ),
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
                          'Address Details',
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
                  SizedBox(
                    height: 0,
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
                        labelText: 'Area address*',
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
                                  builder: (context) => AdminWait()),
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
