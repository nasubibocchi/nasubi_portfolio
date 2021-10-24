import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


///リリース
class ReleasedAppForPhone extends StatelessWidget {
  ReleasedAppForPhone({required this.index, required this.releasedAppList});

  int index;
  List<Map<String, dynamic>> releasedAppList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500.0,
      width: 350.0,
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 250.0,
                width: 340.0,
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage(releasedAppList[index]['imageUrl']),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 100.0,
                width: 200.0,
                child: InkWell(
                  onTap: () async {
                    if (await canLaunch(releasedAppList[index]['iOSUrl'])) {
                      await launch(releasedAppList[index]['iOSUrl']);
                    }
                  },
                  child: Image(
                    fit: BoxFit.contain,
                    image: AssetImage('images/apple-store-badge.png'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 100.0,
                width: 200.0,
                child: InkWell(
                  onTap: () async {
                    if (await canLaunch(releasedAppList[index]['androidUrl'])) {
                      await launch(releasedAppList[index]['androidUrl']);
                    }
                  },
                  child: Image(
                    fit: BoxFit.contain,
                    image: AssetImage('images/google-play-badge.png'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
