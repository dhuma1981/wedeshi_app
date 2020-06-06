import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:wedeshi/main.dart';
import 'package:wedeshi/screens/search_page.dart';

class Widgets {
  static PreferredSizeWidget getCustomAppBar(BuildContext context,
      {Function onShare}) {
    return AppBar(
      centerTitle: false,
      title: Image.network(
        "https://wedeshi.in/uploads/app/logo.png",
        width: 80,
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              onShare != null
                  ? onShare()
                  : Share.share(
                      jsonDecode(remoteConfig.getString("app_share"))["data"]);
            }),
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => SearchPage()));
            }),

        //IconButton(icon: Icon(Icons.notifications_none), onPressed: () {})
      ],
    );
  }
}
