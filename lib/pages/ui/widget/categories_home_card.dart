import 'package:flutter/material.dart';

class CategoryHomeCard extends StatelessWidget {
  final String name;
  final String image;

  const CategoryHomeCard({Key key, this.name, this.image}) : super(key: key);
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
                    image: AssetImage(image),
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
                name,
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
