import 'package:flutter/material.dart';

import 'about.dart';
import 'category.dart';
import 'myQuotes.dart';
import 'quotes.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Tab> myTab = [
    Tab(
      text: 'Quotes',
      icon: Icon(Icons.format_quote_sharp),
    ),
    Tab(
      text: 'My Quotes',
      icon: Icon(Icons.bookmark),
    ),
    Tab(
      text: 'About',
      icon: Icon(Icons.info_outline),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: myTab.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Text(
            'Quotes App',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.white54,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.normal,
            ),
            tabs: myTab,
          ),
        ),
        body: TabBarView(
          children: [
            Quotes(),
            MyQuotes(),
            About(),
          ],
        ),
      ),
    );
  }
}
