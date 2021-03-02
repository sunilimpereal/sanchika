import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';

class CategoryHomeCard extends StatefulWidget {
  String name;
  String image;

  CategoryHomeCard({Key key, this.name, this.image}) : super(key: key);

  @override
  _CategoryHomeCardState createState() => _CategoryHomeCardState();
}

class _CategoryHomeCardState extends State<CategoryHomeCard> {
  void translate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final translator = GoogleTranslator();
    translator.translate(widget.name, to: 'ml').then((result) {
      setState(() {
        if (preferences.getString('language') == 'malayalam') {
          widget.name = result.text;
        } else {}
      });
    });
  }

  @override
  void initState() {
    super.initState();
    translate();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(1.0, 1.0),
              color: Colors.grey[100],
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
              ),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.image),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.4 * 0.6,
              decoration: BoxDecoration(),
              child: Center(
                  child: Text(
                widget.name,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}
