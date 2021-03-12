import 'package:flutter/material.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/pages/ui/screens/cart.dart';
import 'package:sanchika/pages/ui/widget/product_card.dart';

class ProcessedFood extends StatefulWidget {
  @override
  ProcessedFoodState createState() => ProcessedFoodState();
}

class ProcessedFoodState extends State<ProcessedFood> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
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
            'Prodcessed Food',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(30.0),
            child: TabBar(
              isScrollable: true,
              unselectedLabelColor: Colors.black.withOpacity(0.3),
              tabs: [
                Tab(
                  child: Text(
                    'Breakfast',
                    style: TextStyle(
                      color: Color(0xff0B3666),
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Bevrages',
                    style: TextStyle(
                      color: Color(0xff0B3666),
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Homecare',
                    style: TextStyle(
                      color: Color(0xff0B3666),
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Avacados',
                    style: TextStyle(
                      color: Color(0xff0B3666),
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Plums & Apricots',
                    style: TextStyle(
                      color: Color(0xff0B3666),
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Tab 6',
                    style: TextStyle(
                      color: Color(0xff0B3666),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Breakfast(),
            Breakfast(),
            Breakfast(),
            Breakfast(),
            Breakfast(),
            Breakfast(),
          ],
        ),
      ),
    );
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
                // ProductCard(product: product2),
              ],
            ),
        
          ],
        ),
      ),
    );
  }
}
