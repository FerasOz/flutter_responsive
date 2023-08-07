import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_project_flutter/shared/components/components.dart';
import 'package:new_project_flutter/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../login/shop_login_screen.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body
  });
}

class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onBoard1.png',
        title: 'On Board 1 Title',
        body: 'On Board 1 body'
    ),
    BoardingModel(
        image: 'assets/images/onBoard1.png',
        title: 'On Board 2 Title',
        body: 'On Board 2 body'
    ),
    BoardingModel(
        image: 'assets/images/onBoard1.png',
        title: 'On Board 3 Title',
        body: 'On Board 3 body'
    ),
  ];

  void onSubmit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      navigateAndFinish(context, ShopLoginScreen());
    });
  }

  var boardController = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
            onSubmit();
          }, child: Text('Skip ->', style: TextStyle(fontSize: 20.0),))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                onPageChanged: (index){
                  if(index == boarding.length-1){
                    setState(() {
                      isLast = true;
                    });
                  }else{
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                    spacing: 5.0,
                    expansionFactor: 5.0,
                    activeDotColor: Colors.blue
                  ),
                  count: boarding.length,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    if(isLast){
                      onSubmit();
                    }else{
                      boardController.nextPage(duration: const Duration(
                        milliseconds: 750,
                      ),
                          curve: Curves.fastLinearToSlowEaseIn
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel Board) => Column(
        children: [
          Expanded(
            child: Image(image: AssetImage('${Board.image}')),
          ),
          Text(
            '${Board.title}',
            style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
          ),
          Text(
            '${Board.body}',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ],
      );
}
