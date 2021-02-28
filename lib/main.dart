import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sanchika/menu_dashboard/menu_dashboard.dart';
import 'package:sanchika/pages/authentication/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var logged = preferences.getString('login');
  runApp(MyApp(logged: logged));
}

class MyApp extends StatelessWidget {
  String logged;
  MyApp({this.logged});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: logged == null ? LoginPage() : MenuDashboard(),
    );
  }
}
