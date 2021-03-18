import 'package:flutter/material.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/model/subMenu_model.dart';
import 'package:sanchika/model/topMenu_model.dart';
import 'package:sanchika/pages/ui/screens/cart.dart';
import 'package:sanchika/pages/ui/widget/product_card.dart';
import 'package:sanchika/services/api_service.dart';

class SubMenuPage extends StatefulWidget {
  final TopMenu topMenu;
  SubMenuPage({this.topMenu});
  @override
  SubMenuPageState createState() => SubMenuPageState();
}

class SubMenuPageState extends State<SubMenuPage> {
  List<SubMenu> subMenuList;

  Future<List<SubMenu>> getSubMenu() async {
    APIService apiService = APIService();
    await apiService
        .getSubMenu(widget.topMenu.menuId, widget.topMenu.menuTitle)
        .then((value) {
      setState(() {
        subMenuList = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getSubMenu();
  }

  @override
  Widget build(BuildContext context) {
    print(subMenuList);
    if(subMenuList!=null){
    return DefaultTabController(
      length: subMenuList.length,
      child: Scaffold(
        appBar: AppBar(
        
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.filter_list),
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
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0.5,
          backgroundColor: Colors.white,
          title: Text(
            widget.topMenu.menuTitle,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(30.0),
            child: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.black.withOpacity(0.3),
                tabs: subMenuList
                    .map((item) => Tab(
                            child: Text(
                          item.menuTitle,
                          style: TextStyle(
                            color: Color(0xff0B3666),
                          ),
                        )))
                    .toList(),),
          ),
        ),
        body: TabBarView(
          children: subMenuList.map((e) => Breakfast()).toList(),
        ),
      ),
    );
  }else{
    return Scaffold(
      body:  Center(child: CircularProgressIndicator()),
    );
   
  }
  }
}

class Breakfast extends StatefulWidget {
  @override
  _BreakfastState createState() => _BreakfastState();
}

class _BreakfastState extends State<Breakfast> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                // ProductCard(product: product1),
                // ProductCard(product: product2),w
              ],
            ),
          ],
        ),
      ),
    );
  }
}
