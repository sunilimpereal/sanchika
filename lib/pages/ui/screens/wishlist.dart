import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';
import 'package:sanchika/localization/localization_methods.dart';
import 'package:sanchika/model/wishlist.dart';
import 'package:sanchika/services/api_service.dart';

class Wishlist extends StatefulWidget with NavigationStates {
  const Wishlist({Key key, this.onMenuTap, this.onMenuItemClicked})
      : super(key: key);

  final Function onMenuItemClicked;
  final Function onMenuTap;

  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {
    Future<List<WishListItem>> getWishlist() async {
      APIService apiService = new APIService();
      List<WishListItem> allWishlistItems = await apiService.getWishList();
      print(allWishlistItems);
      return allWishlistItems;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          getTranslated(context, "Wishlist"),
          style: TextStyle(color: Colors.black),
        ),
        leading: InkWell(
          child: Icon(Icons.menu, color: Colors.black),
          onTap: widget.onMenuTap,
        ),
        actions: [
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
                  BlocProvider.of<NavigationBloc>(context)
                      .add(NavigationEvents.CartClickedEvent);
                  widget.onMenuItemClicked();
                },
              ),
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
      ),
      body: Container(
          child: FutureBuilder(
        future: getWishlist(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                WishListItem item = snapshot.data[index];
                return Column(
                  children: [
                    Text(item.productId),
                    Text("${item.userId}"),
                    Text(item.status ?? ''),
                  ],
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )

          //PLACE HOLDER
          // child: Column(
          //   children: [
          //     WishlistCard(
          //       product: product0,
          //     ),
          //     SizedBox(
          //       height: 1,
          //     ),
          //     WishlistCard(
          //       product: product1,
          //     ),
          //   ],
          // ),
          ),
    );
  }
}
