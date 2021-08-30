import 'dart:async';

import 'package:app_firebase/data/bd_servicio.dart';
import 'package:app_firebase/data/color_servicio.dart';
import 'package:app_firebase/data/forma_servicio.dart';
import 'package:app_firebase/models/colores_model.dart';
import 'package:app_firebase/models/combinar_model.dart';
import 'package:app_firebase/models/forma_model.dart';

class DataProvider {
  static String idFirebase = 'asd';
  static String descripcion = 'asd';
  static String color = '0xff872D2D';
  static String forma = 'Cuadrado';

  /// ---------------- Colores Cargar al Stream y Get del mismo ---------------------------*/
  static final StreamController<List<ColorModel>> _streamColorController = new StreamController.broadcast();
  static final StreamController<List<FormaModel>> _streamFromasController = new StreamController.broadcast();
  static final StreamController<List<CombinarModel>> _streamCombinaController = new StreamController.broadcast();

  static Stream<List<ColorModel>> get streamColorController => _streamColorController.stream;
  static Stream<List<FormaModel>> get streamFormaController => _streamFromasController.stream;
  static Stream<List<CombinarModel>> get streamCombinaController => _streamCombinaController.stream;

  static void obtienerColoresProvider() async {
    final colorService = new ColorService();
    final List<ColorModel> listaColores = await colorService.loadColores();
    _streamColorController.add(listaColores);
  }

  static void obtienerFormasProvider() async {
    final formaService = new FromaService();
    final List<FormaModel> listaFormas = await formaService.loadFormas();
    _streamFromasController.add(listaFormas);
  }

  static void obtieneCombinadosProvider() async {
    final db = new Dbase();
    final listaCombinaciones = await db.obtieneCombinados();
    _streamCombinaController.add(listaCombinaciones);
  }

  /// ---------------- CIERRES DE LOS STREAMS ---------------------------*/
  static dispose() {
    _streamColorController.close();
    _streamCombinaController.close();
    _streamFromasController.close();
  }
}
