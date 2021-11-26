import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'constants.dart';
import 'data.dart';
import 'widget/released_app_pc.dart';
import 'widget/released_app_phone.dart';

///リリースアプリ
class ReleasedAppInfo extends StatelessWidget {
  const ReleasedAppInfo({Key? key}) : super(key: key);

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
                  ReleasedAppWidget(index: 0, releasedAppList: releasedAppList),
                  SizedBox(
                    width: deviceWidth * 0.01,
                  ),
                  ReleasedAppWidget(index: 1, releasedAppList: releasedAppList),
                  SizedBox(
                    width: deviceWidth * 0.01,
                  ),
                ],
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              Row(
                children: [
                  // ReleasedAppWidget(index: 1, releasedAppList: releasedAppList),
                  SizedBox(
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
                    itemCount: releasedAppList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ReleasedAppForPhone(
                          index: index, releasedAppList: releasedAppList);
                    }),
              ),
              SmoothPageIndicator(
                controller: controller,
                count: releasedAppList.length,
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
