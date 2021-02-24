import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/pages/ui/screens/cart.dart';
import 'package:sanchika/pages/ui/widget/crousal.dart';
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
                      child: Crousal(
                        photos: widget.product.images,
                      ),
                    ),
                  ),

                  //Description Part
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.40),
                    child: Container(
                      padding: EdgeInsets.all(24),
                      height: MediaQuery.of(context).size.height,
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
                      child: Column(
                        children: [
                          //Name Row
                          Padding(
                            padding: EdgeInsets.all(4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          )
                        ],
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
}
