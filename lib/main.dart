import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:wedeshi/home_page.dart';

RemoteConfig remoteConfig;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  remoteConfig = await RemoteConfig.instance;
  await remoteConfig.fetch(expiration: Duration(seconds: 0));
  await remoteConfig.activateFetched();
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
      home: HomePage(),
    );
  }
}
