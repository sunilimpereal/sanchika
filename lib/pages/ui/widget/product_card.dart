import 'package:flutter/material.dart';

class Productcard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(8.0),
        height: MediaQuery.of(context).size.height * 0.30,
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.blue.withOpacity(.2),
                  offset: Offset(0, 0),
                  blurRadius: 4,
                  spreadRadius: 3)
            ]),
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Container(
                color: Colors.white,
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  color: Colors.blue,
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            Text(
                              "hello",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 0,
                        ),
                        Row(
                          children: [
                            Text(
                              "\$400 ",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
