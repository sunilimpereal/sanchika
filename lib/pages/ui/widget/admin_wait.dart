import 'package:flutter/material.dart';
import 'package:sanchika/menu_dashboard/menu_dashboard.dart';

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
            Container(
              width: 550,
              height: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/wait1.png'),
                      fit: BoxFit.cover)),
            ),
            Text(
              'Hang on for admin approval',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 35),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'we\'ll notify you once admin approves',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontSize: 18),
            ),
            SizedBox(
              height: 20,
            ),

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
