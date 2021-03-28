import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';
import 'package:sanchika/model/CtgAttribute.dart';
import 'package:sanchika/model/getCatg_model.dart';
import 'package:sanchika/pages/ui/screens/categories/productAttribute_view.dart';
import 'package:sanchika/pages/ui/widget/categories_home_card.dart';
import 'package:sanchika/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Categories extends StatefulWidget with NavigationStates {
  final Function onMenuTap;
  final Function onMenuItemClicked;
  const Categories({Key key, this.onMenuTap, this.onMenuItemClicked})
      : super(key: key);
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  APIService apiService;
  String userId;
  Color color;
  CtgyNameAndId activeCtg;

  void getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      userId = preferences.getString('userId');
    });
  }

  //get Top Menu
  Future<List<CtgyNameAndId>> ctgNameandId;
  Future<List<CtgyNameAndId>> getCtgNameandId() async {
    List<CtgyNameAndId> topMenulist = await apiService.getCatg();
    setState(() {
      activeCtg = topMenulist[1];
    });
    return topMenulist;
  }

  @override
  void initState() {
    super.initState();
    getUserId();
    apiService = APIService();
    ctgNameandId = getCtgNameandId();
    color = Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
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
        elevation: 0,
        title: Text(
          'Categories',
          style: TextStyle(
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
      body: Column(
        children: [
          SizedBox(height: 10),
          FutureBuilder(
              future: ctgNameandId,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Category_disp(ctgNameandId: snapshot.data);
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ],
      ),
    );
  }

}

class Category_disp extends StatefulWidget {
  List<CtgyNameAndId> ctgNameandId;
  Category_disp({this.ctgNameandId});
  @override
  _Category_dispState createState() => _Category_dispState();
}

class _Category_dispState extends State<Category_disp> {
  CtgyNameAndId activeCtg;
  Color color;
  APIService apiService;
  void initState() {
    super.initState();
    apiService = APIService();
    setState(() {
      activeCtg = widget.ctgNameandId[1];
      color = Colors.red;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: SizedBox(
                    height: 70,
                    child: ListView.builder(
                        addAutomaticKeepAlives: true,
                        controller: ScrollController(),
                        scrollDirection: Axis.horizontal,
                        cacheExtent: 10000,
                        itemCount: widget.ctgNameandId.length,
                        itemBuilder: (context, index) {
                          CtgyNameAndId ctgItem = widget.ctgNameandId[index];
                          Color color(CtgyNameAndId ctg) {
                            if (activeCtg == ctgItem) {
                              return Colors.blue;
                            } else {
                              return Colors.black;
                            }
                          }

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                activeCtg = widget.ctgNameandId[index];
                              });
                            },
                            child: CategoryHomeCard(
                              ctgyNameAndId: ctgItem,
                              color: color(ctgItem),
                            ),
                          );
                        })))
          ],
        ),
        SubCategory(ctgyNameAndId: activeCtg,)
      ],
    );
  }
}
class SubCategory extends StatefulWidget {
 final CtgyNameAndId ctgyNameAndId;
  SubCategory({this.ctgyNameAndId});

  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  APIService apiService;
  @override
  void initState() {
    super.initState();
    apiService = APIService();
  }

  void reload() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('Get ctg Aaaa ${widget.ctgyNameAndId.mnId}');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: FutureBuilder(
            future: apiService.getCategoryAttribute(widget.ctgyNameAndId.mnId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print('height ${(snapshot.data.length / 3).ceil()}');
                return Container(
                  height: (MediaQuery.of(context).size.height * .20) *
                          ((snapshot.data.length / 3).ceil()) +
                      8,
                  child: GridView.builder(
                      cacheExtent: 100000,
                      shrinkWrap: false,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: MediaQuery.of(context).size.width *
                            0.5 /
                            (MediaQuery.of(context).size.height * .24),
                      ),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        CategoryAttribute ctgAttr = snapshot.data[index];
                        return Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: GestureDetector(
                            onTap: (){
                                Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductAttribute(
                                          categoryAttribute: ctgAttr,
                                          ctgyNameAndId: widget.ctgyNameAndId,
                                        )),
                              );
                            },
                            child: CategoryCard(categoryAttribute: ctgAttr)),
                        );
                      }),
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
 final  CategoryAttribute categoryAttribute;

  const CategoryCard({this.categoryAttribute});
  @override
  Widget build(BuildContext context) {
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
                      image: NetworkImage('http://sanchika.in:8082/sanchika/img/testing/dept/${categoryAttribute.categoryId}.png'), fit: BoxFit.contain)),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
               width: MediaQuery.of(context).size.width * 0.3,
              child: Center(
                child: Text(
                  categoryAttribute.categoryValue,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
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
