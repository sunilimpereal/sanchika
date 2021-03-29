import 'package:flutter/material.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';
import 'package:sanchika/model/addToCart_model.dart';
import 'package:sanchika/model/cart_model.dart';
import 'package:sanchika/model/getAllRatingReview_model.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/model/wishlist_model.dart';
import 'package:sanchika/pages/ui/screens/cart.dart';
import 'package:sanchika/pages/ui/screens/home/home.dart';
import 'package:sanchika/pages/ui/screens/wishlist.dart';
import 'package:sanchika/pages/ui/widget/crousal.dart';
import 'package:sanchika/pages/ui/widget/stepper.dart';
import 'package:sanchika/services/api_service.dart';
import 'package:sanchika/utils/numericStepButton.dart';
import 'package:readmore/readmore.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

class ProductView extends StatefulWidget {
  final Product product;
  bool inWishlist;
  final String userId;
  final List<CartItem> cartItems;
  Function onMenuItemClicked;
  ProductView(
      {this.product,
      this.inWishlist,
      this.userId,
      this.cartItems,
      this.onMenuItemClicked});
  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  AddtocartRequest addtocartRequest;
  int qty = 1;
  APIService apiService;
  bool incart = false;

  void checkCart() {
    for (CartItem c in widget.cartItems ?? []) {
      if (c.productId == widget.product.productId) {
        setState(() {
          incart = true;
        });
      }
    }
  }

