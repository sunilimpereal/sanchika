import 'package:flutter/material.dart';

class PasswordChange extends StatefulWidget {
  @override
  _PasswordChangeState createState() => _PasswordChangeState();
}

class _PasswordChangeState extends State<PasswordChange> {
  bool _obscureText = false;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    String password;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Text('Enter Your old Password'),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 50,
                child: TextFormField(
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
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      password = val;
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
            ),
          ],
        ),
      ),
    );
  }
}
