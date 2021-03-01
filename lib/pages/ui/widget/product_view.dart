import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/pages/ui/screens/cart.dart';
import 'package:sanchika/pages/ui/widget/crousal.dart';
import 'package:sanchika/pages/ui/widget/product_card.dart';
import 'package:sanchika/utils/numericStepButton.dart';
import 'package:readmore/readmore.dart';

class ProductView extends StatefulWidget {
  Product product;
  Function onMenuItemClicked;
  ProductView({this.product, this.onMenuItemClicked});
  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  Product product0 = Product(
      name: 'Lays Classic',
      type: '200g',
      typeList: ['100g', '200g', '300g'],
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
      ],
      relatedproducts: []);
  Product product1 = Product(
      name: 'Milky Mist Paneer',
      typeList: ['100g', '200g', '300g'],
      description:
          'Milky Mist is a brand that is known for its various dairy products. The pure and protein rich products are renowned for their high quality goodness. Paneer is a product which is also known as cottage cheese. This is a healthy dairy product that is produced and marketed by Milky Mist.',
      price: 599,
      ingredients:
          'Paneer or cottage cheese is prepared by curing and draining blanched milk. It is an excellent source of nutrients like protein and calcium. The Premium Fresh paneer from the stable of Milky Mist is free of preservatives and packed with freshness. It is prepared in hygienic industrial set ups where high standards of production are followed.',
      images: ['assets/images/milkymist1.png', 'assets/images/milkymist2.png']);
  Product product2 = Product(
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
      type: '1Kg',
      typeList: ['1Kg', '3Kg', '5Kg'],
      description:
          'Naturally aged for 12 months \nAffordable Authentic Basmati Rice Basmati for regular use \nGluten freeIdeal for dishes like Pulao, Jeera Rice, khichdi & steam rice\nCountry of Origin: India',
      price: 30,
      price1: 38,
      discount: 15,
      ingredients:
          'First developed in a home kitchen in Rochester, New York, this sauce is unlike anything you’ve ever tried. Made from all natural ingredients, it’s the perfect mix of sweet and tangy with just the right kick to bring any food to life.',
      images: ['assets/images/rice.png', 'assets/images/countrysweet.png']);
  Product product5 = Product(
      name: 'Gold Winner',
      type: '1 L',
      typeList: ['1L', '2L', '3L'],
      description:
          'BLRs \nLight and healthy that is easy to digest \nRich in vitamins, which keeps skin healthy\nGood for the heart\nCountry of Origin: India\nGood for the heart',
      price: 30,
      price1: 38,
      discount: 15,
      ingredients:
          'First developed in a home kitchen in Rochester, New York, this sauce is unlike anything you’ve ever tried. Made from all natural ingredients, it’s the perfect mix of sweet and tangy with just the right kick to bring any food to life.',
      images: [
        'assets/images/goldwinner.png',
        'assets/images/countrysweet.png'
      ]);

  String _selectedValue;
  void initState() {
    setState(() {
      _selectedValue =
          widget.product.typeList == null ? '' : widget.product.typeList[0];
    });

    super.initState();
  }

  int count;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left_rounded,
            size: 35,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.product.name,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                  padding: EdgeInsets.only(top: 8),
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.grey[800],
                    size: 24,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Cart()),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 25),
                child: Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red,
                  ),
                  child: Center(
                    child: Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  //image of product

                  Container(
                    padding: EdgeInsets.only(top: 0, bottom: 102),
                    height: MediaQuery.of(context).size.height * 0.5 + 32,
                    width: double.infinity,
                    color: Colors.white,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Hero(
                        tag: 'image' + widget.product.name,
                        child: Crousal(
                          photos: widget.product.images,
                        ),
                      ),
                    ),
                  ),

                  //Description Part
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.40),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(3.0, 2.0),
                            color: Colors.grey[400],
                            blurRadius: 3.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            //Name Row
                            Padding(
                              padding: EdgeInsets.all(4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Text(
                                      widget.product.name,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                          fontFamily: 'Poppins'),
                                    ),
                                  ),
                                  Container(
                                    child: FavoriteButton(
                                      iconSize: 38,
                                      valueChanged: (_) {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green[400],
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Row(
                                      children: [
                                        Text(
                                          ' ${widget.product.discount}% Off ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),

                            //Price Row
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Row(
                                    children: [
                                      Text(
                                        '₹ ${widget.product.price}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 26,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                price1(widget.product.price1),
                              ],
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Qty  ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 10),
                                      dropdown(),
                                    ],
                                  ),
                                  Container(
                                    child: NumericStepButton(
                                      maxValue: 20,
                                      onChanged: (value) {
                                        setState(() {
                                          count = value;
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),

                            Container(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 16.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Description",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: ReadMoreText(
                                      widget.product.description,
                                      trimLines: 3,
                                      trimMode: TrimMode.Line,
                                      trimCollapsedText: 'more',
                                      trimExpandedText: 'less',
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Open Sans',
                                          fontSize: 16),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 16.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Ingredients",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: ReadMoreText(
                                      widget.product.ingredients,
                                      trimLines: 3,
                                      trimMode: TrimMode.Line,
                                      trimCollapsedText: 'more',
                                      trimExpandedText: 'less',
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Open Sans',
                                          fontSize: 16),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 16.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Info",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: ReadMoreText(
                                      'EAN Code: 8904083300021 \nCountry Of Origin: India Manufactured & Marketed by: Milky Mist Dairy Foods Private Limited Best before 15-01-2021 For Queries/Feedback/Complaints, Contact our Customer Care Executive at: Phone: 1860 123 1000 | Address: Innovative Retail Concepts Private Limited, Ranka Junction 4th Floor, Tin Factory bus stop. KR Puram, Bangalore - 560016 Email:customerservice@sanchika.com',
                                      trimLines: 3,
                                      trimMode: TrimMode.Line,
                                      trimCollapsedText: 'more',
                                      trimExpandedText: 'less',
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Open Sans',
                                          fontSize: 16),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            Divider(
                              thickness: 1.0,
                            ),
                            Container(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 016.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Rating & Review",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            _review(),
                            SizedBox(
                              height: 10,
                            ),
                            _comment(
                                name: 'Elyn Y.',
                                review:
                                    'Farmart is great. Farmart is the most valuable business resource we have EVER purchased. I have gotten at least 50 times the value from Farmart. I just can\'t get enough of Farmart. I want to get a T-Shirt with Farmart on it so I can show it off to everyone.',
                                date: 'June 14 , 2020',
                                stars: 5),
                            _comment(
                                name: 'Rick E',
                                review:
                                    'Farmart is great. Farmart is the most valuable business resource we have EVER purchased. I have gotten at least 50 times the value from Farmart. I just can\'t get enough of Farmart. I want to get a T-Shirt with Farmart on it so I can show it off to everyone.',
                                date: 'June 14 , 2020',
                                stars: 4),
                            _comment(
                                name: 'Timmi Y.',
                                review:
                                    'Farmart is great. Farmart is the most valuable business resource we have EVER purchased. I have gotten at least 50 times the value from Farmart. I just can\'t get enough of Farmart. I want to get a T-Shirt with Farmart on it so I can show it off to everyone.',
                                date: 'June 14 , 2020',
                                stars: 2),

                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 016.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Related products",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            Container(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    (() {
                                      if (widget.product.name !=
                                          product0.name) {
                                        return Productcard(
                                          product: product0,
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }()),
                                    (() {
                                      if (widget.product.name !=
                                          product1.name) {
                                        return Productcard(
                                          product: product1,
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }()),
                                    (() {
                                      if (widget.product.name !=
                                          product2.name) {
                                        return Productcard(
                                          product: product2,
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }()),
                                    (() {
                                      if (widget.product.name !=
                                          product3.name) {
                                        return Productcard(
                                          product: product3,
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }()),
                                    (() {
                                      if (widget.product.name !=
                                          product4.name) {
                                        return Productcard(
                                          product: product4,
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }()),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 60,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        heroTag: null,
        backgroundColor: Color(0xff0B3666),
        onPressed: () {},
        label: Padding(
          padding: EdgeInsets.all(80),
          child: Text("Add to cart"),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
      ),
    );
  }

//select type(dropdown)
  Container dropdown() {
    if (widget.product.type == null || widget.product.typeList == null) {
      return Container();
    } else {
      return Container(
        child: Center(
          child: DropdownButton<String>(
            value: _selectedValue,
            items: widget.product.typeList.map((String value) {
              return new DropdownMenuItem(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _selectedValue = newValue;
              });
            },
            dropdownColor: Colors.grey[200],
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
      );
    }
  }

  //scrached price
  Text price1(int price1) {
    if (price1 != null) {
      return Text(
        '₹${widget.product.price1}',
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

  //Review numbers
  Widget _review() {
    Widget lines(int length, int star) {
      return Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          width: 230,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('$star star'),
              SizedBox(
                width: 3,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey[300],
                ),
                height: 7,
                width: 150,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.blue[300],
                      ),
                      width: 150 * (length / 100),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Text('$length %')
            ],
          ),
        ),
      );
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.18,
      color: Colors.transparent,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0, left: 8.0),
            child: Container(
              child: Column(
                children: [
                  Text(
                    '4.1',
                    style: TextStyle(
                      fontSize: 45,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 18,
                        color: Colors.amber,
                      ),
                      Icon(
                        Icons.star,
                        size: 18,
                        color: Colors.amber,
                      ),
                      Icon(
                        Icons.star,
                        size: 18,
                        color: Colors.amber,
                      ),
                      Icon(
                        Icons.star,
                        size: 18,
                        color: Colors.amber,
                      ),
                      Icon(
                        Icons.star,
                        size: 18,
                        color: Colors.grey,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                lines(80, 5),
                lines(20, 4),
                lines(0, 3),
                lines(0, 2),
                lines(0, 1)
              ],
            ),
          ),
        ],
      ),
    );
  }

//comments
  Widget _comment({String name, String review, String date, int stars}) {
    final starsicon = <Widget>[];
    Widget _starfill() {
      return Icon(
        Icons.star,
        size: 15,
        color: Colors.amber,
      );
    }

    Widget _starnotfill() {
      return Icon(
        Icons.star,
        size: 15,
        color: Colors.grey,
      );
    }

    for (var i = 0; i < stars; i++) {
      starsicon.add(_starfill());
    }
    for (var i = 0; i < (5 - stars); i++) {
      starsicon.add(_starnotfill());
    }
    return Container(
      width: double.maxFinite,
      color: Colors.transparent,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                color: Colors.transparent,
                width: 100,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          date,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    children: starsicon,
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              )
            ],
          ),
          Container(
            child: ReadMoreText(
              review,
              trimLines: 2,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'more',
              trimExpandedText: 'less',
            ),
          ),
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
