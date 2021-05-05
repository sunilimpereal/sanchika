import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';
import 'package:sanchika/localization/localization_methods.dart';
import 'package:sanchika/model/getOfferByCustId.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/pages/ui/widget/product_card.dart';
import 'package:sanchika/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

enum OfferType {
  rsOff,
  percentOff,
  fixPrice,
  free,
}

class Offers extends StatefulWidget with NavigationStates {
  final Function onMenuTap;
  final Function onMenuItemClicked;

  const Offers({Key key, this.onMenuTap, this.onMenuItemClicked})
      : super(key: key);
  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  String custId;
  void getCustId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      custId = sharedPreferences.getString('custId');
    });
  }

  List<OfferItem> filterOffers(
      {List<OfferItem> offeritemList, OfferType offerType}) {
    if (offerType == OfferType.rsOff) {
      return offeritemList.where((element) => element.offerType == "Rs Off").toList();
    }
    if (offerType == OfferType.free) {
      return offeritemList.where((element) => element.offerType == "Free").toList();
    }
    if (offerType == OfferType.percentOff) {
      return offeritemList.where((element) => element.offerType == "% Off").toList();
    }
    if (offerType == OfferType.fixPrice) {
      return offeritemList.where((element) => element.offerType == "Fixed Price").toList();
    }
    return [];
  }

  APIService apiService;
  @override
  void initState() {
    apiService = new APIService();
    super.initState();
    getCustId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: InkWell(
            child: Icon(Icons.menu, color: Colors.black),
            onTap: widget.onMenuTap,
          ),
          title: Text(
            getTranslated(context, "Offers"),
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              padding: EdgeInsets.only(top: 8),
              icon: Icon(
                Icons.favorite_rounded,
                color: Colors.grey[800],
                size: 24,
              ),
              onPressed: () {
                BlocProvider.of<NavigationBloc>(context)
                    .add(NavigationEvents.WishlistClickedEvent);
                widget.onMenuItemClicked();
              },
            ),
            IconButton(
              padding: EdgeInsets.only(top: 8),
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.grey[800],
                size: 26,
              ),
              onPressed: () {
                BlocProvider.of<NavigationBloc>(context)
                    .add(NavigationEvents.CartClickedEvent);
                widget.onMenuItemClicked();
              },
            )
          ],
        ),
        body: FutureBuilder(
          future: apiService.getOffersBycustId('6'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<OfferItem> offeritems = snapshot.data;
              print('filter offers ${filterOffers(
                          offeritemList: offeritems,
                          offerType: OfferType.fixPrice)}');
              return Column(
                children: [
                  showOffer(
                      title: "hello",
                      offerItem: filterOffers(
                          offeritemList: offeritems,
                          offerType: OfferType.fixPrice))
                ],
              );
            } else {
              return Container();
            }
          },
        ));
  }

  Widget showOffer({String title, List<OfferItem> offerItem}) {
    return Container(
      child: Column(
        children: [
          Text(title),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .38,
                  child: ListView.builder(
                    cacheExtent: 10000.0,
                    dragStartBehavior: DragStartBehavior.start,
                    addAutomaticKeepAlives: true,
                    controller: ScrollController(),
                    scrollDirection: Axis.horizontal,
                    itemCount: offerItem.length,
                    itemBuilder: (context, index) {
                      print('wishlist in builder');
                      return Container(
                          child: FutureBuilder(
                        future: apiService.getProductDetail(
                            productId: offerItem[index].productId),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            Product product = snapshot.data[0];
                            return ProductCard(
                              product: product,
                              // wishlist: wishlist,
                              // cartItems: cartItems,
                              // reload: reload,
                            );
                          } else {
                            //Shimmer loading
                            return Container(
                              height: MediaQuery.of(context).size.height * .35,
                              width: MediaQuery.of(context).size.width * 0.43,
                              color: Colors.white,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Shimmer.fromColors(
                                          baseColor: Colors.grey[300],
                                          highlightColor: Colors.white,
                                          period: Duration(milliseconds: 1000),
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .28 *
                                                0.5,
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.45 -
                                                5,
                                            color: Colors.grey,
                                          )),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Shimmer.fromColors(
                                              baseColor: Colors.grey[300],
                                              highlightColor: Colors.white,
                                              period:
                                                  Duration(milliseconds: 1000),
                                              child: Container(
                                                height: 20,
                                                width: 110,
                                                color: Colors.grey,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Shimmer.fromColors(
                                              baseColor: Colors.grey[300],
                                              highlightColor: Colors.white,
                                              period:
                                                  Duration(milliseconds: 1000),
                                              child: Container(
                                                height: 20,
                                                width: 50,
                                                color: Colors.grey,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Shimmer.fromColors(
                                              baseColor: Colors.grey[300],
                                              highlightColor: Colors.white,
                                              period:
                                                  Duration(milliseconds: 1000),
                                              child: Container(
                                                height: 20,
                                                width: 50,
                                                color: Colors.grey,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      )
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child:
                          //   Container(
                          //     width: 100,
                          //     height: 100,
                          //     color: Colors.red,
                          //   ),
                          // )
                          );
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
