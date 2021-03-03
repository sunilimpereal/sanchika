import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sanchika/localization/localization.dart';
import 'package:sanchika/menu_dashboard/menu_dashboard.dart';
import 'package:sanchika/pages/authentication/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setStringList('recentSearch', []); //for recent search in search
  var logged = preferences.getString('login');

  runApp(MyApp(logged: logged));
}

class MyApp extends StatefulWidget {
  String logged;
  MyApp({this.logged});
  //Change Language
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  void initState() {
    super.initState();
    checkLanguage();
  }

  void checkLanguage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var language = preferences.getString('language');
    if (language == 'malayalam') {
      setState(() {
        _locale = Locale('ml', 'IN');
      });
    }
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      locale: _locale,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ml', 'IN'),
      ],
      localizationsDelegates: [
        DemoLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (locale.languageCode == deviceLocale.languageCode &&
              locale.countryCode == deviceLocale.countryCode) {
            return deviceLocale;
          }
        }
        return supportedLocales.first;
      },
      home: widget.logged == null ? LoginPage() : MenuDashboard(),
    );
  }
}
