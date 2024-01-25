import 'package:flutter/material.dart';
import 'package:istorija_srbije/screens/asset.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('hello'),
        Asset(
          icon: 'heart.png',
          number: 0,
        )
      ],
    );
  }
}
