import 'dart:async';
import 'package:app_firebase/models/colores_model.dart';
import 'package:app_firebase/models/forma_model.dart';

class DataProvider {


  /// ---------------- Colores Cargar al Stream y Get del mismo ---------------------------*/
  static final StreamController<List<ColorModel>> _streamColorController = new StreamController.broadcast();

  static Stream<List<ColorModel>> get streamColorController => _streamColorController.stream;

  /// ---------------- CIERRES DE LOS STREAMS ---------------------------*/
  static dispose() {
    _streamColorController.close();
  }
}
