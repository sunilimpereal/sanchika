import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/pages/ui/widget/cart_card.dart';
import 'package:sanchika/pages/ui/widget/checkout.dart';

class Cart extends StatefulWidget with NavigationStates {
  final Function onMenuTap;
  final Function onMenuItemClicked;

  const Cart({Key key, this.onMenuTap, this.onMenuItemClicked})
      : super(key: key);
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  Product product0 = Product(
      name: 'Lays Classic',
      type: '200g',
      description:
          'Lay\'s is a brand of potato chip varieties, as well as the name of the company that founded the chip brand in the United States. It has also been called Frito-Lay with Fritos. Lay\'s has been owned by PepsiCo through Frito-Lay since 1965.',
      price: 120,
      price1: 125,
      discount: 5,
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
      price: 599,
      ingredients: 'Paneer or cottage cheese is prepared by curing and draining blanched milk. It is an excellent source of nutrients like protein and calcium. The Premium Fresh paneer from the stable of Milky Mist is free of preservatives and packed with freshness. It is prepared in hygienic industrial set ups where high standards of production are followed.',
      images: ['assets/images/milkymist1.png', 'assets/images/milkymist2.png']);
  Product product2 = Product(
      type: '',
      name: 'Philips Electronic Induction Stove',
      description:
          'Milky Mist is a brand that is known for its various dairy products. The pure and protein rich products are renowned for their high quality goodness. Paneer is a product which is also known as cottage cheese. This is a healthy dairy product that is produced and marketed by Milky Mist.',
      price: 1200,
      price1: 1500,
      discount: 30,
      ingredients: 'Paneer or cottage cheese is prepared by curing and draining blanched milk. It is an excellent source of nutrients like protein and calcium. The Premium Fresh paneer from the stable of Milky Mist is free of preservatives and packed with freshness. It is prepared in hygienic industrial set ups where high standards of production are followed.',
      images: ['assets/images/pan1.png', 'assets/images/pan2.jpeg']);
  Product product3 = Product(
      name: 'Country Sweets',
      description:
          'Made from all natural ingredients, it\'s the perfect mix of sweet and tangy with just the right kick to bring any food to life. Not a traditional barbecue sauce, Country Sweet is the all-purpose flavor enhancer that has no boundaries. Add a delicious zest to chicken, pork, beef, seafood and even pizza.',
      price: 50,
      ingredients: 'First developed in a home kitchen in Rochester, New York, this sauce is unlike anything you’ve ever tried. Made from all natural ingredients, it’s the perfect mix of sweet and tangy with just the right kick to bring any food to life.',
      images: [
        'assets/images/countrysweet.png',
        'assets/images/countrysweet.png'
      ]);
  Product product4 = Product(
      name: 'RICE',
      description:
          'Naturally aged for 12 months \nAffordable Authentic Basmati Rice Basmati for regular use \nGluten freeIdeal for dishes like Pulao, Jeera Rice, khichdi & steam rice\nCountry of Origin: India',
      price: 30,
      price1: 38,
      discount: 15,
      ingredients: 'First developed in a home kitchen in Rochester, New York, this sauce is unlike anything you’ve ever tried. Made from all natural ingredients, it’s the perfect mix of sweet and tangy with just the right kick to bring any food to life.',
      images: ['assets/images/rice.png', 'assets/images/countrysweet.png']);
  Product product5 = Product(
      name: 'Gold Winner',
      description:
          'BLRs \nLight and healthy that is easy to digest \nRich in vitamins, which keeps skin healthy\nGood for the heart\nCountry of Origin: India\nGood for the heart',
      price: 30,
      price1: 38,
      discount: 15,
      ingredients: 'First developed in a home kitchen in Rochester, New York, this sauce is unlike anything you’ve ever tried. Made from all natural ingredients, it’s the perfect mix of sweet and tangy with just the right kick to bring any food to life.',
      images: [
        'assets/images/goldwinner.png',
        'assets/images/countrysweet.png'
      ]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: leading(),
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
          IconButton(
            padding: EdgeInsets.only(top: 8),
            icon: Icon(
              Icons.favorite_rounded,
              color: Colors.grey[500],
              size: 24,
            ),
            onPressed: () {
              BlocProvider.of<NavigationBloc>(context)
                  .add(NavigationEvents.WishlistClickedEvent);
              widget.onMenuItemClicked();
            },
          ),
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
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckoutPage()),
                );
              },
              child: Padding(
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
              ),
            )
          ],
        ),
      ),
    );
  }

  InkWell leading() {
    if (widget.onMenuTap == null) {
      return InkWell(
        child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
        onTap: () {
          Navigator.pop(context);
        },
      );
    }
    return InkWell(
      child: Icon(Icons.menu, color: Colors.black),
      onTap: widget.onMenuTap,
    );
  }
}
