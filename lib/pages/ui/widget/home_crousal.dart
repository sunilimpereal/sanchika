import 'package:flutter/material.dart';
import 'package:sanchika/model/getBanner_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeCrousal extends StatelessWidget {
  List<BannerMaster> banners;
  HomeCrousal({this.banners});
  @override
  Widget build(BuildContext context) {
     Map<String, String> headerList = {
    "Content-Type": "application/json",
    "Accept": "*/*",
    "Accept-Encoding": "gzip, deflate, br",
    "Connection": "keep-alive",
    "Transfer-Encoding": "chunked",
    "Keep-Alive": "timeout=0",
    "Vary":"Origin",
    "Vary":"Access-Control-Request-Method",
    "Vary":"Access-Control-Request-Headers",
     
  };
    return Row(
      children: [
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.4,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                cacheExtent: 10000000,
                  addAutomaticKeepAlives: true,
              controller: ScrollController(),
                itemCount: banners.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.4,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(banners[index].webImageUrl,headers: headerList),
                              fit: BoxFit.cover,
                              onError: (context, error) {
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    child: Center(
                                        child: CircularProgressIndicator()));
                              })),
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }
}
