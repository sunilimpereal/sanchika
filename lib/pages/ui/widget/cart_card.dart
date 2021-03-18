import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/services/api_service.dart';
import 'package:sanchika/utils/numericStepButton.dart';

class CartCard extends StatefulWidget {
  final String productId;
  CartCard({this.productId});
  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
   Future<Product> getProductDetail()async {
    APIService apiService = APIService();
    List<Product> product = await apiService.getProductDetail(productId: widget.productId);
    return product[0];

  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getProductDetail(),
      builder: (context,snapshot){
        if(snapshot.hasData){
            return _cartCardUi(context, snapshot.data);
        }else{
        const spinkit = SpinKitDoubleBounce(
              color:  Color(0xff032e6b),
              size: 50.0,
            );
            return Center(child:spinkit);
        }

      },
    );
  }

  @override
  Widget _cartCardUi(BuildContext context,Product product) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        width: 1,
        color: Colors.grey[100],
      ))),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(),
              Container(
                height: MediaQuery.of(context).size.height * 0.156 + 10,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.26,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: NetworkImage(
                                  product.productImage,
                                ),
                                fit: BoxFit.contain,
                              )),
                            ),
                          ),
                          discount(int.parse(product.slPrice)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(0),
                              width: MediaQuery.of(context).size.width * 0.65,
                              height: 50,
                              color: Colors.white,
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: Text(
                                        product.productName,
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset(3.0, 2.0),
                                            color: Colors.grey[200],
                                            blurRadius: 3.0,
                                            spreadRadius: 2.0,
                                          ),
                                        ],
                                      ),
                                      child: NumericStepButton(
                                        minValue: 1,
                                        maxValue: 20,
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: EdgeInsets.all(0),
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 45,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "₹${product.slPrice}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      price1(int.parse(product.mrpPrice)),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset(3.0, 2.0),
                                            color: Colors.grey[200],
                                            blurRadius: 3.0,
                                            spreadRadius: 2.0,
                                          ),
                                        ],
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red[400],
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  //scrached price
  Text price1(int price1) {
    if (price1 != null) {
      return Text(
        '₹$price1',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.normal,
          decoration: TextDecoration.lineThrough,
        ),
      );
    } else {
      return Text('');
    }
  }

  discount(int discount) {
    if (true) {
      return Positioned(
        top: 1,
        left: 1,
        child: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(5),
                topLeft: Radius.circular(15),
                bottomRight: Radius.circular(10)),
            color: Colors.green[300],
          ),
          child: Text(
            '$discount% Off',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
