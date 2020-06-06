import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:wedeshi/screens/about_us_page.dart';
import 'package:wedeshi/screens/disclaimer_page.dart';
import 'package:wedeshi/utils/constants.dart';

RemoteConfig remoteConfig;

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  String aboutUs = "";
  String disclaimer = "";

  @override
  void initState() {
    super.initState();
    fetchRemoteConfig();
  }

  Future<void> fetchRemoteConfig() async {
    remoteConfig = await RemoteConfig.instance;
    await remoteConfig.fetch();
    await remoteConfig.activateFetched();
    aboutUs = jsonDecode(remoteConfig.getString("about_us"))["data"];
    disclaimer = jsonDecode(remoteConfig.getString("disclaimer"))["data"];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => AboutUsPage(
                      aboutUsText: aboutUs,
                    )));
          },
          leading: Icon(Icons.help_outline),
          title: Text(Constants.ABOUT_US),
        ),
        Divider(),
        ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => DisclaimerPage(
                      disclaimerText: disclaimer,
                    )));
          },
          leading: Icon(Icons.info_outline),
          title: Text(Constants.DISCLAIMER),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.feedback),
          title: Text(Constants.FEEDBACK),
        ),
        Divider(),
        ListTile(
          onTap: () {
            LaunchReview.launch();
          },
          leading: Icon(Icons.rate_review),
          title: Text(Constants.RATE_US),
        ),
        Divider(),
      ],
    );
  }
}
