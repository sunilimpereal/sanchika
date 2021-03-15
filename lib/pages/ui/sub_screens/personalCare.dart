import 'package:flutter/material.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/pages/ui/widget/product_card.dart';

class PersonalCare extends StatefulWidget {
  @override
  _PersonalCareState createState() => _PersonalCareState();
}

class _PersonalCareState extends State<PersonalCare> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SafeArea(
              child: Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.filter_list),
              ),
            ],
            centerTitle: true,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            elevation: 0.5,
            backgroundColor: Colors.white,
            title: Text(
              'Personal Care',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(30.0),
              child: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.black.withOpacity(0.3),
                tabs: [
                  Tab(
                    child: Text(
                      'Oral care',
                      style: TextStyle(
                        color: Color(0xff0B3666),
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Personal Wash',
                      style: TextStyle(
                        color: Color(0xff0B3666),
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Skin Care',
                      style: TextStyle(
                        color: Color(0xff0B3666),
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Baby Care',
                      style: TextStyle(
                        color: Color(0xff0B3666),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              Breakfast(),
              Breakfast(),
              Breakfast(),
              Breakfast(),
            ],
          ),
        ),
      ),
    );
  }
}

class Breakfast extends StatefulWidget {
  @override
  _BreakfastState createState() => _BreakfastState();
}

class _BreakfastState extends State<Breakfast> {
  @override
  Widget build(BuildContext context) {
    // Product product0 = Product(
    //     name: 'Lays Classic',
    //     type: '200g',
    //     typeList: ['100g', '200g', '300g'],
    //     description:
    //         'Lay\'s is a brand of potato chip varieties, as well as the name of the company that founded the chip brand in the United States. It has also been called Frito-Lay with Fritos. Lay\'s has been owned by PepsiCo through Frito-Lay since 1965.',
    //     price: 120,
    //     price1: 125,
    //     discount: 5,
    //     ingredients:
    //         'Paneer or cottage cheese is prepared by curing and draining blanched milk. It is an excellent source of nutrients like protein and calcium. The Premium Fresh paneer from the stable of Milky Mist is free of preservatives and packed with freshness. It is prepared in hygienic industrial set ups where high standards of production are followed.',
    //     images: [
    //       'assets/images/lays.png',
    //       'assets/images/lays2.jpg',
    //     ]);
    // Product product1 = Product(
    //     name: 'Milky Mist Paneer',
    //     typeList: ['100g', '200g', '300g'],
    //     description:
    //         'Milky Mist is a brand that is known for its various dairy products. The pure and protein rich products are renowned for their high quality goodness. Paneer is a product which is also known as cottage cheese. This is a healthy dairy product that is produced and marketed by Milky Mist.',
    //     price: 599,
    //     ingredients:
    //         'Paneer or cottage cheese is prepared by curing and draining blanched milk. It is an excellent source of nutrients like protein and calcium. The Premium Fresh paneer from the stable of Milky Mist is free of preservatives and packed with freshness. It is prepared in hygienic industrial set ups where high standards of production are followed.',
    //     images: [
    //       'assets/images/milkymist1.png',
    //       'assets/images/milkymist2.png'
    //     ]);
    // Product product2 = Product(
    //     name: 'Philips Electronic Induction Stove',
    //     description:
    //         'Milky Mist is a brand that is known for its various dairy products. The pure and protein rich products are renowned for their high quality goodness. Paneer is a product which is also known as cottage cheese. This is a healthy dairy product that is produced and marketed by Milky Mist.',
    //     price: 1200,
    //     price1: 1500,
    //     discount: 30,
    //     ingredients: 'Paneer or cottage cheese is prepared by curing and draining blanched milk. It is an excellent source of nutrients like protein and calcium. The Premium Fresh paneer from the stable of Milky Mist is free of preservatives and packed with freshness. It is prepared in hygienic industrial set ups where high standards of production are followed.',
    //     images: ['assets/images/pan1.png', 'assets/images/pan2.jpeg']);
    // Product product3 = Product(
    //     name: 'Country Sweets',
    //     description:
    //         'Made from all natural ingredients, it\'s the perfect mix of sweet and tangy with just the right kick to bring any food to life. Not a traditional barbecue sauce, Country Sweet is the all-purpose flavor enhancer that has no boundaries. Add a delicious zest to chicken, pork, beef, seafood and even pizza.',
    //     price: 50,
    //     ingredients: 'First developed in a home kitchen in Rochester, New York, this sauce is unlike anything you’ve ever tried. Made from all natural ingredients, it’s the perfect mix of sweet and tangy with just the right kick to bring any food to life.',
    //     images: [
    //       'assets/images/countrysweet.png',
    //       'assets/images/countrysweet.png'
    //     ]);
    // Product product4 = Product(
    //     name: 'RICE',
    //     type: '1Kg',
    //     typeList: ['1Kg', '3Kg', '5Kg'],
    //     description:
    //         'Naturally aged for 12 months \nAffordable Authentic Basmati Rice Basmati for regular use \nGluten freeIdeal for dishes like Pulao, Jeera Rice, khichdi & steam rice\nCountry of Origin: India',
    //     price: 30,
    //     price1: 38,
    //     discount: 15,
    //     ingredients:
    //         'First developed in a home kitchen in Rochester, New York, this sauce is unlike anything you’ve ever tried. Made from all natural ingredients, it’s the perfect mix of sweet and tangy with just the right kick to bring any food to life.',
    //     images: ['assets/images/rice.png', 'assets/images/countrysweet.png']);
    // Product product5 = Product(
    //     name: 'Gold Winner',
    //     type: '1 L',
    //     typeList: ['1L', '2L', '3L'],
    //     description:
    //         'BLRs \nLight and healthy that is easy to digest \nRich in vitamins, which keeps skin healthy\nGood for the heart\nCountry of Origin: India\nGood for the heart',
    //     price: 30,
    //     price1: 38,
    //     discount: 15,
    //     ingredients:
    //         'First developed in a home kitchen in Rochester, New York, this sauce is unlike anything you’ve ever tried. Made from all natural ingredients, it’s the perfect mix of sweet and tangy with just the right kick to bring any food to life.',
    //     images: [
    //       'assets/images/goldwinner.png',
    //       'assets/images/countrysweet.png'
    //     ]);
   
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     ProductCard(product: product4),
            //     ProductCard(product: product3),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     ProductCard(product: product1),
            //     ProductCard(product: product2),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     ProductCard(product: product5),
            //     ProductCard(product: product0),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     ProductCard(product: product2),
            //     ProductCard(product: product0),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
