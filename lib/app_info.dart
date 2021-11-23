import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'constants.dart';
import 'data.dart';
import 'widget/my_app_pc.dart';
import 'widget/my_app_phone.dart';

///アプリ紹介
class AppInfo extends StatelessWidget {
  const AppInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    final controller = PageController(viewportFraction: 0.9, keepPage: true);

    return deviceWidth > 1200.0
        ? Column(
            children: [
              Row(
                //TODO: PCはデータが増えたらここも修正
                children: [
                  MyAppForPC(
                      myAppList: myAppList,
                      index: 0),
                  SizedBox(
                    width: deviceWidth * 0.01,
                  ),
                  MyAppForPC(
                      myAppList: myAppList,
                      index: 1),
                  SizedBox(
                    width: deviceWidth * 0.01,
                  ),
                  MyAppForPC(
                      myAppList: myAppList,
                      index: 2),
                ],
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              Row(
                children: [
                  MyAppForPC(
                      myAppList: myAppList,
                      index: 3),
                  SizedBox(
                    height: deviceHeight * 0.01,
                    width: deviceWidth * 0.01,
                  ),
                  MyAppForPC(
                      myAppList: myAppList,
                      index: 4),
                  SizedBox(
                    height: deviceHeight * 0.01,
                    width: deviceWidth * 0.01,
                  ),
                ],
              ),
            ],
          )
        : Column(
            children: [
              SizedBox(
                ///PageViewの描画範囲を決めておく（これがないとrenderErrorになる）
                height: 550.0,
                width: 350.0,
                child: PageView.builder(
                    controller: controller,
                    itemCount: myAppList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MyAppForPhone(myAppList: myAppList, index: index);
                    }),
              ),
              SmoothPageIndicator(
                controller: controller,
                count: myAppList.length,
                effect: CustomizableEffect(
                  activeDotDecoration: DotDecoration(
                    color: kAccentColour,
                    width: 10,
                    height: 10,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  dotDecoration: DotDecoration(
                    width: 10,
                    height: 10,
                    color: kNuanceColour,
                    borderRadius: BorderRadius.circular(12),
                    verticalOffset: 0,
                  ),
                ),
              ),
            ],
          );
  }
}
