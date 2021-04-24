import 'package:flutter/material.dart';
import 'package:sanchika/model/getCatg_model.dart';
import 'package:sanchika/model/topMenu_model.dart';
import 'package:sanchika/pages/ui/sub_screens/subMenuPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';

class CategoryHomeCard extends StatefulWidget {
  CtgyNameAndId ctgyNameAndId;
  Color color;

  CategoryHomeCard({Key key, this.ctgyNameAndId, this.color}) : super(key: key);

  @override
  _CategoryHomeCardState createState() => _CategoryHomeCardState();
}

class _CategoryHomeCardState extends State<CategoryHomeCard> {
  void translate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final translator = GoogleTranslator();
    translator.translate(widget.ctgyNameAndId.ctgyNm, to: 'ml').then((result) {
      setState(() {
        if (preferences.getString('language') == 'malayalam') {
          widget.ctgyNameAndId.ctgyNm = result.text;
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
                        "http://sanchika.in:8082/sanchika/img/testing/dept/${widget.ctgyNameAndId.mnId}.png"),
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
                    widget.ctgyNameAndId.ctgyNm,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: widget.color ?? Colors.black),
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
