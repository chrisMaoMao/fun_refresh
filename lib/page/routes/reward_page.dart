import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';

// You can also test with your own ad unit IDs by registering your device as a
// test device. Check the logs for your device's ID value.
String testDevice = 'ca-app-pub-9275143816186195/7092152699';
// 测试: ca-app-pub-3940256099942544/6300978111
// 横幅: ca-app-pub-9275143816186195/7092152699
// 插屏: ca-app-pub-9275143816186195/1089851125
// 激励: ca-app-pub-9275143816186195/3111888542
class RewardPage extends StatefulWidget {
  @override
  createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    childDirected: true,
    nonPersonalizedAds: true,
  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;
  int _coins = 0;

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: InterstitialAd.testAdUnitId,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event $event");
      },
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
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
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
                child: Text('SHOW BANNER'),
                onPressed: () {
                  _bannerAd ??= createBannerAd();
                  _bannerAd
                    ..load()
                    ..show();
                }),
            RaisedButton(
                child: Text('REMOVE BANNER'),
                onPressed: () {
                  _bannerAd?.dispose();
                  _bannerAd = null;
                }),
            RaisedButton(
              child: Text('LOAD INTERSTITIAL'),
              onPressed: () {
                _interstitialAd?.dispose();
                _interstitialAd = createInterstitialAd()..load();
              },
            ),
            RaisedButton(
              child: Text('SHOW INTERSTITIAL'),
              onPressed: () {
                _interstitialAd?.show();
              },
            ),
            RaisedButton(
              child: Text('LOAD REWARDED VIDEO'),
              onPressed: () {
                RewardedVideoAd.instance.load(
                    adUnitId: RewardedVideoAd.testAdUnitId,
                    targetingInfo: targetingInfo);
              },
            ),
            RaisedButton(
              child: Text('SHOW REWARDED VIDEO'),
              onPressed: () {
                RewardedVideoAd.instance.show();
              },
            ),
            Text("You have $_coins coins."),
          ].map((Widget button) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: button,
            );
          }).toList(),
        ),
      ),
    );
  }
}
