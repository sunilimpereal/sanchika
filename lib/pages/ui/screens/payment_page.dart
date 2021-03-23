import 'package:flutter/material.dart';
import 'package:sanchika/pages/ui/screens/order_placed.dart';

enum Payments { cod, card, upi }

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Payments _payment = Payments.cod;
  @override
  Widget build(BuildContext context) {
    String payment;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Payment',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            progressBar(),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Payment  Method',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text(
                'Cash On Delivery',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins'),
              ),
              trailing: Radio<Payments>(
                  value: Payments.cod,
                  groupValue: _payment,
                  onChanged: (Payments value) {
                    setState(() {
                      _payment = value;
                    });
                  }),
            ),
            ListTile(
              title: Text(
                'Card',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins'),
              ),
              trailing: Radio<Payments>(
                  value: Payments.card,
                  groupValue: _payment,
                  onChanged: (Payments value) {
                    setState(() {
                      _payment = value;
                    });
                  }),
            ),
            ListTile(
              title: Text(
                'UPI',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins'),
              ),
              trailing: Radio<Payments>(
                  value: Payments.upi,
                  groupValue: _payment,
                  onChanged: (Payments value) {
                    setState(() {
                      _payment = value;
                    });
                  }),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Orderplaced()),
            );
          },
          child: Container(
            width: 250,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xff032e6b),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Place Order',
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
                  color: Color(0xff032e6b).withOpacity(0.2),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            )
          ],
        ));
  }
}
