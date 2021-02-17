import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/pages/ui/widget/home_crousal.dart';
import 'package:sanchika/pages/ui/widget/product_card.dart';

class Home extends StatefulWidget with NavigationStates {
  final Function onMenuTap;

  const Home({Key key, this.onMenuTap}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 125,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                children: <Widget>[
                  SizedBox(height: 90.0),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 16.0),
                    child: Container(
                      height: 45.0,
                      width: double.infinity,
                      child: CupertinoTextField(
                        keyboardType: TextInputType.text,
                        placeholder: 'Search',
                        placeholderStyle: TextStyle(
                          color: Color(0xffC4C6CC),
                          fontSize: 14.0,
                          fontFamily: 'Brutal',
                        ),
                        prefix: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
                          child: Icon(
                            Icons.search,
                            color: Color(0xffC4C6CC),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Color(0xffF0F1F5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pinned: true,
            floating: true,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                    height: 40,
                  ),
                )
              ],
            ),
            actions: [
              IconButton(
                padding: EdgeInsets.only(top: 8),
                icon: Icon(
                  Icons.shopping_cart,
                  size: 24,
                ),
              )
            ],
            leading: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: InkWell(
                child: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onTap: widget.onMenuTap,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              if (index > 1) return null;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    HomeCrousal(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Productcard(
                          product: product0,
                        ),
                        Productcard(product: product1),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Productcard(product: product2),
                        Productcard(product: product0),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Productcard(product: product0),
                        Productcard(product: product0),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
