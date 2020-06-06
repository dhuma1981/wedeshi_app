import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.help_outline),
          title: Text("About Us"),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.info_outline),
          title: Text("Disclaimer"),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.feedback),
          title: Text("Feedback"),
        ),
        Divider(),
        ListTile(
          onTap: () {
            LaunchReview.launch();
          },
          leading: Icon(Icons.rate_review),
          title: Text("Rate Us"),
        ),
        Divider(),
      ],
    );
  }
}
