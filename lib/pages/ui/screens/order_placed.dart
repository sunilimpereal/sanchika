import 'package:flutter/material.dart';
import 'package:sanchika/menu_dashboard/menu_dashboard.dart';
class Orderplaced extends StatefulWidget {
  @override
  _OrderplacedState createState() => _OrderplacedState();
}

class _OrderplacedState extends State<Orderplaced> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Order Placed',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            progressBar(),
            SizedBox(height:50),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/order.jpg')
                )
              ),
            ),
            SizedBox(
              height:30
            ),
            Container(
              width:MediaQuery.of(context).size.width,
              height: 200,
              child: Column(
                children: [
                  Text('Order Placed',style: TextStyle(
                    fontSize: 22,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'poppins',

                  ),),
                  Text('Expexted delivery in 2 days',style: TextStyle(
                    fontSize: 22,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'poppins',

                  ),)
                ],
              ),
            )
        
       
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GestureDetector(
          onTap: (){
               Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MenuDashboard()),
            );
          },
                  child: Container(
            width: 250,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:Color(0xff032e6b),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget progressBar() {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 5,
              width: MediaQuery.of(context).size.width * 0.32,
              decoration: BoxDecoration(
                  color: Color(0xff032e6b),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
            Container(
              height: 5,
              width: MediaQuery.of(context).size.width * 0.32,
              decoration: BoxDecoration(
                  color: Color(0xff032e6b),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
            Container(
              height: 5,
              width: MediaQuery.of(context).size.width * 0.32,
              decoration: BoxDecoration(
                  color: Color(0xff032e6b),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            )
          ],
        ));
  }
}