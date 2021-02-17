import 'package:flutter/material.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/pages/ui/widget/cart_card.dart';

class Cart extends StatefulWidget with NavigationStates {
  final Function onMenuTap;

  const Cart({Key key, this.onMenuTap}) : super(key: key);
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  Product product0 = Product(
      name: 'Lays Classic',
      description:
          'Lay\'s is a brand of potato chip varieties, as well as the name of the company that founded the chip brand in the United States. It has also been called Frito-Lay with Fritos. Lay\'s has been owned by PepsiCo through Frito-Lay since 1965.',
      price: 120,
      ingredients:
          'Paneer or cottage cheese is prepared by curing and draining blanched milk. It is an excellent source of nutrients like protein and calcium. The Premium Fresh paneer from the stable of Milky Mist is free of preservatives and packed with freshness. It is prepared in hygienic industrial set ups where high standards of production are followed.',
      images: [
        'assets/images/lays.png',
        'assets/images/lays2.jpg',
      ]);
  Product product1 = Product(
      name: 'Milky Mist Paneer',
      description:
          'Milky Mist is a brand that is known for its various dairy products. The pure and protein rich products are renowned for their high quality goodness. Paneer is a product which is also known as cottage cheese. This is a healthy dairy product that is produced and marketed by Milky Mist.',
      price: 120,
      ingredients: 'Paneer or cottage cheese is prepared by curing and draining blanched milk. It is an excellent source of nutrients like protein and calcium. The Premium Fresh paneer from the stable of Milky Mist is free of preservatives and packed with freshness. It is prepared in hygienic industrial set ups where high standards of production are followed.',
      images: ['assets/images/milkymist1.png', 'assets/images/milkymist2.png']);
  Product product2 = Product(
      name: 'PHILIES ELECTRONIC INDUCTION FOR KITCHEN',
      description:
          'Milky Mist is a brand that is known for its various dairy products. The pure and protein rich products are renowned for their high quality goodness. Paneer is a product which is also known as cottage cheese. This is a healthy dairy product that is produced and marketed by Milky Mist.',
      price: 120,
      ingredients: 'Paneer or cottage cheese is prepared by curing and draining blanched milk. It is an excellent source of nutrients like protein and calcium. The Premium Fresh paneer from the stable of Milky Mist is free of preservatives and packed with freshness. It is prepared in hygienic industrial set ups where high standards of production are followed.',
      images: ['assets/images/pan1.png', 'assets/images/pan2.jpeg']);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          child: Icon(Icons.menu, color: Colors.black),
          onTap: widget.onMenuTap,
        ),
        elevation: 0,
        title: Column(
          children: [
            Text(
              "Your Cart",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins'),
            ),
            SizedBox(height: 4),
            Text(
              "4 items",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w300,
                fontSize: 12,
              ),
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {},
            ),
          )
        ],
      ),
      body: Column(
        children: [
          CartCard(
            product: product0,
          ),
          CartCard(
            product: product1,
          ),
          CartCard(
            product: product2,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(3.0, 2.0),
              color: Colors.grey[400],
              blurRadius: 3.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        height: 55,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4.0, bottom: 3, top: 3),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.35,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    "₹390",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0.0, bottom: 3, top: 3),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.55,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff0b3666),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(3.0, 2.0),
                      color: Colors.grey[200],
                      blurRadius: 3.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white70,
                        ),
                      ),
                      Text(
                        'Checkout',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
