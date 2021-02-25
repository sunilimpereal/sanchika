import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sanchika/model/user.dart';
import 'package:sanchika/pages/authentication/signup_page.dart';
import 'package:sanchika/pages/ui/widget/forgotPassword.dart';
import 'package:sanchika/utils/CustomIcons.dart';
import 'package:sanchika/utils/constants.dart';
import 'package:sanchika/widgets/header_login.dart';
import 'package:sanchika/widgets/socialIcons.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = ScrollController();
  double offset = 0;

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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Login",
                              style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(45),
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
                                  user.email = val;
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
                                  user.password = val;
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignupPage()),
                                      );
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

  @override
  void dispose() {
    // TODO: implement dispose
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onScroll);
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }
}
