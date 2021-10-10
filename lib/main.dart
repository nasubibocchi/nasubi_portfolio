import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';
import 'data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();//firebaseの機能を中で使っていないので不要
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Portfolio',
      home: MyHomePage(),
    );
  }
}

///枠
class MyHomePage extends StatelessWidget {
  // const MyHomePage({Key? key}) : super(key: key);
  double deviceHeight = 0.0;
  double deviceWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: kBaseColour,
        body: deviceWidth > 1200.0
            ? SingleChildScrollView(
                child: Row(
                  children: [
                    SizedBox(
                      //height: 800で * 1, width: 250で0.2
                      height: deviceHeight * 0.1,
                      width: deviceWidth * 0.05,
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: deviceHeight * 0.1,
                            width: deviceWidth * 0.05,
                          ),
                          SizedBox(
                            height: deviceHeight * 0.005,
                            width: deviceWidth * 0.05,
                          ),
                          AppInfo(),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(deviceWidth * 0.005),
                        child: aboutMeForPC(
                          aboutme: aboutMeText,
                          career: careerText,
                          tools: toolsText,
                          language: languageText,
                          backgroundImageUrl: iconsText,
                          deviceWidth: deviceWidth,
                          deviceHeight: deviceHeight,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 60.0),
                          AppInfo(),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: aboutMeForPhone(
                          aboutme: aboutMeText,
                          career: careerText,
                          tools: toolsText,
                          language: languageText,
                          backgroundImageUrl: iconsText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

///ウィジェット
///アプリ紹介
class AppInfo extends StatelessWidget {
  const AppInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return deviceWidth > 1200.0
        ? Column(
            children: [
              Row(
                //TODO: PCはデータが増えたらここも修正
                children: [
                  myAppForPC(
                      myAppList: myAppList,
                      deviceHeight: deviceHeight,
                      deviceWidth: deviceWidth,
                      index: 0),
                  SizedBox(
                    height: deviceHeight * 0.01,
                    width: deviceWidth * 0.01,
                  ),
                  myAppForPC(
                      myAppList: myAppList,
                      deviceHeight: deviceHeight,
                      deviceWidth: deviceWidth,
                      index: 1),
                  SizedBox(
                    height: deviceHeight * 0.01,
                    width: deviceWidth * 0.01,
                  ),
                  myAppForPC(
                      myAppList: myAppList,
                      deviceHeight: deviceHeight,
                      deviceWidth: deviceWidth,
                      index: 2),
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
                    controller:
                        PageController(initialPage: 0, viewportFraction: 0.9),
                    itemCount: myAppList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return myAppForPhone(myAppList: myAppList, index: index);
                    }),
              ),
            ],
          );
  }
}

///------------------------------------------------------
///これ以降は固定ウィジェット
///PCレイアウト
///アプリ紹介【項目】@ PC
Widget myAppForPC(
    {required List<Map<String, dynamic>> myAppList,
    required double deviceHeight,
    required double deviceWidth,
    required int index}) {
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
              width: deviceWidth * 0.17,
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
              width: deviceWidth * 0.17,
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

///自己紹介 @ PC
Widget aboutMeForPC(
    {required String aboutme,
    required String career,
    required String tools,
    required String language,
    required double deviceHeight,
    required double deviceWidth,
    required String backgroundImageUrl}) {
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
                backgroundImage: AssetImage(backgroundImageUrl),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                aboutme,
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
                career,
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
                tools,
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
                language,
              ),
            ),
          ],
        ),
      ),
    ]),
  );
}

///スマホレイアウト
///アプリ紹介【項目】@ スマホ
Widget myAppForPhone(
    {required List<Map<String, dynamic>> myAppList, required int index}) {
  return Column(
    children: [
      InkWell(
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
      ),
      DotsIndicator(
        dotsCount: myAppList.length,
        position: index.toDouble(),
        decorator:
            DotsDecorator(color: kNuanceColour, activeColor: kAccentColour),
      ),
    ],
  );
}

///自己紹介 @ スマホ
Widget aboutMeForPhone(
    {required String aboutme,
    required String career,
    required String tools,
    required String language,
    required String backgroundImageUrl}) {
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
              backgroundImage: AssetImage(backgroundImageUrl),
            ),
            const SizedBox(height: _maxHeight),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
              child: Text(
                aboutme,
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
                career,
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
                tools,
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
                language,
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
