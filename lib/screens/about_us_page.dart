import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:wedeshi/common/custom_appbar.dart';
import 'package:wedeshi/home_page.dart';
import 'package:wedeshi/utils/constants.dart';
import 'package:connectivity/connectivity.dart';

class AboutUsPage extends StatefulWidget {
  final String aboutUsText;

  AboutUsPage({this.aboutUsText});

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ReactionDisposer _disposer;

  @override
  void initState() {
    initReaction();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: Widgets.getCustomAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Center(
              child: Text(
                Constants.ABOUT_US,
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.aboutUsText,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }
}