  String userId;
  Future<String> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String uid = preferences.getString('userId');
    setState(() {
      userId = uid;
    });
    return uid;
  }

  void initState() {
    apiService = APIService();
    checkCart();
    getUserId();
    super.initState();
  }

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
          IconButton(
            padding: EdgeInsets.only(top: 0),
            icon: Icon(
              Icons.favorite_rounded,
              color: Color(0xff032e6b).withAlpha(180),
              size: 24,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Wishlist()),
              );
            },
          ),
          Stack(
            children: [
              IconButton(
                  padding: EdgeInsets.only(top: 8),
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Color(0xff032e6b).withAlpha(180),
                    size: 24,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Cart()),
                    );
                  }),
              FutureBuilder(
                  future: apiService.cartlength(uid: userId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (int.parse(snapshot.data) > 0) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 25),
                          child: Container(
                            height: 18,
                            width: 18,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xff032e6b),
                            ),
                            child: Center(
                              child: Text(
                                snapshot.data,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    } else {
                      return SizedBox();
                    }
                  }),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  child: Hero(
                tag: 'image' + widget.product.productName,
                child: Crousal(
                  photos: [
                    widget.product.productImage ?? '',
                    widget.product.productImage1 ?? '',
                    widget.product.productImage2 ?? '',
                    widget.product.productImage3??'',
                    widget.product.productImage4??'',
                    widget.product.productImage5??'',
                    widget.product.productImage6??'',
                    widget.product.productImage??'',
                  ],
                ),
              )),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Container(
                     width:MediaQuery.of(context).size.width*0.7,
                     child: Text(
                      widget.product.productName,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          fontFamily: 'Poppins'),
                    ),),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: FavoriteButton(
                          isFavorite: widget.inWishlist,
                          iconSize: 38,
                          valueChanged: (value) {
                            if (!widget.inWishlist) {
                              AddWishlistRequest addWishlistRequest =
                                  AddWishlistRequest();
                              addWishlistRequest.userId =
                                  int.parse(widget.userId);
                              addWishlistRequest.productId =
                                  widget.product.productId;
                              APIService apiService = new APIService();
                              apiService
                                  .addToWishlist(addWishlistRequest)
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
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    discount(
                        mrp: double.parse(widget.product.mrpPrice),
                        slp: double.parse(widget.product.slPrice)),
                  ],
                ),
              ),
              // Price Row
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
                                  fontWeight: FontWeight.bold, fontSize: 18),
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
                                fontWeight: FontWeight.w600, fontSize: 18),
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
                  SizedBox(height:10),


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
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height:10),

              // Review Section
              Container(
                child: FutureBuilder(
                    future: apiService.getRatingAndReview('1001'),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<RatingAndReview> rat = snapshot.data;
                        rat.sort((a, b) => DateFormat('yyyy/MM/dd')
                            .parse(b.ratingDate)
                            .compareTo(
                                DateFormat('yyyy/MM/dd').parse(a.ratingDate)));
                        return RatingReview(
                          ratingAndReview: rat,
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
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
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                     FutureBuilder(
                          future: apiService.getKillerOffeers(),
                          builder: (BuildContext context, snapshot) {
                            print(snapshot);

                            if (snapshot.hasData) {
                              List<Product> productList = snapshot.data;
                              return HorizontalRow(
                                productList: productList,
                                cartItems: widget.cartItems,
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          }),
                          SizedBox(height:40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: button(),
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
  //button
  Widget button() {
    if (incart) {
      return Container(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              color: Colors.transparent,
              height: 50,
              width: 250,
              child: StepperTouch(
                initialValue: 1,
                direction: Axis.horizontal,
                withSpring: true,
                onChanged: (int value) {},
              )),
        ),
      );
    } else {
      return Container(
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
              color: Colors.red.shade300,
            ),
            ButtonState.success: IconedButton(
                text: "Added",
                icon: Icon(
                  Icons.check_circle,
                  color: Colors.white,
                ),
                color: Colors.green.shade400)
          },
          onPressed: () {
            print(widget.product.productId);
            addToCart(
              productId: widget.product.productId,
              userId: widget.userId,
              slPrice: double.parse(widget.product.slPrice),
              productName: widget.product.productName,
              quantity: 1,
              grandTotal: double.parse(widget.product.slPrice),
            );
          },
          state: stateTextWithIcon,
        ),
      );
    }
  }

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

//comments

  discount({double mrp, double slp}) {
    int discount = 0;
    if (mrp != slp) {
      discount = (((mrp - slp) / mrp) * 100).round();
    }
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
            setState(() {
              incart = true;
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

class RatingReview extends StatefulWidget {
  final List<RatingAndReview> ratingAndReview;
  RatingReview({this.ratingAndReview});
  @override
  _RatingReviewState createState() => _RatingReviewState();
}

class _RatingReviewState extends State<RatingReview> {
  APIService apiService;
  double averageRating = 0;
  int reviewCount = 3;
  bool isExpanded = false;
  String reviewButton = "Read All";
  int totalStar = 0;
  int star1 = 0;
  int star2 = 0;
  int star3 = 0;
  int star4 = 0;
  int star5 = 0;
  @override
  void initState() {
    apiService = APIService();
    super.initState();
    getStars(widget.ratingAndReview);
    getAverageRating();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          _review(),
          Divider(
            thickness: 1,
          ),
          Container(
            child: Column(
              children: widget.ratingAndReview
                  .map((e) {
                    return _comment(
                        name: e.name,
                        review: e.review,
                        date: e.ratingDate,
                        stars: e.rating);
                  })
                  .toList()
                  .take(reviewCount)
                  .toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  if (isExpanded) {
                    setState(() {
                      reviewCount = 3;
                      isExpanded = !isExpanded;
                      reviewButton = 'Read All';
                    });
                  } else {
                    setState(() {
                      reviewCount = widget.ratingAndReview.length;
                      isExpanded = !isExpanded;
                      reviewButton = 'Show less';
                    });
                  }
                },
                child: Container(
                  height: 30,
                  child: Text(
                    reviewButton,
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void getStars(List<RatingAndReview> ratingAndReview) {
    for (RatingAndReview e in ratingAndReview) {
      print('total Stars = $totalStar');
      totalStar = totalStar + 1;
      if (e.rating == 1) {
        star1++;
      }
      if (e.rating == 2) {
        star2++;
      }
      if (e.rating == 3) {
        star3++;
      }
      if (e.rating == 4) {
        star4++;
      }
      if (e.rating == 5) {
        star5++;
      }
      setState(() {});
    }
  }

  double getAverageRating() {
    setState(() {
      int sum =
          (star1 * 1) + (star2 * 2) + (star3 * 3) + (star4 * 4) + (star5 * 5);
      averageRating = sum / totalStar;
    });
    return averageRating;
  }

  int getPercent(int star, int totalStar) {
    int percent = 0;
    if (star > 0) {
      percent = ((star / totalStar) * 100).round();
    }
    return percent;
  }

  //comments
  Widget _comment({String name, String review, String date, int stars}) {
    DateTime now = DateTime.now();
    DateTime date1 = DateFormat('yyyy/MM/dd').parse(date);
    String dateFormat = timeago.format(date1);
    print('Date $date1');
    print(' datef${timeago.format(date1)}');
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
        color: Colors.grey[300],
      );
    }

    for (var i = 0; i < stars; i++) {
      starsicon.add(_starfill());
    }
    for (var i = 0; i < (5 - stars); i++) {
      starsicon.add(_starnotfill());
    }
    return Container(
      width: MediaQuery.of(context).size.width,
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
              SizedBox(
                width: MediaQuery.of(context).size.width - 60,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 10),
                        Row(
                          children: [
                            Text(
                              dateFormat,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: starsicon,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width - 60,
                        color: Colors.transparent,
                        child: Text(review)
                        // ReadMoreText(
                        //   review,
                        //   trimLines: 2,
                        //   trimMode: TrimMode.Line,
                        //   trimCollapsedText: 'more',
                        //   trimExpandedText: 'less',
                        // ),
                        ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }

  Widget _review() {
    List<Widget> avgStar = [];
    int grey = 5 - averageRating.round();
    for (int i = 0; i < averageRating.round(); i++) {
      avgStar.add(Icon(
        Icons.star,
        size: 18,
        color: Colors.amber,
      ));
    }
    for (int i = 0; i < grey; i++) {
      avgStar.add(Icon(
        Icons.star,
        size: 18,
        color: Colors.grey[300],
      ));
    }

    Widget lines(int length, int star) {
      return Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '$star',
                    style: TextStyle(
                      color: Color(0xff032e6b),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    Icons.star,
                    size: 12,
                    color: Colors.grey[300],
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey[200],
                ),
                height: 8,
                width: 150,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.yellow[600],
                      ),
                      width: 150 * (length / 100),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                '$length %',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                ),
              )
            ],
          ),
        ),
      );
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.18 - 10,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 0.0, left: 0.0),
            child: Container(
              child: Column(
                children: [
                  Text(
                    averageRating.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 45,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: avgStar,
                  )
                ],
              ),
            ),
          ),
          SizedBox(width: 10),
          Container(
            child: Column(
              children: [
                lines(getPercent(star5, totalStar), 5),
                lines(getPercent(star4, totalStar), 4),
                lines(getPercent(star3, totalStar), 3),
                lines(getPercent(star2, totalStar), 2),
                lines(getPercent(star1, totalStar), 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
