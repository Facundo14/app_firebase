import 'package:app_firebase/provider/data_provider.dart';
import 'package:flutter/material.dart';

class DemostracionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demostracion'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        children: [
          Text(DataProvider.color),
          Text(DataProvider.forma),
        ],
      )),
    );
  }
}
