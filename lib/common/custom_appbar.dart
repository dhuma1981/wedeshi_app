import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:wedeshi/main.dart';
import 'package:wedeshi/screens/search_page.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:wedeshi/utils/constants.dart';

class Widgets {
  static PreferredSizeWidget getCustomAppBar(BuildContext context,
      {Function onShare, GlobalKey key}) {
    return AppBar(
      centerTitle: false,
      title: Image.network(
        "https://wedeshi.in/uploads/app/logo.png",
        width: 80,
      ),
      actions: [
        Showcase(
          key: key,
          title: "Share App",
          description:
              "\nGive priority to ${Constants.SWADESHI} products. Please share the app to maximum number of people to aware for ${Constants.SWADESHI} products.\n\nShare to minimum 10 people.",
          child: IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                onShare != null
                    ? onShare()
                    : Share.share(jsonDecode(
                        remoteConfig.getString("app_share"))["data"]);
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
    );
  }
}
