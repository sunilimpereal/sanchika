import 'package:flutter/material.dart';
import 'package:otp_screen/otp_screen.dart';
import 'package:sanchika/model/signUp_model.dart';
import 'package:sanchika/pages/ui/widget/admin_wait.dart';
import 'package:sanchika/pages/ui/widget/check_address.dart';
import 'package:sanchika/services/api_service.dart';

class Otp extends StatefulWidget {
  RegisterRequestModel requestModel;
  String mobileNumber;
  String otp;
  Otp({this.otp, this.mobileNumber, this.requestModel});
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  Future<String> validateOtp(String otp) async {
    await Future.delayed(Duration(milliseconds: 2000));
    if (otp == widget.otp) {
      return null;
    } else {
      print(widget.otp);
      return "The entered Otp is wrong";
    }
  }

  void moveToNextScreen(context) {
    APIService apiService = APIService();
    apiService.register(widget.requestModel).then((value) {
      if (value != null) {
        setState(() {});
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminWait()),
        );
      } else {
        showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
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
        setState(() {});
      }
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CheckAddress()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OtpScreen(
          otpLength: 5,
          titleColor: Colors.black,
          themeColor: Colors.black,
          routeCallback: moveToNextScreen,
          validateOtp: validateOtp,
          subTitle: "please enter the OTP sent to\n ${widget.mobileNumber}",
        ),
      ),
    );
  }
}
