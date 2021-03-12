import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rive/rive.dart';
import 'package:sanchika/menu_dashboard/menu_dashboard.dart';
import 'package:sanchika/model/login_model.dart';
import 'package:sanchika/pages/authentication/signup_page.dart';
import 'package:sanchika/pages/ui/widget/forgotPassword.dart';
import 'package:sanchika/services/api_service.dart';
import 'package:sanchika/utils/constants.dart';
import 'package:sanchika/utils/progressHUD.dart';
import 'package:sanchika/widgets/header_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  final controller = ScrollController();
  double offset = 0;
  LoginRequestModel requestModel;
  bool isApiCallProcess = false;
  Artboard _riveArtboard;
  RiveAnimationController _controller;
  @override
  void initState() {
    super.initState();
    requestModel = new LoginRequestModel();
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
      opacity: 0.4,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 350,
                  height: 80,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/logo.png"))),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(bottom: 1),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 0.0),
                          BoxShadow(
                              color: Colors.white,
                              offset: Offset(0.0, -10.0),
                              blurRadius: 10.0),
                        ]),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
                      // Form Starts here
                      child: Form(
                        key: globalFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Login",
                                style: TextStyle(
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(45),
                                    fontFamily: "Poppins-Bold",
                                    letterSpacing: .6)),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Container(
                              height: 60,
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
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(25),
                            ),
                            Container(
                              height: 60,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8.0, left: 0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPassword()),
                                      );
                                    },
                                    child: Text(
                                      'forgot Password?',
                                      style: TextStyle(color: Colors.redAccent),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(25),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(30),
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
                                height: ScreenUtil.getInstance().setHeight(100),
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
                                     
                                      //Login Button
                                      if (validateAndSave()) {
                                        setState(() {
                                          isApiCallProcess = true;
                                        });
                                        APIService apiService = APIService();
                                        print(requestModel.toJson());
                                        apiService
                                            .login(requestModel,context)
                                            .then((value) async {
                                          if (value != null) {
                                            SharedPreferences preferences =
                                                await SharedPreferences
                                                    .getInstance();
                                            preferences.setString(
                                                'login', 'logged');
                                            preferences.setString(
                                                'email', requestModel.email);
                                            preferences.setString(
                                                'name', value.data.login.name);
                                            print(value.toJson());
                                            setState(() {
                                              isApiCallProcess = false;
                                            });
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MenuDashboard()),
                                            );
                                          } else {
                                             setState(() {
                                          isApiCallProcess = false;
                                        });
                                          }
                                        });

                                        print('Skipped');
                                      }
                                    },
                                    child: Center(
                                      child: Text("SIGN IN",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Poppins-Bold",
                                              fontSize: 18,
                                              letterSpacing: 1.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil.getInstance().setHeight(30),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "New User? ",
                            style: TextStyle(fontFamily: "Poppins-Medium"),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupPage()),
                              );
                            },
                            child: Text("SignUp",
                                style: TextStyle(
                                    color: Color(0xFF5d74e3),
                                    fontFamily: "Poppins-Bold")),
                          )
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil.getInstance().setHeight(40),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }
}
