import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data.dart';

///アプリ
class MyAppForPhone extends StatelessWidget {
  MyAppForPhone({required this.myAppList, required this.index});

  int index;
  List<Map<String, dynamic>> myAppList;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        elevation: 5.0,
        child: SizedBox(
          height: 500.0,
          width: 350.0,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 250.0,
                  width: 340.0,
                  child: Image(
                    fit: BoxFit.cover,
                    image: AssetImage(myAppList[index]['imageUrl']),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  myAppList[index]['information'],
                ),
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