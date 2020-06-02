import 'package:flutter/material.dart';
import 'package:wedeshi/screens/brands_page.dart';
import 'package:wedeshi/screens/more_page.dart';
import 'package:wedeshi/screens/submit_brand_page.dart';
import 'package:wedeshi/screens/wedeshi_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  Widget _getPage(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return WeDeshiPage();
      case 1:
        return BrandsPage();
      case 2:
        return SubmitBrandPage();
      case 3:
        return MorePage();
    }
    return WeDeshiPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("We Deshi"),
        actions: [
          IconButton(icon: Icon(Icons.notifications_none), onPressed: () {})
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
              title: Text("Brands"), icon: Icon(Icons.branding_watermark)),
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
