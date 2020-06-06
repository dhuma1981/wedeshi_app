import 'package:flutter/material.dart';
import 'package:wedeshi/common/custom_appbar.dart';
import 'package:wedeshi/utils/constants.dart';

class DisclaimerPage extends StatelessWidget {
  final String disclaimerText;

  DisclaimerPage({this.disclaimerText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.getCustomAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Center(
              child: Text(
                Constants.DISCLAIMER,
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              disclaimerText,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
