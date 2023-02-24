import 'package:flutter/material.dart';
import 'package:frontend/widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: const <Widget>[
        //search_bar,
        SearchBar(),
      ],
    ));
  }
}
