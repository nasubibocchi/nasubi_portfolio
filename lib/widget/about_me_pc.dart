import 'package:flutter/material.dart';

///自己紹介 @ PC
class AboutMeForPC extends StatelessWidget {
  AboutMeForPC(
      {required this.aboutme,
      required this.career,
      required this.tools,
      required this.language,
      required this.backgroundImageUrl});

  String? aboutme;
  String? career;
  String? tools;
  String? language;
  String? backgroundImageUrl;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: ListView(shrinkWrap: true, children: [
        Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  '自己紹介',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: deviceHeight * 0.05,
                  backgroundImage: AssetImage(backgroundImageUrl!),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  aboutme!,
                ),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  '学歴＆職歴',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  career!,
                ),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  'ツール',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  tools!,
                ),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  '言語',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  language!,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
