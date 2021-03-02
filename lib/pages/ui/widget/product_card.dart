import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/pages/ui/widget/crousal.dart';
import 'package:sanchika/pages/ui/widget/product_view.dart';
import 'package:translator/translator.dart';

class Productcard extends StatefulWidget {
  Product product;
  final translator = GoogleTranslator();
  Function onMenuItemClicked;
  Productcard({this.product, this.onMenuItemClicked});

  @override
  _ProductcardState createState() => _ProductcardState();
}

class _ProductcardState extends State<Productcard> {
  String _selectedValue;
  String nameml = '';
  @override
  void initState() {
    super.initState();
    final translator = GoogleTranslator();
    translator.translate(widget.product.name, to: 'ml').then((result) {
      setState(() {
        nameml = result.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(nameml);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductView(
                    product: widget.product,
                    onMenuItemClicked: widget.onMenuItemClicked,
                  )),
        );
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(8.0),
              height: MediaQuery.of(context).size.height * .35,
              width: MediaQuery.of(context).size.width * 0.43,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Hero(
                    tag: 'image' + widget.product.name,
                    child: Container(
                      height: MediaQuery.of(context).size.height * .28 * 0.5,
                      width: MediaQuery.of(context).size.width * 0.45 - 5,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, bottom: 0.0),
                        child: Stack(children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              image: DecorationImage(
                                  image: AssetImage(widget.product.images[0]),
                                  fit: BoxFit.contain),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.maxFinite,
                    child: Text(
                      nameml,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      // Text(
                      //   widget.product.type == null ? '' : widget.product.type,
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     fontFamily: 'Poppins',
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '₹${widget.product.price}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          price1(widget.product.price1),
                        ],
                      ),
                      dropdown(),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          width: 134,
                          height: 38,
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Color(0xff0B3666).withOpacity(0.9),
                              borderRadius: BorderRadius.circular(50)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                " ADD ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Icon(
                                Icons.add_shopping_cart_rounded,
                                size: 18,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          discount(widget.product.discount),
          Positioned(
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: FavoriteButton(
                iconSize: 28,
                valueChanged: (_) {},
              ),
            ),
          )
        ],
      ),
    );
  }

  Container dropdown() {
    if (widget.product.type == null || widget.product.typeList == null) {
      return Container();
    } else {
      List<String> _typeList = widget.product.typeList;
      _selectedValue = widget.product.typeList[0];
      return Container(
        child: Center(
          child: DropdownButton<String>(
            value: _selectedValue,
            items: _typeList.map((String value) {
              return new DropdownMenuItem(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _selectedValue = newValue;
              });
            },
            dropdownColor: Colors.grey[200],
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
      );
    }
  }

  Text price1(int price1) {
    if (price1 != null) {
      return Text(
        '₹${widget.product.price1}',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.normal,
          decoration: TextDecoration.lineThrough,
        ),
      );
    } else {
      return Text('');
    }
  }

  discount(int discount) {
    if (widget.product.discount != null) {
      return Positioned(
        top: 10,
        left: 10,
        child: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(5),
                topLeft: Radius.circular(15),
                bottomRight: Radius.circular(10)),
            color: Colors.red[600],
          ),
          child: Text(
            '${discount}% Off',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  String translate(String text) {
    final translator = GoogleTranslator();
    translator.translate(text, to: 'ml').then((result) {
      print('result');
      print(result);
      return result.text;
    });
  }
}
