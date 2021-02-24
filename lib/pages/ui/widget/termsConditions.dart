import 'package:flutter/material.dart';

class TermsConditions extends StatefulWidget {
  @override
  _TermsConditionsState createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left_rounded,
            size: 35,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Terms & conditions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.only(top: 8),
            icon: Icon(
              Icons.shopping_cart,
              size: 28,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              para(
                heading: 'Privacy Policy',
                content:
                    'Agreement between Sanchika and business or individual. The client/individual is subject to the following terms and conditions.',
              ),
              para(
                heading: 'GENERAL WORKING AGREEMENT',
                content:
                    'This document defines the terms and conditions of our working relationship. All projects or services that Sanchika (hereafter referred to as “Wondersmind Designs” or “we”) may be contracted to produce or provide for you (hereafter referred to as “you” or “the client”) will be subject to the following:',
              ),
              para(
                heading: 'SUMMARY',
                content:
                    'We will always do our best to fulfil your needs and meet your goals, but sometimes it’s best to have a few things written down so that we both know what’s what, who should do what and what happens if stuff goes wrong. In this contract you won’t find complicated legal terms or long passages of unreadable text. We have no desire to trick you into signing something that you might later regret. We do want what’s best for the safety of both parties, now and in the future.',
              ),
              para(
                heading: 'IN SHORT',
                content:
                    'You are hiring us to design and develop a website for the estimated total price as outlined in our proposal. Of course it’s a little more complicated, but we’ll get to that.',
              ),
              para(
                heading: 'WHAT DO BOTH PARTIES AGREE TO DO?',
                content:
                    'If we are designing your application we’ll create designs for the look-and-feel, layout and functionality of your website. This contract includes one main design plus the opportunity for you to make up to two rounds of revisions. If you’re not happy with the designs at this stage, you will pay us in full for all of the work that we have produced until that point and you may either cancel this contract or continue to commission us to make further design revisions at our standard design rates.',
              ),
              para(
                heading: 'Technical Support',
                content:
                    'You may already have professional website hosting, you might even manage that hosting in-house; if that’s the case, great. If you don’t manage your own website hosting, or your current hosting environment does not support the solution we are providing, we can set up an account for you at one of our preferred, third-party hosting providers. We will charge you a one-off fee for installing your site on this server, plus any statistics software such as Google Analytics, then the updates to, and management of that server, plus any support issues will be up to you.We are not a website hosting company and so do not offer or include technical support for website hosting, email or other services relating to website hosting.',
              ),
              para(
                heading: 'Copyrights',
                content:
                    'You guarantee to us that any elements of text, graphics, photos, designs, trademarks, or other artwork that you provide us for inclusion in the website are either owned by your good selves, or that you have permission to use them.When we receive your final payment, copyright is automatically assigned as follows:You own the graphics and other visual elements that we create for you for this project. We’ll give you a copy of all files and you should store them really safely as we are not required to keep them or provide any native source files we used to make them.You also own text content, photographs and other data you provided, unless someone else owns them. We own the markup, CSS and other code and we license it to you for use on only this project.We love to show off our work and share what we have learned with other people, so we reserve the right to display and link to your completed project as part of our portfolio and to write about the project on websites, in magazine articles and in books about web design.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container para({String heading, String content}) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  heading,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              content,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}
