import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';
import 'package:sanchika/localization/localization_methods.dart';
import 'package:sanchika/main.dart';
import 'package:sanchika/model/getAddresss_model.dart';
import 'package:sanchika/model/getShippingDetail.dart';
import 'package:sanchika/model/language.dart';
import 'package:sanchika/pages/authentication/login_page.dart';
import 'package:sanchika/pages/ui/screens/orders/myOrders.dart';
import 'package:sanchika/pages/ui/sub_screens/changePassword/password%20change.dart';
import 'package:sanchika/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:toast/toast.dart';

class Profile extends StatefulWidget with NavigationStates {
  final Function onMenuTap;
  final Function onMenuItemClicked;

  const Profile({Key key, this.onMenuTap, this.onMenuItemClicked})
      : super(key: key);
  @override
  PprofileState createState() => PprofileState();
}

class PprofileState extends State<Profile> {
  APIService apiService;
  String name;
  String email;
  String userId;
  void getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString('name');
    });
    setState(() {
      email = preferences.getString('email');
    });
    setState(() {
      userId = preferences.getString('userId');
    });
  }

  @override
  void initState() {
    super.initState();
    getName();
    apiService = APIService();
  }

  bool english;
  bool malayalam;
  void getLanguageTick() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString('language') == 'malayalam') {
      setState(() {
        english = false;
        malayalam = true;
      });
    } else {
      setState(() {
        english = true;
        malayalam = false;
      });
    }
  }

  void _changeLanguage(Language language) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Locale _temp;
    print(language.languageCode);
    switch (language.languageCode) {
      case 'en':
        _temp = Locale(language.languageCode, 'US');
        preferences.setString('language', 'english');
        setState(() {
          english = true;
          malayalam = false;
        });
        break;
      case 'ml':
        _temp = Locale(language.languageCode, 'IN');
        preferences.setString('language', 'malayalam');
        setState(() {
          english = false;
          malayalam = true;
        });
        break;
      default:
        _temp = Locale(language.languageCode, 'US');
    }
    MyApp.setLocale(context, _temp);
  }

  // Logout
  Future logOut(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('login');
    showToast("Logging Out...", gravity: Toast.BOTTOM);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          getTranslated(context, "Profile"),
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.only(top: 0),
            icon: Icon(
              Icons.favorite_rounded,
              color: Color(0xff032e6b).withAlpha(180),
              size: 24,
            ),
            onPressed: () {
              BlocProvider.of<NavigationBloc>(context)
                  .add(NavigationEvents.WishlistClickedEvent);
              widget.onMenuItemClicked();
            },
          ),
          Stack(
            children: [
              IconButton(
                padding: EdgeInsets.only(top: 0),
                icon: Icon(
                  Icons.shopping_cart,
                  color: Color(0xff032e6b).withAlpha(180),
                  size: 24,
                ),
                onPressed: () {
                  BlocProvider.of<NavigationBloc>(context)
                      .add(NavigationEvents.CartClickedEvent);
                  widget.onMenuItemClicked();
                },
              ),
              FutureBuilder(
                  future: apiService.cartlength(uid: userId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 25),
                        child: Container(
                          height: 18,
                          width: 18,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff032e6b),
                          ),
                          child: Center(
                            child: Text(
                              snapshot.data,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  }),
            ],
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: InkWell(
            child: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onTap: widget.onMenuTap,
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Color(0xff0B3666).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(3.0, 2.0),
                        color: Colors.blue[100],
                        blurRadius: 2.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                  child: Container(
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: 200,
                                    child: Row(
                                      children: [
                                        Text(
                                          name,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Container(
                                    width: 200,
                                    child: Row(
                                      children: [
                                        Text(
                                          email,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(350),
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/user.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Container(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(3.0, 2.0),
                      color: Colors.grey[100],
                      blurRadius: 2.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: ListTile(
                  tileColor: Colors.white,
                  leading: Icon(Icons.pin_drop),
                  title: Text('Address'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  subtitle: FutureBuilder(
                      future: apiService.getShippingDetail(userId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          ShippingAddress address = snapshot.data;
                          return Text("${address.asd1}" +
                              "," +
                              "${address.city1}" +
                              "," +
                              "${address.pin1}" +
                              "," +
                              "${address.state1}");
                        } else {
                          return Text("");
                        }
                      }),
                ),
              ),
              SizedBox(
                height: 1,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyOrders()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(3.0, 2.0),
                        color: Colors.grey[300],
                        blurRadius: 2.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                  child: ListTile(
                    tileColor: Colors.white,
                    leading: Icon(Icons.history),
                    title: Text(getTranslated(context, "My_Orders")),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                ),
              ),
              SizedBox(
                height: 1,
              ),
              GestureDetector(
                onTap: () {
                  getLanguageTick();
                  showMaterialModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.translate,
                                  size: 18,
                                ),
                                Text(
                                  '  Choose Language',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            elevation: 0.5,
                            child: ListTile(
                              onTap: () {
                                Language lan = Language(1, 'English', 'en');
                                _changeLanguage(lan);
                              },
                              title: Text(
                                'English',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              trailing: english
                                  ? Icon(
                                      Icons.check_circle,
                                      color: Colors.blue,
                                    )
                                  : SizedBox(
                                      width: 10,
                                      height: 10,
                                    ),
                            ),
                          ),
                          Card(
                            elevation: 0.5,
                            borderOnForeground: true,
                            semanticContainer: true,
                            child: ListTile(
                              onTap: () {
                                Language lan = Language(2, 'Malayalam', 'ml');
                                _changeLanguage(lan);
                              },
                              title: Text(
                                'Malayalam',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              trailing: malayalam
                                  ? Icon(
                                      Icons.check_circle,
                                      color: Colors.blue,
                                    )
                                  : SizedBox(
                                      width: 10,
                                      height: 10,
                                    ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(3.0, 2.0),
                        color: Colors.grey[300],
                        blurRadius: 2.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                  child: ListTile(
                    tileColor: Colors.white,
                    leading: Icon(Icons.translate),
                    title: Text(getTranslated(context, "Language")),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(3.0, 2.0),
                      color: Colors.grey[300],
                      blurRadius: 2.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: ListTile(
                  tileColor: Colors.white,
                  leading: Icon(Icons.call),
                  title: Text(getTranslated(context, 'Customer_Support')),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(3.0, 2.0),
                      color: Colors.grey[300],
                      blurRadius: 2.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: ListTile(
                  tileColor: Colors.white,
                  leading: Icon(Icons.notifications),
                  title: Text(getTranslated(context, 'Notification')),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
              SizedBox(
                height: 1,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PasswordChange()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(3.0, 2.0),
                        color: Colors.grey[300],
                        blurRadius: 2.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                  child: ListTile(
                    tileColor: Colors.white,
                    leading: Icon(Icons.lock),
                    title: Text(getTranslated(context, 'Change_Password')),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                ),
              ),
              SizedBox(
                height: 1,
              ),
              GestureDetector(
                onTap: () {
                  logOut(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(3.0, 2.0),
                        color: Colors.grey[300],
                        blurRadius: 2.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                  child: ListTile(
                    tileColor: Colors.white,
                    leading: Icon(Icons.logout),
                    title: Text(getTranslated(context, 'Logout')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}
