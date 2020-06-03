import 'package:flutter/material.dart';
import 'package:wedeshi/screens/search_page.dart';

class Widgets {
  static PreferredSizeWidget getCustomAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Text("We Deshi"),
      actions: [
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => SearchPage()));
            }),
        IconButton(icon: Icon(Icons.share), onPressed: () {}),
        IconButton(icon: Icon(Icons.notifications_none), onPressed: () {})
      ],
    );
  }
}
