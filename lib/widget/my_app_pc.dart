import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

///アプリ紹介【項目】@ PC
class MyAppForPC extends StatelessWidget {
  MyAppForPC({required this.myAppList, required this.index});

  int index;
  List<Map<String, dynamic>> myAppList;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return InkWell(
      child: Card(
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
                    image: AssetImage(myAppList[index]['imageUrl']),
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.025,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  myAppList[index]['information'],
                  style: TextStyle(fontSize: deviceHeight * 0.02),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.025,
              ),
            ],
          ),
        ),
      ),
      onTap: () async {
        if (await canLaunch(myAppList[index]['url'])) {
          await launch(myAppList[index]['url']);
        }
      },
    );
  }
}
