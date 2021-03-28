import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sanchika/model/getBanner_model.dart';
import 'package:swipedetector/swipedetector.dart';

class HomeCrousal extends StatefulWidget {
  List<BannerMaster> banners;
  HomeCrousal({this.banners});

  @override
  _HomeCrousalState createState() => _HomeCrousalState();
}

class _HomeCrousalState extends State<HomeCrousal> {
  int photoIndex = 0;

  void _previousImage() {
    setState(() {
      photoIndex = photoIndex > 0 ? photoIndex - 1 : 0;
    });
  }

  void _nextImage() {
    setState(() {
      photoIndex =
          photoIndex < widget.banners.length - 1 ? photoIndex + 1 : photoIndex;
    });
  }

  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(Duration(seconds: 15), (Timer t) => autoNext());
  }

  void autoNext() {
    print(DateTime.now());

    if (photoIndex == widget.banners.length - 1) {
      print('begin');
      setState(() {
        photoIndex = 0;
      });
    } else {
      _nextImage();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> headerList = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Connection": "keep-alive",
      "Transfer-Encoding": "chunked",
      "Keep-Alive": "timeout=0",
      "Vary": "Origin",
      "Vary": "Access-Control-Request-Method",
      "Vary": "Access-Control-Request-Headers",
    };
    return Row(
      children: [
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.4,
            child: SwipeDetector(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 28.0),
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  widget.banners[photoIndex].mobileImageUrl),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      child: Container(
                        child: SelectedPhoto(
                          numberOfDots: widget.banners.length,
                          photoIndex: photoIndex,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              onSwipeLeft: () {
                _nextImage();
                print("next");
              },
              onSwipeRight: () {
                _previousImage();
                print("previous");
              },
            ),
          ),
        )
      ],
    );
  }
}

class SelectedPhoto extends StatelessWidget {
  final int numberOfDots;
  final int photoIndex;

  const SelectedPhoto({Key key, this.numberOfDots, this.photoIndex})
      : super(key: key);
  Widget _inactivePhoto() {
    return Container(
      child: new Padding(
        padding: EdgeInsets.only(left: 3.0, right: 3.0),
        child: Container(
          height: 6.0,
          width: 6.0,
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(3.0)),
        ),
      ),
    );
  }

  Widget _activePhoto() {
    return Container(
      child: new Padding(
        padding: EdgeInsets.only(left: 3.0, right: 3.0),
        child: Container(
          height: 8.0,
          width: 8.0,
          decoration: BoxDecoration(
            color: Color(0xff032e6b).withOpacity(0.8),
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDots() {
    List<Widget> dots = [];
    for (var i = 0; i < (numberOfDots); i++) {
      dots.add(i == photoIndex ? _activePhoto() : _inactivePhoto());
    }
    return dots;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildDots(),
      ),
    );
  }
}
