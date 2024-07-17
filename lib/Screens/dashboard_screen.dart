// ignore_for_file: prefer_const_constructors
import 'package:campuspro/Screens/Wedgets/drawer.dart';
import 'package:flutter/material.dart';

class DashBoradScreen extends StatefulWidget {
  const DashBoradScreen({super.key});

  @override
  State<DashBoradScreen> createState() => _DashBoradScreenState();
}

class _DashBoradScreenState extends State<DashBoradScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("DashBoard"),
      ),
      drawer: AppDrawer(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [],
      ),
    );
  }
}
