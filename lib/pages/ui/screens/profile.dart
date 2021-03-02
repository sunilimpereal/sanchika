import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';
import 'package:sanchika/localization/localization_methods.dart';
import 'package:sanchika/main.dart';
import 'package:sanchika/model/language.dart';
import 'package:sanchika/pages/authentication/login_page.dart';
import 'package:sanchika/pages/ui/sub_screens/changePassword/password%20change.dart';
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
              color: Colors.grey[800],
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
                padding: EdgeInsets.only(top: 8),
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.grey[800],
                  size: 24,
                ),
                onPressed: () {
                  BlocProvider.of<NavigationBloc>(context)
                      .add(NavigationEvents.CartClickedEvent);
                  widget.onMenuItemClicked();
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 25),
                child: Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red,
                  ),
                  child: Center(
                    child: Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
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
                                          'Name',
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
                                          'email@gmail.com',
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
                                height: 89,
                                width: 89,
                                decoration: BoxDecoration(
                                  color: Colors.red,
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
                  subtitle: Text('3057 Creek Road,Madison,TN'),
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
                  leading: Icon(Icons.history),
                  title: Text(getTranslated(context, "My_Orders")),
                  trailing: Icon(Icons.keyboard_arrow_right),
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
                                Icon(Icons.translate),
                                Text(
                                  '  Choosse language',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
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
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
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
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
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
