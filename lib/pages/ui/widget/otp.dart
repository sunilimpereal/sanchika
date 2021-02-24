import 'package:flutter/material.dart';
import 'package:otp_screen/otp_screen.dart';
import 'package:sanchika/menu_dashboard/menu_dashboard.dart';
import 'package:sanchika/pages/ui/widget/check_address.dart';

class Otp extends StatefulWidget {
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  Future<String> validateOtp(String otp) async {
    await Future.delayed(Duration(milliseconds: 2000));
    if (otp == "1234") {
      return null;
    } else {
      return "The entered Otp is wrong";
    }
  }

  void moveToNextScreen(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CheckAddress()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OtpScreen(
          otpLength: 4,
          titleColor: Colors.black,
          themeColor: Colors.black,
          routeCallback: moveToNextScreen,
          validateOtp: validateOtp,
        ),
      ),
    );
  }
}
