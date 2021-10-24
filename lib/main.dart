import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_info.dart';
import 'constants.dart';
import 'data.dart';
import 'released_app_info.dart';
import 'widget/about_me_pc.dart';
import 'widget/about_me_phone.dart';

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
  double deviceHeight = 0.0;
  double deviceWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kBaseColour,
      body: deviceWidth > 1200.0
          ? SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          height: deviceHeight * 0.08,
                          width: deviceWidth * 0.05,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Released',
                              style: GoogleFonts.satisfy(
                                  fontSize: 32.0, color: kAccentColour)),
                        ),
                        ReleasedAppInfo(),
                        SizedBox(
                          height: deviceHeight * 0.06,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Others',
                              style: GoogleFonts.satisfy(
                                  fontSize: 32.0, color: kAccentColour)),
                        ),
                        AppInfo(),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(deviceWidth * 0.005),
                      child: AboutMeForPC(
                        aboutme: aboutMeText,
                        career: careerText,
                        tools: toolsText,
                        language: languageText,
                        backgroundImageUrl: iconsText,
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Released',
                              style: GoogleFonts.satisfy(
                                  fontSize: 32.0, color: kAccentColour)),
                        ),
                        ReleasedAppInfo(),
                        const SizedBox(height: 60.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Others',
                              style: GoogleFonts.satisfy(
                                  fontSize: 32.0, color: kAccentColour)),
                        ),
                        AppInfo(),
                      ],
                    ),
                    const SizedBox(height: 60.0),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: AboutMeForPhone(
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
    );
  }
}
