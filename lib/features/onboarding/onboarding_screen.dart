import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:newww/components/constance.dart';
import 'package:newww/features/login_screen/login_screen.dart';
import 'package:newww/core/network/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Models {
  final String text;
  final String body;
  final String image;
  Models({
    required this.text,
    required this.body,
    required this.image,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageViewController = PageController();

  void Submit() {
    CashHelper.setUserData(key: 'onBoarding', value: true).then((value) {
      if (value!) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
      }
    });
  }

  bool isLast = false;
  List<Map<String, String>> pageViewItems = [
    {
      'text': 'ONLINE SHOPPE',
      'body': 'Easy and fast shopping form your home',
      'image': 'lib/assets/images/online.json',
    },
    {
      'text': 'ORDER FROM ANY WHERE',
      'body': 'You can order from anywhere',
      'image': 'lib/assets/images/order.json',
    },
    {
      'text': 'DELIVERY',
      'body': 'Delivery to your home',
      'image': 'lib/assets/images/delivery.json',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (index) {
                if (index == 2) {
                  setState(() {
                    isLast = true;
                  });
                } else {
                  setState(() {
                    isLast = false;
                  });
                }
              },
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => pageView(pageViewItems[index]),
              controller: pageViewController,
              itemCount: pageViewItems.length,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  style: ButtonStyle(
                      overlayColor:
                          MaterialStatePropertyAll(Colors.transparent)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: LoginScreen(),
                            type: PageTransitionType.fade));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Skip',
                          style: TextStyle(
                            color: color,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        )
                      ],
                    ),
                  )),
              SmoothPageIndicator(
                  controller: pageViewController,
                  count: pageViewItems.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: color,
                    dotColor: Colors.grey[300]!,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    spacing: 5,
                  )),
              TextButton(
                  style: ButtonStyle(
                      overlayColor:
                          MaterialStatePropertyAll(Colors.transparent)),
                  onPressed: () {
                    if (isLast == true) {
                      Submit();
                    } else {
                      pageViewController.nextPage(
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Next',
                          style: TextStyle(
                            color: color,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  pageView(model) => Column(
        children: [
          Center(
              child: Lottie.asset(
            model['image'],
            height: 300,
            width: 300,
          )),
          const SizedBox(
            height: 30,
          ),
          Text(
            '${model['text']}',
            style: const TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'font'),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              '${model['body']}',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[500]),
            ),
          ),
          const SizedBox(
            height: 120,
          ),
        ],
      );
}
