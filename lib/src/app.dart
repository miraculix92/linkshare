import 'package:flutter/material.dart';
import 'ui/linkList.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: LinkList(),
      ),
    );
  }
}