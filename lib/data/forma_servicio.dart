import 'dart:convert';

import 'package:app_firebase/models/forma_model.dart';
import 'package:http/http.dart' as http;

class FromaService {
  final String _baseUrl = 'flutter-formas-default-rtdb.firebaseio.com';
  final List<FormaModel> formas = [];

  //bool isLoading = true;
  // FromaService() {
  //   this.loadFormas();
  // }
  Future<List<FormaModel>> loadFormas() async {
    final url = Uri.https(_baseUrl, 'forma.json');
    final res = await http.get(url);
    final Map<String, dynamic> formaMap = json.decode(res.body);
    formaMap.forEach((key, value) {
      final temForma = FormaModel.fromJson(value);
      temForma.id = key;
      this.formas.add(temForma);
    });
    return this.formas;
  }
}
