import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:app_firebase/models/colores_model.dart';
import 'package:http/http.dart' as http;

class ColorService {
  final String _baseUrl = 'flutter-formas-default-rtdb.firebaseio.com';
  final List<ColorModel> colores = [];

  bool isLoading = true;
  ColorService() {
    this.loadColores();
  }

  Future loadColores() async {
    final url = Uri.https(_baseUrl, 'color.json');
    final res = await http.get(url);
    final Map<String, dynamic> coloresMap = json.decode(res.body);
  }
}
