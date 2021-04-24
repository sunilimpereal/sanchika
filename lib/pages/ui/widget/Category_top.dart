import 'package:flutter/material.dart';
import 'package:sanchika/model/CtgAttribute.dart';
import 'package:sanchika/model/getCatg_model.dart';
import 'package:sanchika/pages/ui/screens/categories/productAttribute_view.dart';
import 'package:sanchika/pages/ui/widget/categories_home_card.dart';
import 'package:sanchika/services/api_service.dart';
import 'dart:math';

class Category_top extends StatefulWidget {
  List<CtgyNameAndId> ctgNameandId;
  Category_top({this.ctgNameandId});
  @override
  _Category_topState createState() => _Category_topState();
}

class _Category_topState extends State<Category_top> {
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
        subCategory(activeCtg)
      ],
    );
  }

  Widget subCategory(CtgyNameAndId ctgyNameAndId) {
    print('Get ctg Aaaa ${activeCtg.mnId}');
    return Container(
      child: FutureBuilder(
          future: apiService.getCategoryAttribute(ctgyNameAndId.mnId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print('height ${(snapshot.data.length / 3).ceil()}');
              return SizedBox(
                height: 70,
                // height: (MediaQuery.of(context).size.height * .20) *
                //         ((snapshot.data.length / 3).ceil()) +
                //     8,
                child: ListView.builder(
                    cacheExtent: 100000,
                    shrinkWrap: false,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      CategoryAttribute ctgAttr = snapshot.data[index];
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductAttribute(
                                        categoryAttribute: ctgAttr,
                                        ctgyNameAndId: ctgyNameAndId,
                                      )),
                            );
                          },
                          child: card(categoryAttribute: ctgAttr));
                    }),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }

  Widget card({CategoryAttribute categoryAttribute}) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(1.0, 1.0),
                color: Colors.grey[300],
                blurRadius: 1.0,
                spreadRadius: 0.2,
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.4 * 0.4,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(
                        'http://sanchika.in:8082/sanchika/img/testing/dept/${categoryAttribute.categoryId}.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5.0),
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    categoryAttribute.categoryValue,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}