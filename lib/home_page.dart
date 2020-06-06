import 'package:flutter/material.dart';
import 'package:wedeshi/common/custom_appbar.dart';
import 'package:wedeshi/screens/brands_page.dart';
import 'package:wedeshi/screens/category_page.dart';
import 'package:wedeshi/screens/more_page.dart';
import 'package:wedeshi/screens/submit_brand_page.dart';
import 'package:showcaseview/showcaseview.dart';

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
      appBar: Widgets.getCustomAppBar(context, key: _one),
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
