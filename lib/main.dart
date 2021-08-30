import 'package:app_firebase/pages/demostracion_page.dart';
import 'package:app_firebase/pages/home_page.dart';
import 'package:app_firebase/pages/listado_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formas',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      initialRoute: 'home',
      routes: {
        'home': (_) => HomePage(),
        'listado': (_) => ListadoPage(),
        'demostracion': (_) => DemostracionPage(),
      },
    );
  }
}
