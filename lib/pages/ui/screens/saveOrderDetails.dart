import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:sanchika/model/userOrderDetails.dart';
import 'package:sanchika/services/api_service.dart';
import 'package:sanchika/utils/StateCity.dart';

class SaveUserOrderdetail extends StatefulWidget {
  @override
  _SaveUserOrderdetailState createState() => _SaveUserOrderdetailState();
}

class _SaveUserOrderdetailState extends State<SaveUserOrderdetail> {
  OrderuserDetailsRequestModel orderuserDetailsRequestModel;
  APIService apiService;
  AutoCompleteTextField stateFeild;
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  AutoCompleteTextField cityFeild;
  GlobalKey<AutoCompleteTextFieldState<String>> keyCity = new GlobalKey();
  Recomendation recomendations;
  @override
  var _stateHints;
  var _cityHints;
  void initState() {
    // TODO: implement initState
    super.initState();
    apiService = APIService();
    recomendations = Recomendation();
    _stateHints = recomendations.stateHints;
    _cityHints = recomendations.city;
  }

  Widget recomendation(text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ),
        SizedBox(width: 10.0)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Shipping Details',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
                  child: Column(
            children: [
              //Name
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width * 0.5 - 15,
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                            labelText: 'Name*',
                            hintText: 'Name'),
                      ),
                    ),
                    Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width * 0.5 - 15,
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                            labelText: 'Last Name*',
                            hintText: 'Name'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              //Number
              Container(
                height: 45,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      labelText: 'Number*',
                      hintText: 'Number',
                      ),
                      onChanged: (value){
                        setState(() {
                          orderuserDetailsRequestModel.mobile = value.toString();
                        });
                      }
                ),
              ),
              SizedBox(height: 15),
              //Pincode
              Row(
                children: [
                  Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width * 0.5 - 15,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          labelText: 'Pincode*',
                          hintText: 'Pincode'),
                          onChanged: (value){
                            setState(() {
                              orderuserDetailsRequestModel.pin=value.toString();
                            });
                          },
                    ),
                  ),
                ],
              ), //
              SizedBox(height: 15),
              //state
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width * 0.5 - 15,
                      child: stateFeild = AutoCompleteTextField<String>(
                        clearOnSubmit: false,
                        key: key,
                        suggestions: _stateHints,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                            labelText: 'State*',
                            hintText: 'State'),
                        itemFilter: (item, query) {
                          return item
                              .toLowerCase()
                              .startsWith(query.toLowerCase());
                        },
                        itemSorter: (a, b) {
                          return a.compareTo(b);
                        },
                        itemSubmitted: (item) {
                          setState(() {
                            stateFeild.textField.controller.text = item;
                          });
                          setState(() {
                            
                          });
                        },
                        itemBuilder: (context, item) {
                          return recomendation(item);
                        },
                      )),
                  //City
                  Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width * 0.5 - 15,
                      child: cityFeild = AutoCompleteTextField<String>(
                        clearOnSubmit: false,
                        key: keyCity,
                        suggestions: _cityHints,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                            labelText: 'City*',
                            hintText: 'City'),
                        itemFilter: (item, query) {
                          return item
                              .toLowerCase()
                              .startsWith(query.toLowerCase());
                        },
                        itemSorter: (a, b) {
                          return a.compareTo(b);
                        },
                        itemSubmitted: (item) {
                          setState(() {
                            orderuserDetailsRequestModel.city = item;
                              cityFeild.textField.controller.text = item;
                          });
                        },
                        itemBuilder: (context, item) {
                          return recomendation(item);
                        },
                      )),
                ],
              ),
              SizedBox(height: 15),
              // Local

              Container(
                height: 45,
                child: TextFormField(
                  onChanged: (value){
                    orderuserDetailsRequestModel.localy = value;

                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      labelText: 'Address*',
                      hintText: 'Address'),
                ),
              ),
                  SizedBox(height: 15),
               Container(
                height: 45,
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      labelText: 'Contact Person Name*',
                      hintText: 'Conact Person'),
                ),
              ),
              SizedBox(height: 15),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                 color: Color(0xff032e6b),
                ),
                child: Center(
                  child: Text('Save Details',style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 18
                  ),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
