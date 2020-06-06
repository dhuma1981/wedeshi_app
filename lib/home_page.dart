import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:wedeshi/main.dart';
import 'package:wedeshi/screens/brands_page.dart';
import 'package:wedeshi/screens/category_page.dart';
import 'package:wedeshi/screens/more_page.dart';
import 'package:wedeshi/screens/search_page.dart';
import 'package:wedeshi/screens/submit_brand_page.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:wedeshi/utils/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex;
  GlobalKey _one = GlobalKey();

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    showShowcaseView();
  }

  void showShowcaseView() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => ShowCaseWidget.of(context).startShowCase([
              _one,
            ]));
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
      appBar: AppBar(
        centerTitle: false,
        title: Image.network(
          "https://wedeshi.in/uploads/app/logo.png",
          width: 80,
        ),
        actions: [
          Showcase(
            key: _one,
            title: "Share App",
            description:
                "\nGive priority to ${Constants.SWADESHI} products. Please share the app to maximum number of people to aware for ${Constants.SWADESHI} products.\n\nShare to minimum 10 people.",
            child: IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  Share.share(
                      jsonDecode(remoteConfig.getString("app_share"))["data"]);
                }),
          ),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SearchPage()));
              }),

          //IconButton(icon: Icon(Icons.notifications_none), onPressed: () {})
        ],
      ),
      body: _getPage(_selectedIndex),
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
}
