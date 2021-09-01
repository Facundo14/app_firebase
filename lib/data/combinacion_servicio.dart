import 'dart:convert';

import 'package:app_firebase/models/combinar_model.dart';
import 'package:http/http.dart' as http;

class CombinarService {
  final String _baseUrl = 'flutter-formas-default-rtdb.firebaseio.com';
  final List<CombinarModel> combinaciones = [];

  Future<List<CombinarModel>> loadCombinaciones() async {
    final url = Uri.https(_baseUrl, 'combinar.json');
    final res = await http.get(url);
    final Map<String, dynamic> combinaMap = json.decode(res.body);
    combinaMap.forEach((key, value) {
      final temCombina = CombinarModel.fromJson(value);
      temCombina.color = key;
      this.combinaciones.add(temCombina);
    });
    return this.combinaciones;
  }

  Future<String> createCombinaciones(CombinarModel combinaciones) async {
    final url = Uri.https(_baseUrl, 'combinar.json');
    final resp = await http.post(url, body: combinaciones.toJson());
    final decodedData = json.decode(resp.body);
    combinaciones.idFirebase = decodedData['idFirebase'];
    print(combinaciones.idFirebase);
    return combinaciones.idFirebase!;
  }
}
