import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sanchika/model/CtgAttribute.dart';
import 'package:sanchika/model/cart_model.dart';
import 'package:sanchika/model/getCatg_model.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/pages/ui/screens/cart.dart';
import 'package:sanchika/pages/ui/screens/wishlist.dart';
import 'package:sanchika/pages/ui/widget/product_card.dart';
import 'package:sanchika/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductAttribute extends StatefulWidget {
  final CategoryAttribute categoryAttribute;
  final CtgyNameAndId ctgyNameAndId;
  List<CartItem> cartitems;
  ProductAttribute(
      {this.categoryAttribute, this.ctgyNameAndId, this.cartitems});
  @override
  _ProductAttributeState createState() => _ProductAttributeState();
}

class _ProductAttributeState extends State<ProductAttribute> {
  int index;
  List<CategoryAttribute> attributeList;
  CategoryAttribute cat;
  APIService apiService;
  Future<List<CategoryAttribute>> getAttribute() async {
    APIService apiService = APIService();
    await apiService
        .getCategoryAttribute(widget.ctgyNameAndId.mnId)
        .then((value) {
      setState(() {
        attributeList = value;
        index = attributeList.indexOf(widget.categoryAttribute);
        print('indextop $index');
        cat = widget.categoryAttribute;
      });
    });
  }

  String userId;
  Future<String> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String uid = preferences.getString('userId');
    setState(() {
      userId = uid;
    });
  }

  List<CartItem> cartItems;
  Future<List<CartItem>> getCart(String userId) async {
    APIService apiService = new APIService();
    List<CartItem> cartitems = await apiService.getCartItems(userId);
    setState(() {
      cartItems = cartitems;
    });
    return cartitems;
  }

  List<String> filter = [
    'Relavance',
    'Discount',
    'Price High to Low',
    'Price Low to High',
  ];
  String type = 'Relavance';

  @override
  void initState() {
    getUserId().then((value) {
      getCart(userId);
    });
    apiService = APIService();
    super.initState();
    getAttribute();
    CategoryAttribute cat = widget.categoryAttribute;
  }

  @override
  Widget build(BuildContext context) {
    if (attributeList != null) {
      int ind = attributeList
          .map((e) => e.categoryValue)
          .toList()
          .indexOf(widget.categoryAttribute.categoryValue);
      print("indexx $ind");
      return DefaultTabController(
        initialIndex: ind,
        length: attributeList.length,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Color(0xff0B3666)),
            titleSpacing: 0,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 8),
                Text(
                  widget.ctgyNameAndId.ctgyNm,
                  style: TextStyle(color: Color(0xff0B3666), fontSize: 16),
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(30.0),
              child: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.yellow,
                indicatorColor: Color(0xff0B3666).withAlpha(180),
                indicatorSize: TabBarIndicatorSize.label,
                tabs: attributeList
                    .map((item) => Tab(
                            child: Text(
                          item.categoryValue,
                          style: TextStyle(
                            color: Color(0xff0B3666),
                          ),
                        )))
                    .toList(),
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
                      padding: EdgeInsets.only(top: 4),
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
                              padding:
                                  const EdgeInsets.only(top: 8.0, left: 25),
                              child: Container(
                                height: 16,
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
              IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(Icons.sort),
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
                            padding: const EdgeInsets.all(4.0),
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
                                                    BorderRadius.circular(10)),
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
                                              setState(() {
                                                type = filter[index];
                                              });
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
                  })
            ],
          ),
          body: TabBarView(
            children: attributeList.map((e) {
              print("index name ${e.categoryValue}");
              return FutureBuilder(
                  future: apiService.getProductAttribute(capId: e.categoryId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Product> products = snapshot.data;
                      return ShowProducts(
                        productList: products,
                        type: type,
                        cartItems: cartItems,
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  });
            }).toList(),
          ),
        ),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}

class ShowProducts extends StatefulWidget {
  final List<Product> productList;
  List<CartItem> cartItems;
  String type;
  ShowProducts({this.productList, this.type, this.cartItems});
  @override
  _ShowProductsState createState() => _ShowProductsState();
}

class _ShowProductsState extends State<ShowProducts> {
  //sort Products
  void sortproducts({List<Product> productList, String type}) {
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
        productList.sort((b, a) => double.parse(
              a?.slPrc,
            ).compareTo(double.parse(b?.slPrc ?? '0')));
      });
    }
    if (type == 'Price Low to High') {
      setState(() {
        productList.sort((a, b) => double.parse(a?.slPrc ?? '0')
            .compareTo(double.parse(b?.slPrc ?? '0')));
      });
    }
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
  void initState() {
    super.initState();
    sortproducts(productList: widget.productList, type: widget.type);
  }

  @override
  Widget build(BuildContext context) {
    sortproducts(productList: widget.productList, type: widget.type);
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width *
              0.5 /
              (MediaQuery.of(context).size.height * .39),
        ),
        itemCount: widget.productList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ProductCard(
              product: widget.productList[index],
              cartItems: widget.cartItems,
            ),
          );
        });
  }
}
