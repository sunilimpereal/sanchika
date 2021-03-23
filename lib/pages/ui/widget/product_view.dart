import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';
import 'package:sanchika/model/addToCart_model.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/model/wishlist_model.dart';
import 'package:sanchika/pages/ui/screens/cart.dart';
import 'package:sanchika/pages/ui/widget/crousal.dart';
import 'package:sanchika/pages/ui/widget/product_card.dart';
import 'package:sanchika/services/api_service.dart';
import 'package:sanchika/utils/numericStepButton.dart';
import 'package:readmore/readmore.dart';

class ProductView extends StatefulWidget {
  Product product;
  bool inWishlist;
  String userId;
  Function onMenuItemClicked;
  ProductView(
      {this.product, this.inWishlist, this.userId, this.onMenuItemClicked});
  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  AddtocartRequest addtocartRequest;
  int qty =1;

  String _selectedValue;
  void initState() {
    setState(() {
      // _selectedValue =
      //     widget.product.typeList == null ? '' : widget.product.typeList[0];
    });

    super.initState();
  }

  int count;
  ButtonState stateTextWithIcon = ButtonState.idle;
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
          titleSpacing: 0,
          
          title: Text(
            widget.product.productName,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.normal,
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
                          tag: 'image' + widget.product.productName,
                          child: Crousal(
                            photos: [widget.product.productImage],
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
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: Text(
                                        widget.product.productName,
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
                                        isFavorite: widget.inWishlist,
                                        iconSize: 38,
                                        valueChanged: (value) {
                                          if (!widget.inWishlist) {
                                            AddWishlistRequest
                                                addWishlistRequest =
                                                AddWishlistRequest();
                                            addWishlistRequest.userId =
                                                int.parse(widget.userId);
                                            addWishlistRequest.productId =
                                                widget.product.productId;
                                            APIService apiService =
                                                new APIService();
                                            apiService
                                                .addToWishlist(
                                                    addWishlistRequest)
                                                .then((value) {
                                              if (value == true) {
                                                setState(() {
                                                  widget.inWishlist = true;
                                                });
                                              }
                                            });
                                          } else {}
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              discount(
                                  mrp: double.parse(widget.product.mrpPrice),
                                  slp: double.parse(widget.product.slPrice)),

                              //Price Row
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Row(
                                      children: [
                                        Text(
                                          '₹ ${widget.product.slPrice}',
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
                                  price1(double.parse(widget.product.mrpPrice)),
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
                                        // dropdown(),
                                      ],
                                    ),
                                    Container(
                                      child: NumericStepButton(
                                        maxValue: 20,
                                        onChanged: (value) {
                                          setState(() {
                                           qty =value;
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
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Padding(
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
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: ReadMoreText(
                                        widget.product.productDescription,
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
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: ReadMoreText(
                                        widget.product.productDescription,
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
        floatingActionButton: Container(
          height: 50,
          width: 250,
          child: ProgressButton.icon(
            progressIndicatorSize: 28.0,
            iconedButtons: {
              ButtonState.idle: IconedButton(
                text: "Add to Cart",
                icon: Icon(Icons.shopping_cart_outlined,
                    size: 23, color: Colors.white),
                color: Color(0xff032e6b),
              ),
              ButtonState.loading: IconedButton(
                text: "Loading",
                icon: Icon(Icons.blur_circular),
                color: Color(0xff032e6b),
              ),
              ButtonState.fail: IconedButton(
                  text: "Failed",
                  icon: Icon(Icons.cancel, color: Colors.white),
                  color: Colors.red.shade300),
              ButtonState.success: IconedButton(
                  text: "Added",
                  icon: Icon(
                    Icons.check_circle,
                    color: Colors.white,
                  ),
                  color: Colors.green.shade400)
            },
            onPressed: () {
              print('productId  ${widget.product.productId}');
              addToCart(
                  productId: widget.product.productId, userId: widget.userId,slPrice: double.parse(widget.product.slPrice),mrpPrice: double.parse(widget.product.mrpPrice),grandTotal: (double.parse(widget.product.slPrice)*qty),quantity: qty);
            },
            state: stateTextWithIcon,
          ),
        )
        );
  }
//TODO: dropdown
//select type(dropdown)
  // Container dropdown() {
  //   if (widget.product.type == null || widget.product.typeList == null) {
  //     return Container();
  //   } else {
  //     return Container(
  //       child: Center(
  //         child: DropdownButton<String>(
  //           value: _selectedValue,
  //           items: widget.product.typeList.map((String value) {
  //             return new DropdownMenuItem(
  //               value: value,
  //               child: new Text(value),
  //             );
  //           }).toList(),
  //           onChanged: (newValue) {
  //             setState(() {
  //               _selectedValue = newValue;
  //             });
  //           },
  //           dropdownColor: Colors.grey[200],
  //           style: TextStyle(
  //               fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
  //         ),
  //       ),
  //     );
  //   }
  // }

  //scrached price
  Text price1(double price1) {
    if (price1 != null) {
      return Text(
        '₹${price1}',
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

  discount({double mrp, double slp}) {
    int discount = 0;
    if (mrp != slp) {
      int discount = (((mrp - slp) / mrp) * 100).round();
    } else {}
    if (discount > 0) {
      return Row(
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
                    ' ${discount}% Off ',
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
      );
    } else {
      return Container();
    }
  }

  void addToCart(
      {String productId,
      String userId,
      int quantity,
      String productName,
      double mrpPrice,
      double slPrice,

      double grandTotal}) async {
    print('productId $productId');
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        setState(() {
          stateTextWithIcon = ButtonState.loading;
        });

        bool added;
        APIService apiService = APIService();

        await apiService
            .addItemToCart(
                productId: productId,
                productName: productName,
                price: mrpPrice,
                slPrice: slPrice,
                userId: userId,
                grandTotal: grandTotal,
                quantity: quantity)
            .then((value) {
          if (value == true) {
            setState(() {
              stateTextWithIcon = ButtonState.success;
            });
          }
          if (value == false) {
            setState(() {
              stateTextWithIcon = ButtonState.fail;
            });
          }
        });

        // Future.delayed(Duration(seconds: 1), () {
        //   setState(() {
        //     stateTextWithIcon = Random.secure().nextBool()
        //         ? ButtonState.success
        //         : ButtonState.fail;
        //   });
        // });

        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        break;
      case ButtonState.fail:
        stateTextWithIcon = ButtonState.idle;
        break;
    }
    setState(() {
      stateTextWithIcon = stateTextWithIcon;
    });
  }
}
