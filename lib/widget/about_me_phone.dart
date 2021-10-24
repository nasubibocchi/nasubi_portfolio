import 'package:flutter/material.dart';

///自己紹介 @ スマホ
class AboutMeForPhone extends StatelessWidget {
  AboutMeForPhone(
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
    const _maxHeight = 20.0;

    return Card(
      elevation: 5.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  '自己紹介',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              CircleAvatar(
                radius: 40.0,
                backgroundImage: AssetImage(backgroundImageUrl!),
              ),
              const SizedBox(height: _maxHeight),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                child: Text(
                  aboutme!,
                ),
              ),
            ],
          ),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  '学歴＆職歴',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                child: Text(
                  career!,
                ),
              ),
            ],
          ),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  'ツール',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                child: Text(
                  tools!,
                ),
              ),
            ],
          ),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  '言語',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                child: Text(
                  language!,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
