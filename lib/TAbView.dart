// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CI_Calc.dart';
import 'SI_Calc.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<StatefulWidget> createState() => _TabState();
}

class _TabState extends State<Tabs> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            "Earn Smart: Interest Tracker",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          titleSpacing: 0.0,
          backgroundColor: CupertinoColors.systemIndigo,
          foregroundColor: CupertinoColors.white,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Simple Interest",
              ),
              Tab(
                text: "Compound Interest",
              ),
            ],
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
            indicatorColor: Color(0xfff50057),
            indicatorWeight: 1.0,
            tabAlignment: TabAlignment.center,
            unselectedLabelColor: Colors.black,
          ),
        ),
        body: TabBarView(
          children: const [
            Center(
              child: SI_Calc(),
            ),
            Center(child: CI_Calc()),
          ],
        ),
      ),
    );
  }
}
