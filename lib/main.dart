import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:wedeshi/home_page.dart';
import 'package:showcaseview/showcaseview.dart';

RemoteConfig remoteConfig;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    remoteConfig = await RemoteConfig.instance;
    await remoteConfig.fetch(expiration: Duration(seconds: 0));
    await remoteConfig.activateFetched();
  } catch (e) {
    print(e.toString());
  }
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: ShowCaseWidget(builder: Builder(builder: (_) => HomePage())),
    );
  }
}
