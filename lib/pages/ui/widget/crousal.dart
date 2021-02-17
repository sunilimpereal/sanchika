import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';

class Crousal extends StatefulWidget {
  final List<String> photos;
  Crousal({this.photos});
  @override
  _CrousalState createState() => _CrousalState();
}

class _CrousalState extends State<Crousal> {
  int photoIndex = 0;

  void _previousImage() {
    setState(() {
      photoIndex = photoIndex > 0 ? photoIndex - 1 : 0;
    });
  }

  void _nextImage() {
    setState(() {
      photoIndex =
          photoIndex < widget.photos.length - 1 ? photoIndex + 1 : photoIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
                        image: AssetImage(widget.photos[photoIndex]),
                        fit: BoxFit.contain),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                child: Container(
                  child: SelectedPhoto(
                    numberOfDots: widget.photos.length,
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
              color: Colors.grey[500],
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
            color: Colors.grey[600],
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
