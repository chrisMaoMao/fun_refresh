import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

const String bannerUnit = 'ca-app-pub-9275143816186195/7092152699';
const String intersUnit = 'ca-app-pub-9275143816186195/1089851125';
const String rewardUnit = 'ca-app-pub-9275143816186195/3111888542';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;
  int _coins = 0;

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: bannerUnit,
      size: AdSize.banner,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: intersUnit,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event $event");
      },
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-9275143816186195~6439219109");
    _bannerAd = createBannerAd()..load();
    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      print("RewardedVideoAd event $event");
      if (event == RewardedVideoAdEvent.rewarded) {
        setState(() {
          _coins += rewardAmount;
        });
      }
    };
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  build(context) => Scaffold(
        appBar: AppBar(
          title: const Text('AdMob Plugin example app'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RaisedButton(
                    child: const Text('SHOW BANNER'),
                    onPressed: () {
                      print('横幅广告：' + BannerAd.testAdUnitId.toString());
                      _bannerAd ??= createBannerAd();
                      _bannerAd
                        ..load()
                        ..show();
                    }),
                RaisedButton(
                    child: const Text('REMOVE BANNER'),
                    onPressed: () {
                      _bannerAd?.dispose();
                      _bannerAd = null;
                    }),
                RaisedButton(
                  child: const Text('LOAD INTERSTITIAL'),
                  onPressed: () {
                    _interstitialAd?.dispose();
                    _interstitialAd = createInterstitialAd()..load();
                  },
                ),
                RaisedButton(
                  child: const Text('SHOW INTERSTITIAL'),
                  onPressed: () {
                    print('插屏广告' + InterstitialAd.testAdUnitId.toString());
                    _interstitialAd?.show();
                  },
                ),
                RaisedButton(
                  child: const Text('LOAD REWARDED VIDEO'),
                  onPressed: () {
                    print('激励视频' + RewardedVideoAd.testAdUnitId.toString());
                    RewardedVideoAd.instance.load(adUnitId: rewardUnit);
                  },
                ),
                RaisedButton(
                  child: const Text('SHOW REWARDED VIDEO'),
                  onPressed: () {
                    RewardedVideoAd.instance.show();
                  },
                ),
                Text("You have $_coins coins."),
              ].map((Widget button) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: button,
                );
              }).toList(),
            ),
          ),
        ),
      );
}
/* return FutureBuilder<FeaturedVideo>(
      future: _fetchVideoData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data.itemList[0].data.playUrl);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    ); 
Future<FeaturedVideo> _fetchVideoData() async {
  final response = await Dio().get(EYE_HOME);
  print(response.data);
  if (response.statusCode == 200) {
    return FeaturedVideo.fromJson(jsonDecode(response.data));
  } else {
    throw Exception();
  }
}
*/
/*   RefreshIndicator(
        onRefresh: _fetchData,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: _videoList.length ?? 0,
          itemBuilder: (context, index) => Card(
                elevation: 10.0,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VideoItem(video: _videoList[index].playUrl),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                      child: Text(
                        _videoList[index].title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.0),
                      ),
                    )
                  ],
                ),
              ),
        ),
      );
 */
