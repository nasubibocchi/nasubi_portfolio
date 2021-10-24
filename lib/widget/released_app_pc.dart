import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data.dart';

///リリースアプリ
class ReleasedAppWidget extends StatelessWidget {
  ReleasedAppWidget({required this.index, required this.releasedAppList});

  int index;
  List<Map<String, dynamic>> releasedAppList;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return Card(
      elevation: 5.0,
      child: SizedBox(
        height: deviceHeight * 0.5,
        width: deviceWidth * 0.19,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: deviceHeight * 0.25,
                width: deviceWidth * 0.3,
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage(releasedAppList[index]['imageUrl']),
                ),
              ),
            ),
            SizedBox(height: deviceHeight * 0.01),
            Column(
              children: [
                SizedBox(
                  height: deviceHeight * 0.08,
                  width: deviceWidth * 0.12,
                  child: InkWell(
                      onTap: () async {
                        if (await canLaunch(releasedAppList[index]['iOSUrl'])) {
                          await launch(releasedAppList[index]['iOSUrl']);
                        }
                      },
                      child: Image(fit: BoxFit.contain, image: AssetImage('images/apple-store-badge.png'),),),
                ),
                SizedBox(
                  height: deviceHeight * 0.08,
                  width: deviceWidth * 0.12,
                  child: InkWell(
                      onTap: () async {
                        if (await canLaunch(releasedAppList[index]['androidUrl'])) {
                          await launch(releasedAppList[index]['androidUrl']);
                        }
                      },
                      child: Image(fit: BoxFit.contain, image: AssetImage('images/google-play-badge.png'),)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
