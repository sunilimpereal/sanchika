import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sanchika/main.dart';
import 'package:sanchika/model/signUp_model.dart';
import 'package:sanchika/pages/ui/widget/admin_wait.dart';
import 'package:sanchika/services/api_service.dart';
import 'package:sanchika/utils/progressHUD.dart';

enum SignupState { info, password, address }

class SignUpBox extends StatefulWidget {
  @override
  _SignUpBoxState createState() => _SignUpBoxState();
}

class _SignUpBoxState extends State<SignUpBox> {
  RegisterRequestModel requestModel;
  SignupState _signupState = SignupState.info;
  GlobalKey<FormState> infoFormkey = new GlobalKey<FormState>();
  GlobalKey<FormState> passwordFromKey = new GlobalKey<FormState>();
  GlobalKey<FormState> addressFormKey = new GlobalKey<FormState>();
  FocusNode node = new FocusNode();
  APIService apiService;
  bool isApiCallProcess = false;
  bool _obscureText = false;
  double load = 0;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    _obscureText = true;
    requestModel = new RegisterRequestModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      opacity: 0.2,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              Container(
                width: 350,
                height: 80,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/logo.png"))),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(45),
                          fontFamily: "Poppins-Bold",
                          letterSpacing: .6),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Material(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                  elevation: 5,
                  shadowColor: Colors.grey[100],
                  child: Column(
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        padding: EdgeInsets.all(0),
                        // height: MediaQuery.of(context).size.height * 0.5,

                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 5,
                                  width:
                                      (MediaQuery.of(context).size.width - 30),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[50],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                ),
                                Container(
                                  height: 5,
                                  width:
                                      (MediaQuery.of(context).size.width - 15) *
                                          load,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: main(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget main() {
    switch (_signupState) {
      case SignupState.info:
        return info();
        break;
      case SignupState.info:
        return password();
        break;
      case SignupState.address:
        return address();
        break;
      default:
        return password();
        break;
    }
  }

  Widget info() {
    return Form(
      key: infoFormkey,
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Info",
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().setSp(35),
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        letterSpacing: .5),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (a) {
                  setState(() {
                    load = 0.06;
                  });
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(15),
                  labelText: 'First Name',
                  fillColor: Colors.grey,
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                onChanged: (val) {
                  setState(() {
                    requestModel.firstName = val;
                  });
                },
                validator: (val) {
                  if (val.length == 0) {
                    return 'First name be empty';
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                style: new TextStyle(fontFamily: 'Poppins', fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (a) {
                  setState(() {
                    load = 0.12;
                  });
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(15),
                  labelText: 'Last Name',
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                onChanged: (val) {
                  setState(() {
                    requestModel.lastname = val;
                  });
                },
                validator: (val) {
                  if (val.length == 0) {
                    return 'Last name is empty';
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                style: new TextStyle(fontFamily: 'Poppins', fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (a) {
                  setState(() {
                    load = 0.18;
                  });
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(15),
                  labelText: 'Mobile',
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                onChanged: (val) {
                  setState(() {
                    requestModel.mobile = val;
                  });
                },
                validator: (val) {
                  if (val.length == 0) {
                    return 'Mobile cannot be empty';
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                style: new TextStyle(fontFamily: 'Poppins', fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (a) {
                  setState(() {
                    load = 0.24;
                  });
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(15),
                  labelText: 'Email',
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                onChanged: (val) {
                  setState(() {
                    requestModel.email = val;
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
                style: new TextStyle(fontFamily: 'Poppins', fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 200,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      final form = infoFormkey.currentState;
                      setState(() {
                        if (form.validate()) {
                          form.save();
                          load = 0.25;

                          _signupState = SignupState.password;
                        }
                      });
                    },
                    child: Text('Next')),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget password() {
    return Form(
      key: passwordFromKey,
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Create a new Password",
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().setSp(35),
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins",
                        letterSpacing: .5),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextFormField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (a) {
                  setState(() {
                    load = 0.37;
                  });
                },
                obscureText: _obscureText,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(15),
                  labelText: 'Password',
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: new BorderSide(),
                  ),
                  suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        !_obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                        size: 18,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _toggle();
                        });
                      }),
                ),
                onChanged: (val) {
                  setState(() {
                    requestModel.password = val;
                  });
                },
                validator: (val) {
                  if (val.length == 0) {
                    return 'Password cannot be empty';
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.visiblePassword,
                style: new TextStyle(fontFamily: 'Poppins', fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextFormField(
                obscureText: _obscureText,
                onFieldSubmitted: (a) {
                  setState(() {
                    load = 0.49;
                  });
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(15),
                  labelText: 'Confirm Password',
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: new BorderSide(),
                  ),
                  suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        !_obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                        size: 18,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _toggle();
                        });
                      }),
                ),
                onChanged: (val) {
                  setState(() {});
                },
                validator: (val) {
                  if (val.length == 0) {
                    return 'Password cannot be empty';
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.visiblePassword,
                style: new TextStyle(fontFamily: 'Poppins', fontSize: 14),
              ),
            ),
            Container(
              height: 50,
              width: 150,
              child: ElevatedButton(
                  onPressed: () {
                    final form = passwordFromKey.currentState;
                    setState(() {
                      load = 0.5;

                      if (form.validate()) {
                        form.save();

                        _signupState = SignupState.address;
                      }
                    });
                  },
                  child: Text('Next')),
            )
          ],
        ),
      ),
    );
  }

  Widget address() {
    return Form(
        key: addressFormKey,
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Address Details",
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(35),
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins",
                          letterSpacing: .5),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  autofocus: true,
                  maxLines: 3,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (a) {
                    setState(() {
                      load = 0.62;
                    });
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(15),
                    labelText: ' Street address*  ',
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      gapPadding: 0,
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      requestModel.asd1 = val;
                    });
                  },
                  validator: (val) {
                    if (val.length == 0) {
                      return 'Street Address cannot be empty';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.streetAddress,
                  style: new TextStyle(fontFamily: 'Poppins', fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (a) {
                    setState(() {
                      load = 0.74;
                    });
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(15),
                    labelText: 'Town/city*',
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      gapPadding: 0,
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      requestModel.city1 = val;
                    });
                  },
                  validator: (val) {
                    if (val.length == 0) {
                      return 'city cannot be empty';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.streetAddress,
                  style: new TextStyle(fontFamily: 'Poppins', fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (a) {
                    setState(() {
                      load = 0.86;
                    });
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(15),
                    labelText: 'Pincode/ZIP',
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      gapPadding: 0,
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      requestModel.pin1 = val;
                    });
                  },
                  validator: (val) {
                    if (val.length == 0) {
                      return 'PinCode cannot be empty';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: new TextStyle(fontFamily: 'Poppins', fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (a) {
                    setState(() {
                      load = 0.98;
                    });
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(15),
                    labelText: 'State',
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      gapPadding: 0,
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      requestModel.state1 = val;
                    });
                  },
                  validator: (val) {
                    if (val.length == 0) {
                      return 'State cannot be empty';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: new TextStyle(fontFamily: 'Poppins', fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                      onPressed: () {
                        final form = addressFormKey.currentState;

                        if (form.validate()) {
                          form.save();
                          setState(() {
                            isApiCallProcess = true;
                            load = 1;
                          });

                          APIService apiService = APIService();
                          apiService.register(requestModel).then((value) {
                            if (value != null) {
                              setState(() {
                                isApiCallProcess = true;
                              });
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminWait()),
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
                      child: Text('SIGN UP')),
                ),
              )
            ],
          ),
        ));
  }
}
