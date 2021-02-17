import 'package:flutter/material.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/pages/ui/widget/crousal.dart';
import 'package:sanchika/pages/ui/widget/product_view.dart';

class Productcard extends StatelessWidget {
  Product product;
  Productcard({this.product});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductView(
                    product: product,
                  )),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(8.0),
          height: MediaQuery.of(context).size.height * .30,
          width: MediaQuery.of(context).size.width * 0.45,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .28 * 0.62,
                width: MediaQuery.of(context).size.width * 0.45,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, bottom: 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                          image: AssetImage(product.images[0]),
                          fit: BoxFit.contain),
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    color: Colors.grey[100],
                    child: Container(
                      child: Column(
                        children: [
                          Text(
                            product.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "200g",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '₹${product.price}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Row(
                                  children: [
                                    Text(
                                      "  ADD  + ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
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
