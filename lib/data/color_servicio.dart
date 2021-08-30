import 'dart:convert';
import 'package:app_firebase/models/models.dart';
import 'package:http/http.dart' as http;

class ColorService {
  final String _baseUrl = 'flutter-formas-default-rtdb.firebaseio.com';
  final List<ColorModel> colores = [];

  Future<List<ColorModel>> loadColores() async {
    final url = Uri.https(_baseUrl, 'color.json');
    final res = await http.get(url);
    final Map<String, dynamic> coloresMap = json.decode(res.body);
    coloresMap.forEach((key, value) {
      final temColores = ColorModel.fromJson(value);
      temColores.id = key;
      this.colores.add(temColores);
    });
    return this.colores;
  }
}
