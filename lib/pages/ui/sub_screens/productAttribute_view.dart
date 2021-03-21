import 'package:flutter/material.dart';
import 'package:sanchika/model/CtgAttribute.dart';
import 'package:sanchika/model/getCatg_model.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/pages/ui/widget/product_card.dart';
import 'package:sanchika/services/api_service.dart';

class ProductAttribute extends StatefulWidget {
  final CategoryAttribute categoryAttribute;
  final CtgyNameAndId ctgyNameAndId;
  ProductAttribute({this.categoryAttribute, this.ctgyNameAndId});
  @override
  _ProductAttributeState createState() => _ProductAttributeState();
}

class _ProductAttributeState extends State<ProductAttribute> {
  int index;
  List<CategoryAttribute> attributeList;
  CategoryAttribute cat;

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

  @override
  void initState() {
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
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.ctgyNameAndId.ctgyNm,
                  style: TextStyle(color: Color(0xff0B3666)),
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(30.0),
              child: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.yellow,
                indicatorColor:Color(0xff0B3666).withAlpha(180),
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
          ),
          body: TabBarView(
            children: attributeList.map((e) {
              print("index name ${e.categoryValue}");
              return ShowProducts(categoryAttribute: e);
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
  final CategoryAttribute categoryAttribute;
  ShowProducts({this.categoryAttribute});
  @override
  _ShowProductsState createState() => _ShowProductsState();
}

class _ShowProductsState extends State<ShowProducts> {
  Future<List<Product>> productAttributeList;
  Future<List<Product>> getproductAttribute(String capID) async {
    APIService apiService = APIService();
    List<Product> productList =
        await apiService.getProductAttribute(capId: capID);
    return productList;
  }

  @override
  void initState() {
    super.initState();
    productAttributeList =
        getproductAttribute(widget.categoryAttribute.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: productAttributeList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Product> productList = snapshot.data;
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width *
                    0.5 /
                    (MediaQuery.of(context).size.height * .37),
              ),
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ProductCard(product: productList[index]),
                );
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
