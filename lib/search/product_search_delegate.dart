import 'package:flutter/material.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/services/api_service.dart';

class ProductSearch extends SearchDelegate<Product> {
  APIService apiService = new APIService();
  Future getProductListHo() async {
    List<Product> productList =
        await apiService.getProductList(apiService.getProducts());
    print('i am home');
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
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: Colors.red,
      height: 200,
      width: 200,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: getProductListHo(),
      builder: (BuildContext context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text('No results'),
          );
        }
        List<Product> productList = snapshot.data;
        final results =
            productList.where((a) => a.name.toLowerCase().startsWith(query));
        return ListView(
          children: results.map<Widget>((a) => Text(a.name)).toList(),
        );
      },
    );
  }
}
