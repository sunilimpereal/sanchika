import 'package:flutter/material.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';

class Categories extends StatefulWidget with NavigationStates {
  final Function onMenuTap;

  const Categories({Key key, this.onMenuTap}) : super(key: key);
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: InkWell(
            child: Icon(Icons.menu, color: Colors.black),
            onTap: widget.onMenuTap,
          ),
          title: Text(
            "Categories",
            style: TextStyle(color: Colors.black),
          ),
          actions: [],
        ),
        body: Container(
          child: Column(
            children: [
              // first row
              Container(
                padding: EdgeInsets.all(8),
                height: MediaQuery.of(context).size.height * 0.15,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryCard(
                      name: 'PROCESSED FOOD',
                      img: 'assets/images/processedfood.png',
                    ),
                    CategoryCard(
                      name: 'BEVERAGES',
                      img: 'assets/images/bevrage.png',
                    ),
                    CategoryCard(
                      name: 'HOME CARE',
                      img: 'assets/images/home care.png',
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                height: MediaQuery.of(context).size.height * 0.15,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CategoryCard(
                      name: 'PERSONAL CARE',
                      img: 'assets/images/skincare.png',
                    ),
                    CategoryCard(
                      name: 'STATIONARY',
                      img: 'assets/images/stationary.png',
                    ),
                    CategoryCard(
                      name: 'CEREALS',
                      img: 'assets/images/cereal.png',
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                height: MediaQuery.of(context).size.height * 0.15,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CategoryCard(
                      name: 'COOKING MEDIUM',
                      img: 'assets/images/cooking.jpg',
                    ),
                    CategoryCard(
                      name: 'SPICES DRYFRUITS',
                      img: 'assets/images/dry.png',
                    ),
                    CategoryCard(
                      name: 'SALT JAGGERY',
                      img: 'assets/images/processedfood.png',
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                height: MediaQuery.of(context).size.height * 0.15,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CategoryCard(
                      name: 'HOUSEHOLD',
                      img: 'assets/images/household.jpg',
                    ),
                    CategoryCard(
                      name: 'PLASTICS',
                      img: 'assets/images/plastic.jpg',
                    ),
                    CategoryCard(
                      name: 'COOKERY',
                      img: 'assets/images/processedfood.png',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String name;
  final String img;

  const CategoryCard({Key key, this.name, this.img}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15 - 8,
      width: MediaQuery.of(context).size.width * 0.3,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(3.0, 2.0),
            color: Colors.grey[200],
            blurRadius: 3.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.15 - 40,
            decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                    image: AssetImage(img), fit: BoxFit.contain)),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            child: Center(
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
