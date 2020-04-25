import 'package:flutter/material.dart';

import 'package:layou_catalogue/uitest.dart';

import 'widget/database_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white70),
      home: DatabaseProvider(
        child: UITest(),
      ),
    );
  }
}
