import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sanchika/model/signUp_model.dart';
import 'package:sanchika/model/user.dart';
import 'package:sanchika/pages/ui/widget/otp.dart';
import 'package:sanchika/pages/ui/widget/termsConditions.dart';
import 'package:sanchika/services/api_service.dart';
import 'package:sanchika/utils/constants.dart';
import 'package:sanchika/widgets/header_login.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final controller = ScrollController();
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  double offset = 0;

  RegisterRequestModel requestModel;
  APIService apiService;
  @override
  void initState() {
    super.initState();
    requestModel = new RegisterRequestModel();
    apiService = new APIService();
  }

  @override
  Widget build(BuildContext context) {
    User user = new User();
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return Scaffold(
      body: SingleChildScrollView(
          controller: controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MyHeader(
                image: "assets/icons/barbecue.svg",
                textTop: "Order and",
                textBottom: "Get to door steps",
                offset: offset,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(bottom: 1),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 0.0, bottom: 8.0),
                        child: Form(
                          key: globalFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Sign Up heading
                              Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(45),
                                    fontFamily: "Poppins-Bold",
                                    letterSpacing: .6),
                              ),
                              SizedBox(height: 15),
                              Container(
                                height: 50,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'First Name',
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: new BorderSide(),
                                    ),
                                  ),
                                  onChanged: (val) {
                                    setState(() {});
                                  },
                                  validator: (val) {
                                    if (val.length == 0) {
                                      return 'First name be empty';
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
                              SizedBox(height: 15),
                              Container(
                                height: 50,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Mobile',
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
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
                                  style: new TextStyle(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              Container(
                                height: 50,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
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
                                  style: new TextStyle(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              Container(
                                height: 50,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: new BorderSide(),
                                    ),
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
                                  style: new TextStyle(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              Container(
                                height: 50,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Confirm Password',
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: new BorderSide(),
                                    ),
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
                                  style: new TextStyle(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(10),
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(10),
                    ),
                    Column(
                      children: <Widget>[
                        SizedBox(
                          width: 12.0,
                        ),
                        Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                child: Container(
                                  width: ScreenUtil.getInstance().setWidth(330),
                                  height:
                                      ScreenUtil.getInstance().setHeight(100),
                                  decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(6.0),
                                      boxShadow: [
                                        BoxShadow(
                                            color: kActiveShadowColor,
                                            offset: Offset(0.0, 8.0),
                                            blurRadius: 8.0)
                                      ]),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        if (validateAndSave()) {
                                          APIService apiService = APIService();
                                          print(requestModel.toJson());
                                          apiService
                                              .register(requestModel)
                                              .then((value) {
                                            print(value.toJson());
                                          });
                                        }
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) => Otp()),
                                        // );
                                      },
                                      child: Center(
                                        child: Text(
                                          "SIGN UP",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Poppins-Bold",
                                              fontSize: 18,
                                              letterSpacing: 1.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("By sign up you accept our "),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TermsConditions()),
                                );
                              },
                              child: Text(
                                "Terms and Conditions",
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(20),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
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
