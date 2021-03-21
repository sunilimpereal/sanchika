import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rive/rive.dart';
import 'package:sanchika/model/signUp_model.dart';
import 'package:sanchika/pages/ui/widget/check_address.dart';
import 'package:sanchika/pages/ui/widget/otp.dart';
import 'package:sanchika/pages/ui/widget/termsConditions.dart';
import 'package:sanchika/services/api_service.dart';
import 'package:sanchika/utils/constants.dart';
import 'package:sanchika/utils/progressHUD.dart';
import 'package:sanchika/widgets/header_login.dart';
import 'package:flutter/services.dart';

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
  bool isApiCallProcess = false;
    Artboard _riveArtboard;
  RiveAnimationController _controller;
  @override
  void initState() {
    super.initState();
    requestModel = new RegisterRequestModel();
    apiService = new APIService();
       rootBundle.load('assets/rive/login.riv').then((value) async{
      final file =RiveFile();
      if(file.import(value)){
        final artboard = file.mainArtboard;
        artboard.addController(_controller = SimpleAnimation('loop'));
        setState(() {
          _riveArtboard = artboard;
          _controller.isActive = true ;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.2,
    );
  }

  Widget _uiSetup(BuildContext context) {
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
                child: Container(
               width: MediaQuery.of(context).size.width*0.8,
               height: 300,
                child: _riveArtboard == null? const SizedBox():Rive(artboard: _riveArtboard,fit: BoxFit.contain,)),
              
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
                                    labelText: 'Last Name',
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: new BorderSide(),
                                    ),
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      requestModel.lastname= val;
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
                                          setState(() {
                                            isApiCallProcess = false;
                                          });
                                          APIService apiService = APIService();
                                          print(requestModel.toJson());
                                          // apiService
                                          //     .register(requestModel)
                                          //     .then((value) 
                                              // {
                                            if (true) {
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckAddress(registerRequestModel: requestModel,)));
                                              // apiService
                                              //     .getotp(requestModel.mobile)
                                              //     .then((value) {
                                              //   if (value != null) {
                                              //     setState(() {
                                              //       isApiCallProcess = true;
                                              //     });
                                                  
                                              //     Navigator.push(
                                              //       context,
                                              //       MaterialPageRoute(
                                              //           builder: (context) =>
                                              //               Otp(
                                              //                 otp: value,
                                              //                 mobileNumber:
                                              //                     requestModel
                                              //                         .mobile,
                                              //               )),
                                              //     );
                                              //   } else {
                                              //     showDialog<void>(
                                              //       context: context,
                                              //       barrierDismissible:
                                              //           false, // user must tap button!
                                              //       builder:
                                              //           (BuildContext context) {
                                              //         return AlertDialog(
                                              //           title:
                                              //               Text('Try Later'),
                                              //           content:
                                              //               SingleChildScrollView(
                                              //             child: ListBody(
                                              //               children: <Widget>[
                                              //                 Text(
                                              //                     'Unable to send OTP'),
                                              //               ],
                                              //             ),
                                              //           ),
                                              //           actions: <Widget>[
                                              //             TextButton(
                                              //               child: Text('OK'),
                                              //               onPressed: () {
                                              //                 Navigator.of(
                                              //                         context)
                                              //                     .pop();
                                              //               },
                                              //             ),
                                              //           ],
                                              //         );
                                              //       },
                                              //     );
                                              //     setState(() {
                                              //       isApiCallProcess = false;
                                              //     });
                                              //   }
                                              // });
                                            } else {
                                              setState(() {
                                                isApiCallProcess = false;
                                              });
                                              showDialog<void>(
                                                context: context,
                                                barrierDismissible:
                                                    false, // user must tap button!
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title:
                                                        Text('Sign Up failed'),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: ListBody(
                                                        children: <Widget>[
                                                          Text(
                                                              'Unable to Sign Up'),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: Text('OK'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
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
                                          // },
                                         
                                        }
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
