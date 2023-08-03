import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'featuers/yandex_tile_page.dart';

class YaMapApp extends StatelessWidget {
  const YaMapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yandex map test task',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: YaMapHomePage(),
    );
  }
}
