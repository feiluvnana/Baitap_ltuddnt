import 'dart:io';

import 'package:ex2/expandable_fab.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance
    ..initialize()
    ..updateRequestConfiguration(
        RequestConfiguration(testDeviceIds: ['97807F82359F5ACE4D1968C1C7D6D39B']));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        floatingActionButtonTheme: const FloatingActionButtonThemeData(shape: CircleBorder()),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '20204538'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BannerAd? _ad;
  bool _isLoaded = false;

  final bannerAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';
  final interstitialAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/4411468910';
  final rewardedAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-3940256099942544/1712485313';

  void bannerAd() {
    setState(() {
      _ad = null;
      _isLoaded = false;
    });
    BannerAd(
      adUnitId: bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _ad = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    ).load();
  }

  void interstitialAd() {
    setState(() {
      _ad = null;
      _isLoaded = false;
    });
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.show();
        },
        onAdFailedToLoad: (err) {},
      ),
    );
  }

  void rewardedAd() {
    setState(() {
      _ad = null;
      _isLoaded = false;
    });
    RewardedAd.load(
        adUnitId: rewardedAdUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            ad.show(onUserEarnedReward: (ad, item) {});
          },
          onAdFailedToLoad: (LoadAdError error) {},
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text(widget.title)),
      body: Center(
          child: Column(
        children: [
          const Text("Ấn nút phía dưới để chọn loại quảng cáo hiển thị."),
          _isLoaded
              ? SafeArea(
                  child: SizedBox(
                      width: AdSize.banner.width.toDouble(),
                      height: AdSize.banner.height.toDouble(),
                      child: AdWidget(ad: _ad!)))
              : Container()
        ],
      )),
      floatingActionButton: ExpandableFab(distance: 100, children: [
        FloatingActionButton(
          onPressed: bannerAd,
          tooltip: 'Banner',
          child: const Icon(Icons.rectangle),
        ),
        FloatingActionButton(
          onPressed: interstitialAd,
          tooltip: 'Interstitial',
          child: const Icon(Icons.fullscreen),
        ),
        FloatingActionButton(
          onPressed: rewardedAd,
          tooltip: 'Rewarded',
          child: const Icon(Icons.money),
        )
      ]),
    );
  }
}
