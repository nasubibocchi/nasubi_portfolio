import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';
import 'data.dart';

void main() async {
  // // WidgetsFlutterBinding.ensureInitialized();
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kNuanceColour,
      ),
      //TODO:drawerの設定
      // drawer: Drawer(),
      body: deviceWidth > 1200.0
          ? Row(
        children: [
          SizedBox(
            //height: 800で * 1, width: 250で0.2
            height: deviceHeight * 0.1,
            width: deviceWidth * 0.05,
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: deviceHeight * 0.1,
                    width: deviceWidth * 0.05,
                  ),
                  Text('作成したアプリ'),
                  SizedBox(
                    height: deviceHeight * 0.005,
                    width: deviceWidth * 0.05,
                  ),
                  Container(
                    ///アプリ紹介ウィジェット
                    child: appInfo(
                        deviceHeight: deviceHeight,
                        deviceWidth: deviceWidth),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              ///自己紹介ウィジェット
              child: aboutMeForPC(
                aboutme: '名前 : 松丸仁美',
                tools: '●AndroidStudio\n●VScode\n●figma\n●GitHub',
                language: '●Dart\n●C\n●Python',
                backgroundImageUrl: "images/hitomi.png",
                deviceWidth: deviceWidth,
                deviceHeight: deviceHeight,
              ),
            ),
          ),
        ],
      )
          : SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: deviceHeight * 0.05,
                      width: deviceWidth * 0.05,
                    ),
                    Text(
                      '作成したアプリ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.01,
                      width: deviceWidth * 0.05,
                    ),
                    Container(
                      ///アプリ紹介ウィジェット
                      child: appInfo(
                          deviceHeight: deviceHeight,
                          deviceWidth: deviceWidth),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
                width: 20.0,
              ),
              Container(
                child: aboutMeForPhone(
                  aboutme: '名前 : 松丸仁美',
                  tools: '●AndroidStudio\n●VScode\n●figma\n●GitHub',
                  language: '●Dart\n●C\n●Python',
                  backgroundImageUrl: "images/hitomi.png",
                  deviceWidth: deviceWidth,
                  deviceHeight: deviceHeight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///ウィジェット
///アプリ紹介 @ PC
Widget appInfo({required double deviceHeight, required double deviceWidth}) {
  return Container(
    child: deviceWidth > 1200.0
        ? SingleChildScrollView(
      child: Column(
        children: [
          Row(
            //TODO: PCはデータが増えたらここも修正
            children: [
              myAppForPC(
                  myAppList: myAppList,
                  deviceHeight: deviceHeight,
                  deviceWidth: deviceWidth,
                  index: 0),
              myAppForPC(
                  myAppList: myAppList,
                  deviceHeight: deviceHeight,
                  deviceWidth: deviceWidth,
                  index: 1),
              // myAppForPC(myAppList: myAppList, deviceHeight: deviceHeight, deviceWidth: deviceWidth, index: 2),
            ],
          ),
        ],
      ),
    )
        : Column(
      children: [
        Container(
          ///PageViewの描画範囲を決めておく（これがないとrenderErrorになる）
          height: 550.0,
          width: 350.0,
          child: PageView.builder(
              controller:
              PageController(initialPage: 0, viewportFraction: 0.9),
              itemCount: myAppList.length,
              itemBuilder: (BuildContext context, int index) {
                return myAppForPhone(
                    myAppList: myAppList,
                    deviceHeight: deviceHeight,
                    deviceWidth: deviceWidth,
                    index: index);
              }),
        ),
      ],
    ),
  );
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
      child: Container(
        height: deviceHeight * 0.5,
        width: deviceWidth * 0.19,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: deviceHeight * 0.25,
                width: deviceWidth * 0.3,
                child: Image(
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
      required String tools,
      required String language,
      required double deviceHeight,
      required double deviceWidth,
      required String backgroundImageUrl}) {
  return Container(
    child: Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: deviceHeight * 0.02,
            width: deviceWidth * 0.025,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  '自己紹介',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: deviceHeight * 0.025,
                  width: deviceWidth * 0.025,
                ),
                CircleAvatar(
                  radius: deviceHeight * 0.05,
                  backgroundImage: AssetImage(backgroundImageUrl),
                ),
                SizedBox(
                  height: deviceHeight * 0.025,
                  width: deviceWidth * 0.025,
                ),
                Text(
                  aboutme,
                ),
              ],
            ),
          ),
          SizedBox(
            height: deviceHeight * 0.025,
            width: deviceWidth * 0.025,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  'ツール',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: deviceHeight * 0.025,
                  width: deviceWidth * 0.025,
                ),
                Text(
                  tools,
                ),
              ],
            ),
          ),
          SizedBox(
            height: deviceHeight * 0.025,
            width: deviceWidth * 0.025,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  '言語',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: deviceHeight * 0.025,
                  width: deviceWidth * 0.025,
                ),
                Text(
                  language,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

///スマホレイアウト
///アプリ紹介【項目】@ スマホ
Widget myAppForPhone(
    {required List<Map<String, dynamic>> myAppList,
      required double deviceHeight,
      required double deviceWidth,
      required int index}) {
  return Column(
    children: [
      InkWell(
        child: Card(
          elevation: 5.0,
          child: Container(
            // height: deviceHeight * 0.55,
            // width: deviceWidth * 0.9,
            height: 500.0, width: 350.0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    // height: deviceHeight * 0.25,
                    // width: deviceWidth * 0.85,
                    height: 250.0, width: 340.0,
                    child: Image(
                      image: AssetImage(myAppList[index]['imageUrl']),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: deviceHeight * 0.025,
                //   width: deviceWidth * 0.8,
                // ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    myAppList[index]['information'],
                    // style: TextStyle(fontSize: deviceHeight * 0.02),
                  ),
                ),
                // SizedBox(
                //   height: deviceHeight * 0.025,
                //   width: deviceWidth * 0.8,
                // ),
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
        DotsDecorator(color: kBaseColour, activeColor: kAccentColour),
      ),
    ],
  );
}

///自己紹介 @ スマホ
Widget aboutMeForPhone(
    {required String aboutme,
      required String tools,
      required String language,
      required double deviceHeight,
      required double deviceWidth,
      required String backgroundImageUrl}) {
  return Container(
    child: Card(
      elevation: 5.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                  width: 350.0,
                ),
                Text(
                  '自己紹介',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.0,
                  width: 350.0,
                ),
                CircleAvatar(
                  radius: 40.0,
                  backgroundImage: AssetImage(backgroundImageUrl),
                ),
                SizedBox(
                  height: 20.0,
                  width: 350.0,
                ),
                Text(
                  aboutme,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.0,
            width: 350.0,
          ),
          Container(
            child: Column(
              children: [
                Text(
                  'ツール',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15.0,
                  width: 350.0,
                ),
                Text(
                  tools,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.0,
            width: 350.0,
          ),
          Container(
            child: Column(
              children: [
                Text(
                  '言語',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15.0,
                  width: 350.0,
                ),
                Text(
                  language,
                ),
                SizedBox(
                  height: 30.0,
                  width: 350.0,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
