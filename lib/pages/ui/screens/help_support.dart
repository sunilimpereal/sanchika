import 'package:flutter/material.dart';
import 'package:sanchika/bloc/navigationBloc/Navigation_bloc.dart';

class HelpSupportPage extends StatelessWidget with NavigationStates {
  final Function onMenuTap;

  const HelpSupportPage({Key key, this.onMenuTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    void handleClick(String value) {
      switch (value) {
        case 'Logout':
          break;
        case 'Settings':
          break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Help & Support",
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            color: Colors.white,
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Orders',
                'Shipping',
                'Return & Cancellation',
                'Contact Us'
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: InkWell(
            child: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onTap: onMenuTap,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              box(
                heading: 'What is my order status?',
                content:
                    'You can view your order status by looking up your order.',
              ),
              box(
                heading: 'What payments do you accept?',
                content:
                    'We accept Visa, MasterCard, Discover, American Express and check cards or ATM cards, as long as they are connected with one of the major credit card companies listed above. You can safely enter your entire credit card number via our secure server, which encrypts all submitted information.',
              ),
              box(
                heading: 'What is PayPal Credit?',
                content:
                    'Checkout fast with PayPal Credit. The effortless way to pay without using your credit card. Simply select PayPal Credit at checkout, answer two simple questions and accept the terms. It\'s that easy. There is no separate application process. PayPal Credit offers flexible terms that allow you to choose to pay in full or over time. Subject to credit approval. See Terms.',
              ),
              box(
                heading: 'How do I enter a shipping address?',
                content:
                    'A shipping infomation page will be presented where you can enter a separate shipping address and the shipping method can be chosen.',
              ),
              box(
                heading:
                    'Should I put spaces or dashes in the credit card number?',
                content:
                    'Your card number should be entered in as a continuous strng of numbers.',
              ),
              box(
                heading: 'Why are you not accepting my credit card?',
                content:
                    'There are many reasons for a failed credit card transaction. Your card may have expired or reached its limit or a credit card computer, either on our end or your bank\'s end, may have encountered a machine error.',
              ),
              box(
                heading: 'What is my order status?',
                content:
                    'You can view your order status by looking up your order.',
              ),
              box(
                heading: 'When will my credit card charged?',
                content:
                    'We will not bill you until your product(s), including backordered or preordered items, are actualy shipped. If your items are ahipped separately you will be billed each time an item is shipped.',
              ),
              box(
                heading: 'How will the charge show up my credit card?',
                content:
                    'The charge will appear on your credit card as: \'DRI*Western Digital Online Store\'.',
              ),
              box(
                heading:
                    'How will you know where and how to send my physical product?',
                content:
                    'If you order a physical product, a Shipping infomation page will appear during checkout so you can enter a shipping address and choose a shipping method.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget box({String heading, String content}) {
    return Container(
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
            child: Text(
              heading,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: double.maxFinite,
            child: Text(
              content,
              style: TextStyle(),
            ),
          ),
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
