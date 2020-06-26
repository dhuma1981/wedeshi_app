import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:share/share.dart';
import 'package:wedeshi/main.dart';
import 'package:wedeshi/screens/brands_page.dart';
import 'package:wedeshi/screens/category_page.dart';
import 'package:wedeshi/screens/more_page.dart';
import 'package:wedeshi/screens/search_page.dart';
import 'package:wedeshi/screens/submit_brand_page.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:wedeshi/store/connectivity_store.dart';
import 'package:wedeshi/utils/constants.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';

ConnectivityStore store = ConnectivityStore();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex;
  GlobalKey _one = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ReactionDisposer _disposer;
  bool isInternetConnected = false;

  RateMyApp _rateMyApp = RateMyApp(
      preferencesPrefix: "rma_wedeshi_",
      minDays: 0,
      minLaunches: 2,
      remindDays: 1,
      remindLaunches: 5);

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    checkInternet();
  }

  void checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isInternetConnected = false;
      });
    } else {
      initReaction();
      showShowcaseView();

      _rateMyApp.init().then((_) {
        if (_rateMyApp.shouldOpenDialog) {
          showDialog(
            context: context,
            builder: (context) => Constants.showRatingDialog(
                context: context, rateMyApp: _rateMyApp),
          );
        }
      });
      setState(() {
        isInternetConnected = true;
      });
    }
  }

  void initReaction() {
    _disposer = reaction(
        (_) => store.connectivityStream.value,
        (result) => _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(result == ConnectivityResult.none
                ? 'You\'re offline'
                : 'You\'re online'))),
        delay: 4000);
  }

  Future<void> showShowcaseView() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getBool("opened") == null) {
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => ShowCaseWidget.of(context).startShowCase([
                _one,
              ]));
      prefs.setBool("opened", true);
    }
  }

  Widget _getPage(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return CategoryPage();
      case 1:
        return BrandsPage();
      case 2:
        return SubmitBrandPage();
      case 3:
        return MorePage();
    }
    return CategoryPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: false,
        title: isInternetConnected
            ? Image.network(
                "https://wedeshi.in/uploads/app/logo.png",
                width: 80,
              )
            : Image.asset(
                "assets/wedeshi_small.png",
                width: 80,
              ),
        actions: [
          Showcase(
            key: _one,
            title: "Share App",
            description:
                "\nGive priority to ${Platform.isIOS ? Constants.SWADESHI_English : Constants.SWADESHI} products. Please share the app to maximum number of people to aware for ${Platform.isIOS ? Constants.SWADESHI_English : Constants.SWADESHI} products.\n\nShare to minimum 10 people.",
            child: IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  Share.share(
                      jsonDecode(remoteConfig.getString("app_share"))["data"]);
                }),
          ),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: isInternetConnected
                  ? () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => SearchPage()));
                    }
                  : null),

          //IconButton(icon: Icon(Icons.notifications_none), onPressed: () {})
        ],
      ),
      body: !isInternetConnected
          ? Center(
              child: Text(
                "You are offline.\n\nPlease connect to internet and restart the app.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            )
          : _getPage(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
              title: Text("WeDeshi"), icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              title: Text("Brands"), icon: Icon(Icons.shopping_basket)),
          BottomNavigationBarItem(
              title: Text("Submit Brand"), icon: Icon(Icons.add_box)),
          BottomNavigationBarItem(
              title: Text("More"), icon: Icon(Icons.more_vert)),
        ],
        onTap: (selectedValue) {
          setState(() {
            _selectedIndex = selectedValue;
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }
}
