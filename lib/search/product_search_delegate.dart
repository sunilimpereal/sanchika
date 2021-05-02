import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sanchika/model/cart_model.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/model/wishlist_model.dart';
import 'package:sanchika/pages/ui/widget/product_card.dart';
import 'package:sanchika/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class ProductSearch extends SearchDelegate<Product> {
  Future<List<Product>> productsList;
  List<WishlistItem> wishlist;
  List<CartItem> cartItems;

  ProductSearch({this.productsList, this.wishlist, this.cartItems});
  Future<List<String>> getRecentSearch() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> recent = preferences.getStringList('recentSearch');
    return recent.reversed.toList();
  }

  Future<List<String>> addRecentSearch(String add) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> recent = preferences.getStringList('recentSearch');
    recent.add(add);
    recent.reversed.toList();
    preferences.setStringList('recentSearch', recent);
  }

  void clearRecentSearch() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setStringList('recentSearch', []);
  }

  //API TO call products

  APIService apiService = new APIService();
  Future<List<Product>> getProductListHo() async {
    print('i am home');
    List<Product> productList = await apiService.getAllProducts();
    print(productList);
    return productList;
  }
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: productsList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          addRecentSearch(query);
          List<Product> productList = snapshot.data;
          List<Product> result = productList
              .where((a) =>
                  a.pdmPdtNm.toLowerCase().contains(query.toLowerCase()))
              .toList();
          return SearchResult(
            productList: result,
            wishlist: wishlist??[],
            cartItem: cartItems??[],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: productsList,
      builder: (BuildContext context, snapshot) {
        print(snapshot);
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Product> productList = snapshot.data;
        var results;
        if (query != '') {
          results = productList
              .where((a) => a.pdmPdtNm.toLowerCase().contains(query))
              .toList();
          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  query = results[index].pdmPdtNm;
                  showResults(context);
                },
                title: Text(results[index].pdmPdtNm),
              );
            },
          );
        } else {
          return FutureBuilder(
              future: getRecentSearch(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        if (index < snapshot.data.length - 1) {
                          return ListTile(
                            onTap: () {
                              query = snapshot.data[index];
                              showResults(context);
                            },
                            leading: Icon(
                              Icons.history,
                              color: Colors.grey[300],
                            ),
                            title: Transform.translate(
                              offset: Offset(-16, -3),
                              child: Text(snapshot.data[index],
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                  )),
                            ),
                          );
                        } else {
                          return ListTile(
                            onTap: () {
                              clearRecentSearch();
                              void showToast(String msg,
                                  {int duration, int gravity}) {
                                Toast.show(msg, context,
                                    duration: duration, gravity: gravity);
                              }

                              close(context, null);
                              showToast("Search Cleared",
                                  gravity: Toast.CENTER);
                            },
                            title: Text(
                              'Clear Search',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          );
                        }
                      });
                } else {
                  return Container();
                }
              });
        }
      },
    );
  }
}

class SearchResult extends StatefulWidget {
  final List<Product> productList;
  final List<WishlistItem> wishlist;
  final List<CartItem> cartItem;

  SearchResult({
    this.productList,this.wishlist,this.cartItem,
  });

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  APIService apiService = new APIService();
  Future getProductListHo() async {
    List<Product> productList = null;
    await apiService.getAllProducts();
    print('i am home');
    print(productList);
    return productList;
  }

  Future<List<String>> addRecentSearch(String add) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> recent = preferences.getStringList('recentSearch');
    recent.add(add);
    recent.reversed.toList();
    preferences.setStringList('recentSearch', recent);
  }

  void filterProducts({List<Product> productList, String type}) {
    if (type == 'Relevance') {
      setState(() {
        widget.productList;
      });
    }
    if (type == 'Discount') {
      setState(() {
        widget.productList;
      });
    }
    if (type == 'Price High to Low') {
      setState(() {
        productList.sort((b, a) =>
            double.parse(a.slPrc).compareTo(double.parse(b.slPrc)));
      });
    }
    if (type == 'Price Low to High') {
      setState(() {
        productList.sort((a, b) =>
            double.parse(a.slPrc).compareTo(double.parse(b.slPrc)));
      });
    }
  }

  void initState() {
    super.initState();
  }

  List<String> filter = [
    'Relavance',
    'Discount',
    'Price High to Low',
    'Price Low to High',
  ];
  String type = 'Relavance';
  void _changeSortBy(String type) {
    setState(() {
      type = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Column(
      children: [
        Container(
          color: Colors.white,
          height: 55,
          width: MediaQuery.of(context).size.width,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                new BoxShadow(
                  color: Colors.grey[200],
                  blurRadius: 20.0,
                ),
              ],
            ),
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 40,
                    width: 150,
                    child: RaisedButton(
                      onPressed: () {
                        showMaterialModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                            ),
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: Colors.white,
                                  height: 300,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 16.0, left: 8),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Sort By',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.blueGrey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 0.0, left: 8.0),
                                              child: Container(
                                                height: 5,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    color: Color(0xff0B3666)
                                                        .withOpacity(0.9),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          child: ListView.builder(
                                            itemCount: filter.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                onTap: () {
                                                  type = filter[index];
                                                  filterProducts(
                                                      productList:
                                                          widget.productList,
                                                      type: filter[index]);
                                                  _changeSortBy(filter[index]);
                                                  print(type);
                                                  Navigator.pop(context);
                                                },
                                                title: Text(filter[index]),
                                                trailing: filter[index] == type
                                                    ? Icon(
                                                        Icons.select_all,
                                                        color: Colors.blue,
                                                      )
                                                    : Container(
                                                        height: 5,
                                                        width: 5,
                                                      ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      color: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.sort),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Sort',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 150,
                    child: RaisedButton(
                      onPressed: () {},
                      color: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.filter_list),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              'Filter',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            cacheExtent: 100000,
            shrinkWrap: false,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).size.width *
                  0.5 /
                  (MediaQuery.of(context).size.height * .39),
            ),
            itemCount: widget.productList.length,
            itemBuilder: (context, index) {
              Product product = widget.productList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Container(child: ProductCard(product: product,wishlist: widget.wishlist,cartItems: widget.cartItem,)),
              );
            },
          ),
        ),
      ],
    );
  }
}
