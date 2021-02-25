import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:sanchika/pages/authentication/login_page.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                child: Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.maxFinite,
                child: Text(
                  'Enter your email associated with your account and we\'ll send an email with instructions to reset your password.',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  'Email address',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  child: TextField(
                      decoration: InputDecoration(
                          labelText: 'Email', border: OutlineInputBorder())),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                  ),
                  width: double.maxFinite,
                  height: 50,
                  child: RaisedButton(
                    color: Color(0xff032E6B),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(color: Colors.grey[400])),
                    elevation: 10,
                    child: Text(
                      'Send  Instructions',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CheckMail()),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CheckMail extends StatefulWidget {
  @override
  _CheckMailState createState() => _CheckMailState();
}

class _CheckMailState extends State<CheckMail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 200,
          ),
          Container(
            height: 100,
            width: 2000,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/emailicon.png'))),
          ),
          Text(
            'Check Your mail',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'We have sent a password reset instructions to your email.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
              ),
              width: double.maxFinite,
              height: 50,
              child: RaisedButton(
                color: Color(0xff032E6B),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: Colors.grey[400])),
                elevation: 10,
                child: Text(
                  'Open Email',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewPassword()),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              'Skip',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NewPassword extends StatefulWidget {
  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  bool _obscureText = false;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              child: Text(
                'Create new password',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.maxFinite,
              child: Text(
                'Your new password must be different\nfrom previous used passowrds.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.grey[500],
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                height: 50,
                child: TextField(
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              !_obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _toggle();
                              });
                            }),
                        labelText: 'Password',
                        border: OutlineInputBorder())),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  'Must be at least 8 characters',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                height: 50,
                child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder())),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  'Both passwords must match',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                ),
                width: double.maxFinite,
                height: 50,
                child: RaisedButton(
                  color: Color(0xff032E6B),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(color: Colors.grey[400])),
                  elevation: 10,
                  child: Text(
                    'Reset Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
