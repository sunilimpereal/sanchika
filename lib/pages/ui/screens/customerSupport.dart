import 'package:flutter/material.dart';
import 'package:sanchika/localization/localization_methods.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class CustomerSupport extends StatefulWidget {
  @override
  _CustomerSupportState createState() => _CustomerSupportState();
}

class _CustomerSupportState extends State<CustomerSupport> {
  _makingPhoneCall() async {
  const url = 'tel:7594043399';
  if (await UrlLauncher.canLaunch(url)) {
    await UrlLauncher.launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xff032e6b).withAlpha(180),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          getTranslated(context, "Customer_Support"),
          style: TextStyle(
            color: Color(0xff032e6b).withAlpha(180),
          ),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: (){
               const url = 'tel:7594043399';
              UrlLauncher.launch(url);
            },
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.call,color: Color(0xff032e6b).withAlpha(180),),
            ),
            title: Text('Call Us'),
            subtitle: Text('7594043399'),
          ),
          ListTile(
            onTap: (){
               UrlLauncher.launch('mailto:support@sanchika.in');
            },
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.email,color: Color(0xff032e6b).withAlpha(180),),
            ),
            title: Text('Email Us'),
            subtitle: Text('support@sanchika.in'),
          ),
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.rate_review,color: Color(0xff032e6b).withAlpha(180),),
            ),
            title: Text('Review Us'),
          )
        ],
      ),
    );
  }
}
