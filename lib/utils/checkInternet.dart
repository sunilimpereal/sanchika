import 'dart:async';
import 'package:flutter/material.dart';

import
'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
class checkInternet{
  StreamSubscription<DataConnectionStatus> listener;
var InternetStatus = "Unknown";
var contentmessage = "Unknown";
void _showDialog(String title,String content ,BuildContext context){
  showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
            title: new Text('Network'),
            content: new Text(content),
            actions: <Widget>[
              new FlatButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child:new Text("Close") )
            ]
        );
      }
  );}
  checkConnection(BuildContext context) async{
  listener = DataConnectionChecker().onStatusChange.listen((status) {
    switch (status){
      case DataConnectionStatus.connected:
        InternetStatus = "Connected to the Internet";
        // contentmessage = "Connected to the Internet";
        // _showDialog(InternetStatus,contentmessage,context);
        break;
      case DataConnectionStatus.disconnected:
        InternetStatus = "You are disconnected to the Internet. ";
        contentmessage = "Please check your internet connection";
        _showDialog(InternetStatus,contentmessage,context);
        break;
    }
  });
  return await DataConnectionChecker().connectionStatus;
}
}