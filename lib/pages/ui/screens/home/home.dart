import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';
import 'package:sanchika/model/cart_model.dart';
import 'package:sanchika/model/getBanner_model.dart';
import 'package:sanchika/model/getCatg_model.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/model/wishlist_model.dart';
import 'package:sanchika/pages/ui/widget/Category_top.dart';
import 'package:sanchika/pages/ui/widget/categories_home_card.dart';
import 'package:sanchika/pages/ui/widget/homeCtg.dart';
import 'package:sanchika/pages/ui/widget/home_crousal.dart';
import 'package:sanchika/pages/ui/widget/product_card.dart';
import 'package:sanchika/search/product_search_delegate.dart';
import 'package:sanchika/services/api_service.dart';
import 'package:sanchika/utils/checkInternet.dart';
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
  String userId;
  Future<String> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String uid = preferences.getString('userId');
    setState(() {
      userId = uid;
    });
  }

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

  //product list
  Future<List<Product>> killeroffers;
  Future<List<Product>> activeProducts;
  List<WishlistItem> wishlist;
  List<CartItem> cartItems;
  Future<List<CartItem>> getCart(String userId)async{
    APIService apiService = new APIService();
    List<CartItem> cartitems = await apiService.getCartItems(userId);
    setState(() {
      cartItems = cartitems;

    }); 
    return cartitems;

  }
  Future<List<WishlistItem>> getWishlist(String userId) async {
    APIService apiService = new APIService();
    List<WishlistItem> allWishlistItems =
        await apiService.getWishList(userId: userId);
    print('wishlist');
    print(allWishlistItems);
    setState(() {
      wishlist = allWishlistItems;
    });
    return allWishlistItems;
  }

  Future<List<Product>> getKilleroffer() async {
    List<Product> productList = await apiService.getKillerOffeers();
    return productList;
  }

  Future<List<Product>> getActiveProduct() async {
    List<Product> productList = await apiService.getAllProducts();
    return productList;
  }

  //banners
  Future<List<BannerMaster>> bannerList;
  Future<List<BannerMaster>> getBanners() async {
    List<BannerMaster> bannerList = await apiService.getBanners();
    return bannerList;
  }

  //get Top Menu
  Future<List<CtgyNameAndId>> ctgNameandId;
  Future<List<CtgyNameAndId>> getCtgNameandId() async {
    List<CtgyNameAndId> topMenulist = await apiService.getCatg();
    return topMenulist;
  }

  @override
  void initState() {
    super.initState();
    checkInternet().checkConnection(context);
    getUserId().then((value) {
      print(userId);
      getWishlist(userId);
      getCart(userId);
    });
    killeroffers = getKilleroffer();
    activeProducts = getActiveProduct();
    bannerList = getBanners();
    ctgNameandId = getCtgNameandId();
    print(userId);

    print('banner list');
    print(bannerList);
    print(activeProducts);
  }

@override
  void dispose() {
     checkInternet().listener.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
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
                              context: context,
                              delegate:
                                  ProductSearch(productsList: activeProducts,cartItems: cartItems,wishlist: wishlist));
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
                  color: Color(0xff032e6b).withAlpha(180),
                  size: 24,
                ),
                onPressed: () {
                  BlocProvider.of<NavigationBloc>(context)
                      .add(NavigationEvents.WishlistClickedEvent);
                  // widget.onMenuItemClicked();
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
                      BlocProvider.of<NavigationBloc>(context)
                          .add(NavigationEvents.CartClickedEvent);
                      // widget.onMenuItemClicked();
                    },
                  ),
                    FutureBuilder(
                  future: apiService.cartlength(uid: userId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if(int.parse(snapshot.data)>0){
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
                    }else{
                      return SizedBox();
                    }} else {
                      return SizedBox();
                    }
                  }),
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
                      Container(
                        // width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.26,
                        child: FutureBuilder(
                            future: bannerList,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                print(snapshot.data);
                                return HomeCrousal(banners: snapshot.data);
                              } else {
                                const spinkit = SpinKitDoubleBounce(
                                  color: Color(0xff032e6b),
                                  size: 50.0,
                                );
                                return Center(child: spinkit);
                              }
                            }),
                      ),
                      //top Menu
                      // FutureBuilder(
                      //     future: ctgNameandId,
                      //     builder: (context, snapshot) {
                      //       if (snapshot.hasData) {
                      //         return HomeMenuRow(ctgNameandId: snapshot.data);
                      //       } else {
                      //         return CircularProgressIndicator();
                      //       }
                      //     }),
                      FutureBuilder(
                          future: ctgNameandId,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Category_top(ctgNameandId: snapshot.data);
                            } else {
                              return CircularProgressIndicator();
                            }
                          }),

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
                          future: apiService.getKillerOffeers(),
                          builder: (BuildContext context, snapshot) {
                            print(snapshot);

                            if (snapshot.hasData) {
                              List<Product> productList = snapshot.data;
                              return HorizontalRow(
                                productList: productList,
                                wishlist: wishlist,
                                cartItems: cartItems,
                                
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          }),
                      Container(
                        child: FutureBuilder(
                          future: apiService.getCatg(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    CtgyNameAndId ctgyNameAndId =
                                        snapshot.data[index];
                                    if (index%2 == 0) {
                                      return Column(
                                        children: [
                                          HomeCtg(ctgyNameAndId: ctgyNameAndId),
                                          Container(
                                             height: MediaQuery.of(context).size.height * 0.26,
                                            child: FutureBuilder(
                                                future: bannerList,
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    print(snapshot.data);
                                                    return HomeCrousal(
                                                        banners: snapshot.data);
                                                  } else {
                                                    const spinkit =
                                                        SpinKitDoubleBounce(
                                                      color: Color(0xff032e6b),
                                                      size: 50.0,
                                                    );
                                                    return Center(child: spinkit);
                                                  }
                                                }),
                                          ),
                                        ],
                                      );
                                    }
                                    return HomeCtg(
                                        ctgyNameAndId: ctgyNameAndId);
                                  });
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // HomeCrousal()
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

  
}

class HomeMenuRow extends StatelessWidget {
  final List<CtgyNameAndId> ctgNameandId;
  HomeMenuRow({this.ctgNameandId});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: SizedBox(
                height: 70,
                child: ListView.builder(
                    addAutomaticKeepAlives: true,
                    controller: ScrollController(),
                    scrollDirection: Axis.horizontal,
                    cacheExtent: 10000,
                    itemCount: ctgNameandId.length,
                    itemBuilder: (context, index) {
                      CtgyNameAndId ctgItem = ctgNameandId[index];
                      return CategoryHomeCard(ctgyNameAndId: ctgItem);
                    })))
      ],
    );
  }
}

class HorizontalRow extends StatelessWidget {
  final List<WishlistItem> wishlist;
  final List<Product> productList;
  final List<CartItem> cartItems;
  const HorizontalRow({
    Key key,
    this.productList,
    this.wishlist,
    this.cartItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 300,
            child: ListView.builder(
              cacheExtent: 10000.0,
              dragStartBehavior: DragStartBehavior.start,
              addAutomaticKeepAlives: true,
              controller: ScrollController(),
              scrollDirection: Axis.horizontal,
              itemCount: productList.length,
              itemBuilder: (context, index) {
                print('wishlist in builder');
                print(wishlist);
                Product product = productList[index];
                return Container(
                  child: ProductCard(
                    product: product,
                    wishlist: wishlist,
                    cartItems: cartItems,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
