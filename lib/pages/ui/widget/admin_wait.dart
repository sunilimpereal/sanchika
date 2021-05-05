import 'package:flutter/material.dart';
import 'package:sanchika/menu_dashboard/menu_dashboard.dart';
import 'package:sanchika/model/login_model.dart';
import 'package:sanchika/pages/authentication/login_page.dart';

class AdminWait extends StatefulWidget {
  @override
  _AdminWaitState createState() => _AdminWaitState();
}

class _AdminWaitState extends State<AdminWait> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width - 30,
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/wait1.png'),
                        fit: BoxFit.cover)),
              ),
            ),
            SizedBox(height:10),
             Text(
              'Thank You For Signing Up',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 28),
            ),
            SizedBox(height:20),
            Text(
              'Hang on for Admin approval',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'we\'ll notify you once Admin approves',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontSize: 18),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 120,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                        Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage(
                                      )),
                            );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.keyboard_arrow_left),
                      Text('login  ',style: TextStyle(
                        fontSize: 18
                      ),),
                    ],
                  )),
            )
            // ignore: deprecated_member_use
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => MenuDashboard()),
            //     );
            //   },
            //   child: Text(
            //     'Home(for now)',
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //         color: Colors.black,
            //         fontWeight: FontWeight.normal,
            //         fontSize: 18),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
