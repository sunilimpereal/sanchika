import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/pages/ui/sub_screens/personalCare.dart';
import 'package:sanchika/pages/ui/widget/categories_home_card.dart';
import 'package:sanchika/pages/ui/widget/home_crousal.dart';
import 'package:sanchika/pages/ui/widget/product_card.dart';
import 'package:sanchika/search/product_search_delegate.dart';
import 'package:sanchika/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';

class Home extends StatefulWidget with NavigationStates {
  final Function onMenuTap;
  final Function onMenuItemClicked;

  const Home({Key key, this.onMenuTap, this.onMenuItemClicked})
      : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  APIService apiService = APIService();
  final translator = GoogleTranslator();

  List<Product> products;

  String search = 'Search';
  String personalcare = 'Personal Care';
  String processedFood = 'Processed Food';
  void translate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final translator = GoogleTranslator();
    translator.translate('Search', to: 'ml').then((result) {
      setState(() {
        if (preferences.getString('language') == 'malayalam') {
          search = result.text;
        } else {
          search = 'Search';
        }
      });
    });
    translator.translate(personalcare, to: 'ml').then((result) {
      setState(() {
        if (preferences.getString('language') == 'malayalam') {
          personalcare = result.text;
        } else {}
      });
    });
    translator.translate(processedFood, to: 'ml').then((result) {
      setState(() {
        if (preferences.getString('language') == 'malayalam') {
          processedFood = result.text;
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // translate();
    getProductListHo();
  }

  Future getProductListHo() async {
    List<Product> productList =
        await apiService.getProductList(apiService.getProducts());
    print('i am home');
    print(productList);
    // setState(() {
    //   products = productList;
    // });
    return productList;
  }

  @override
  Widget build(BuildContext context) {
    print('product');
    print(products);
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 135,
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
                        onTap: () {
                          showSearch(
                              context: context, delegate: ProductSearch());
                        },
                        readOnly: true,
                        keyboardType: TextInputType.text,
                        placeholder: search,
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
                padding: EdgeInsets.only(top: 0),
                icon: Icon(
                  Icons.favorite_rounded,
                  color: Colors.grey[800],
                  size: 24,
                ),
                onPressed: () {
                  BlocProvider.of<NavigationBloc>(context)
                      .add(NavigationEvents.WishlistClickedEvent);
                  widget.onMenuItemClicked();
                },
              ),
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
                      BlocProvider.of<NavigationBloc>(context)
                          .add(NavigationEvents.CartClickedEvent);
                      widget.onMenuItemClicked();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 25),
                    child: Container(
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff0B3666),
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
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index > 0) return null;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      HomeCrousal(),
                      Container(
                        color: Color(0xffEDE2DC),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // categories list
                              GestureDetector(
                                onTap: () {
                                  print(apiService.getProducts());
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PersonalCare()),
                                  );
                                },
                                child: CategoryHomeCard(
                                  name: personalcare,
                                  image: 'assets/images/skincare.png',
                                ),
                              ),
                              CategoryHomeCard(
                                name: processedFood,
                                image: 'assets/images/processedfood.png',
                              ),
                              CategoryHomeCard(
                                name: 'Stationary',
                                image: 'assets/images/stationary.png',
                              ),
                              CategoryHomeCard(
                                name: 'CEREALS',
                                image: 'assets/images/cereal.png',
                              ),
                              CategoryHomeCard(
                                name: 'Household',
                                image: 'assets/images/household.png',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 16.0, bottom: 8.0),
                            child: Text(
                              "Killer Offers",
                              style: TextStyle(
                                  color: Color(0xff032e6b),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),

                      FutureBuilder(
                        future: getProductListHo(),
                        builder: (BuildContext context, snapshot) {
                          print(snapshot);
                          if (snapshot.hasData) {
                            return Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 300,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (context, index) {
                                        Product product = snapshot.data[index];
                                        return ProductCard(
                                          product: product,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Productcard(product: products[0]),
                      //     Productcard(product: products[1]),
                      //     Productcard(product: products[2]),
                      //     Padding(
                      //       padding: const EdgeInsets.only(
                      //           top: 8.0, left: 16.0, bottom: 8.0, right: 15),
                      //       child: Text(
                      //         "See more >>",
                      //         style: TextStyle(
                      //             color: Color(0xff032e6b),
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.w600),
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 16.0, bottom: 8.0),
                            child: Text(
                              "Staples Trending Products",
                              style: TextStyle(
                                  color: Color(0xff032e6b),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Productcard(product: products[3]),
                            // Productcard(product: products[4]),
                            // Productcard(product: products[4]),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 16.0, bottom: 8.0, right: 14),
                              child: Text(
                                "See more >>",
                                style: TextStyle(
                                  color: Color(0xff032e6b),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0, left: 16.0, bottom: 8.0),
                            child: Text(
                              "PROCESSED FOOD",
                              style: TextStyle(
                                  color: Color(0xff032e6b),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              categoryBox(
                                name: 'BREAKFAST',
                                img: 'assets/images/breakfast.png',
                              ),
                              categoryBox(
                                name: 'BEVRAGES',
                                img: 'assets/images/drinks.png',
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              categoryBox(
                                name: 'HOME CARE',
                                img: 'assets/images/household.jpg',
                              ),
                              categoryBox(
                                name: 'AVACAROS',
                                img: 'assets/images/avacados.jpg',
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              categoryBox(
                                name: 'PLUMS',
                                img: 'assets/images/household.jpg',
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  height: MediaQuery.of(context).size.height *
                                          0.15 -
                                      8,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
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
                                    child: Text(
                                      'See More >>',
                                      style: TextStyle(
                                        color: Colors.deepPurpleAccent,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                      color: Colors.green[200],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0,
                                          left: 10.0,
                                          bottom: 0.0,
                                          right: 10),
                                      child: Text(
                                        "COOKING  MEDIUM ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                color: Colors.green[200],
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    cardcat(
                                      img: 'assets/images/hcereal.jpg',
                                      name: 'Cooking Oil',
                                    ),
                                    cardcat(
                                        img: 'assets/images/spices.jpg',
                                        name: 'SPICES'),
                                    cardcat(
                                        img: 'assets/images/suagr.jpg',
                                        name: 'SUGAR')
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      HomeCrousal()
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding cardcat({String img, String name}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 160,
        width: 150,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: const Offset(3.0, 2.0),
              color: Colors.green[300],
              blurRadius: 4.0,
              spreadRadius: 1.0,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Container(
                  height: 134,
                  width: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(img),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 134,
                  width: 150,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.white,
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(bottom: 8, top: 2),
              child: Center(
                child: Text(
                  name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryBox({String name, String img}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.15 - 8,
        width: MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(3.0, 2.0),
              color: Colors.grey[200],
              blurRadius: 3.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.15 - 40,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                      image: AssetImage(img), fit: BoxFit.contain)),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              child: Center(
                child: Text(
                  name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
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
