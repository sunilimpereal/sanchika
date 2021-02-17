import 'package:flutter/material.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/utils/numericStepButton.dart';

class CartCard extends StatefulWidget {
  final Product product;
  CartCard({this.product});
  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(),
            Container(
              height: MediaQuery.of(context).size.height * 0.156,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
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
                          image: AssetImage(
                            widget.product.images[0],
                          ),
                          fit: BoxFit.contain,
                        )),
                      ),
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: Text(
                                      widget.product.name,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "₹${widget.product.price}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
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
                                      icon: Icon(Icons.delete),
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
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Divider(
            thickness: 1,
          ),
        )
      ],
    );
  }
}
