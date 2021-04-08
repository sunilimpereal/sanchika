import 'package:flutter/material.dart';
import 'package:sanchika/menu_dashboard/menu_dashboard.dart';
import 'package:sanchika/model/signUp_model.dart';
import 'package:sanchika/pages/ui/widget/admin_wait.dart';
import 'package:sanchika/services/api_service.dart';
import 'package:sanchika/utils/progressHUD.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckAddress extends StatefulWidget {
  RegisterRequestModel registerRequestModel;
  CheckAddress({this.registerRequestModel});
  @override
  _CheckAddressState createState() => _CheckAddressState();
}

class _CheckAddressState extends State<CheckAddress> {
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  APIService apiService;
  bool isApiCallProcess = false;
  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _addressUi(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.2,
    );
  }

  @override
  Widget _addressUi(BuildContext context) {
    print(widget.registerRequestModel.lastname);
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
        child: Form(
          key: globalFormKey,
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
                          setState(() {
                            widget.registerRequestModel.asd1 = val;
                          });
                        },
                        validator: (val) {
                          if (val.length == 0) {
                            return 'Street Address cannot be empty';
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
                          setState(() {
                            widget.registerRequestModel.asd1 =
                                widget.registerRequestModel.asd1 + val;
                          });
                        },
                        validator: (val) {
                          if (val.length == 0) {
                            return 'area cannot be empty';
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
                          setState(() {
                            widget.registerRequestModel.city1 = val;
                          });
                        },
                        validator: (val) {
                          if (val.length == 0) {
                            return 'city cannot be empty';
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
                          setState(() {
                            widget.registerRequestModel.pin1 = val;
                          });
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
                            onTap: ()  {
                              if (validateAndSave()) {
                                    // SharedPreferences preferences =
                                    //             await SharedPreferences
                                    //                 .getInstance();
                                    //                   preferences.setString(
                                    //             'login', 'logged');
                                    //         preferences.setString(
                                    //             'email', widget.registerRequestModel.email);
                                    //         preferences.setString(
                                    //             'name', widget.registerRequestModel.firstName);
                                    //               preferences.setString(
                                    //             'userId', '');

                                print(widget.registerRequestModel.asd1);
                                setState(() {
                                  isApiCallProcess = false;
                                });
                                APIService apiService = APIService();
                                apiService
                                    .register(widget.registerRequestModel)
                                    .then((value)  {
                                  if (value != null) {
                                    setState(() {
                                      isApiCallProcess = true;
                                    });
                                  
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AdminWait()),
                                    );
                                  } else {
                                    showDialog<void>(
                                      context: context,
                                      barrierDismissible:
                                          false, // user must tap button!
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Try Later'),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Text('Unable to send OTP'),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text('OK'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    setState(() {
                                      isApiCallProcess = false;
                                    });
                                  }
                                });
                              }
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
