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
        child: Text('Hola Mundo'),
      ),
    );
  }
}
