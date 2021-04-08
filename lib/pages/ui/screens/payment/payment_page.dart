import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sanchika/model/myInformation.dart';
import 'package:sanchika/pages/ui/screens/order_placed.dart';
import 'package:sanchika/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

enum Payments { cod, payNow }

class Payment extends StatefulWidget {
  double totalAmount;
  Payment({this.totalAmount});
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  APIService apiService;
  Razorpay razorpay;
  Payments _payment = Payments.cod;
  String userId;
  Future<String> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String uid = preferences.getString('userId');
    setState(() {
      userId = uid;
    });
  }

  MyInformationClass myInformation;

  void getInformation(String userId) async {
    MyInformationClass myInformations =
        await apiService.getuserInformation(userId);
    setState(() {
      myInformation = myInformations;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserId().then((value) {
      getInformation(value);
    });
    apiService = APIService();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerpaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handleErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  void handlerpaymentSuccess(PaymentSuccessResponse response) {
    print('payment suxxessful');
    Toast.show("${response.paymentId}", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Orderplaced()),
    );
  }

  void handleErrorFailure(PaymentFailureResponse response) {
   Toast.show(
         "ERROR: " + response.code.toString() + " - " + response.message,context,
          duration: Toast.LENGTH_LONG);
  }

  void handleExternalWallet() {
    print('external wallet');
  }

  void openCheckout() {
    int amount = widget.totalAmount.round().toInt();
    print("amount ${widget.totalAmount.round()}");
    var options = {
      "key": "rzp_test_qOyccsKnU5LoUi",

      "amount": amount*100 ,
      "name": "sanchika",
      "description": "Payment for grocery",
      "external": {
        "wallets": ["paytm"]
      },
      "image":"https://www.wondersmind.com/design/sanchika/img/logo.png"
    };
    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.totalAmount);
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
                'Pay Now',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins'),
              ),
              trailing: Radio<Payments>(
                  value: Payments.payNow,
                  groupValue: _payment,
                  onChanged: (Payments value) {
                    setState(() {
                      _payment = value;
                    });
                  }),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GestureDetector(
          onTap: () {
            if (_payment == Payments.cod) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Orderplaced()),
              );
            } else {
              openCheckout();
            }
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

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
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
