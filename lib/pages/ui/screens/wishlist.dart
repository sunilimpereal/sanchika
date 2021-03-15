import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';
import 'package:sanchika/localization/localization_methods.dart';
import 'package:sanchika/model/wishlist_model.dart';
import 'package:sanchika/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rive/rive.dart';
import 'package:flutter/services.dart';

class Wishlist extends StatefulWidget with NavigationStates {
  const Wishlist({Key key, this.onMenuTap, this.onMenuItemClicked})
      : super(key: key);

  final Function onMenuItemClicked;
  final Function onMenuTap;

  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  String userId;
  Future<String> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String uid = preferences.getString('userId');
    setState(() {
      userId = uid;
    });
  }
    Artboard _riveArtboard;
  RiveAnimationController _controller;

  @override
  void initState() {
    super.initState();
    getUserId();
    print(userId);
      rootBundle.load('assets/rive/wishlist.riv').then((value) async{
      final file =RiveFile();
      if(file.import(value)){
        final artboard = file.mainArtboard;
        artboard.addController(_controller = SimpleAnimation('Animation 1'));
        setState(() {
          _riveArtboard = artboard;
          _controller.isActive = true ;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<List<WishlistItem>> getWishlist(String userId) async {
      APIService apiService = new APIService();
      List<WishlistItem> allWishlistItems =
          await apiService.getWishList(userId: userId);
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
        future: getWishlist(userId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length != 0) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  WishlistItem item = snapshot.data[index];
                  return Column(
                    children: [
                      Text(item.productId),
                      Text("${item.userId}"),
                      Text(''),
                    ],
                  );
                },
              );
            } else {
              return Center(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                        Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Container(
                height: 250,
                child: _riveArtboard == null? const SizedBox():Rive(artboard: _riveArtboard,fit: BoxFit.contain,)),
            ),
                      Text('No Items In Wishlist',
                      style: TextStyle(
                        color: Colors.blue.shade400,
                        fontSize: 27,
                        fontWeight: FontWeight.w600,
                      ),
                      ),
                      SizedBox(height:10),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Explore More'),
                      )
                    ],
                  ),
                ),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )
          ),
    );
  }
}
