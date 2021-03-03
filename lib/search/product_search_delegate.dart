import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/pages/ui/widget/product_card.dart';
import 'package:sanchika/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class ProductSearch extends SearchDelegate<Product> {
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

  APIService apiService = new APIService();
  Future getProductListHo() async {
    List<Product> productList =
        await apiService.getProductList(apiService.getProducts());
    print('i am home');
    print(productList);
    return productList;
  }

  List<Product> filterProducts({List<Product> productList, String type}) {
    if (type == 'Relevance') {
      return productList;
    }
    if (type == 'Discount') {
      return productList;
    }
    if (type == 'Sort High to Low') {
      productList.sort((a, b) => a.price.compareTo(b.price));
      return productList;
    }
    if (type == 'Sort Low to High') {
      productList.sort((a, b) => a.price.compareTo(b.price));
      return productList;
    }
    return productList;
  }

  List<String> filter = [
    'Relavance',
    'Discount',
    'Sort High to Low',
    'Sort Low to High',
  ];
  String type = 'Relavance';

  void getType() {}

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
      IconButton(
        icon: Icon(Icons.sort),
        onPressed: () {
          showMaterialModalBottomSheet(
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.white,
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Row(
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
                        Expanded(
                          child: SizedBox(
                            height: 300,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: filter.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    type = filter[index];
                                    print('type to search');
                                    print(type);
                                    // _changetype(context, type: filter[index]);
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
                        )
                      ],
                    ),
                  ),
                );
              });
        },
      )
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
      future: getProductListHo(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          addRecentSearch(query);
          List<Product> productList = snapshot.data;
          List<Product> result = productList
              .where((a) => a.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
          return SearchResult(
            productList: result,
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
      future: getProductListHo(),
      builder: (BuildContext context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Product> productList = snapshot.data;
        var results;
        if (query != '') {
          results = productList
              .where((a) => a.name.toLowerCase().contains(query))
              .toList();
          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  query = results[index].name;
                  showResults(context);
                },
                title: Text(results[index].name),
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
                              color: Colors.blue[100],
                            ),
                            title: RichText(
                              text: TextSpan(
                                  text: snapshot.data[index],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
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
                            title: Text('Clear Search'),
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

  SearchResult({
    this.productList,
  });

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  APIService apiService = new APIService();
  Future getProductListHo() async {
    List<Product> productList =
        await apiService.getProductList(apiService.getProducts());
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
    if (type == 'Sort High to Low') {
      setState(() {
        productList.sort((b, a) => a.price.compareTo(b.price));
      });
    }
    if (type == 'Sort Low to High') {
      setState(() {
        productList.sort((a, b) => a.price.compareTo(b.price));
      });
    }
  }

  void initState() {
    super.initState();
  }

  List<String> filter = [
    'Relavance',
    'Discount',
    'Sort High to Low',
    'Sort Low to High',
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
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: Colors.white,
                                  height: 300,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    children: [
                                      Row(
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
                                      Expanded(
                                        child: SizedBox(
                                          height: 300,
                                          child: ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
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
                                      )
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
            shrinkWrap: false,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).size.width *
                  0.43 /
                  (MediaQuery.of(context).size.height * .35),
            ),
            itemCount: widget.productList.length,
            itemBuilder: (context, index) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                      child: ProductCard(product: widget.productList[index])),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
