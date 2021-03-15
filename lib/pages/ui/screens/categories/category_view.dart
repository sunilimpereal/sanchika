import 'package:flutter/material.dart';
import 'package:sanchika/model/cat_product_model.dart';
import 'package:sanchika/pages/ui/widget/productcatCard.dart';
import 'package:sanchika/services/api_service.dart';

class CategoryView extends StatefulWidget {
  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
 
      Future<List<CtgyProductDetailsList>> getCtgProduct() async {
        print('product getting');
      APIService apiService = new APIService();
      List<CtgyProductDetailsList> products = await apiService.getCtegoryProducts();
      print(products);
      return products;
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: getCtgProduct(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {

            List<CtgyProductDetailsList> productsl = snapshot.data;
             List<CtgyProductDetailsList> products = productsl.sublist(1,200);
             print(products.length);
            return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  CtgyProductDetailsList product = snapshot.data[index];
                  return Container(
                    child:ProductCatCard(product: product,),
                  );
                });
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
