import 'dart:async';
import 'dart:math';

import 'package:app_firebase/data/combinacion_servicio.dart';
import 'package:app_firebase/data/servicios.dart';
import 'package:app_firebase/models/models.dart';
import 'package:app_firebase/widgets/animaciones.dart';
import 'package:app_firebase/widgets/circulo.dart';
import 'package:app_firebase/widgets/pentagono.dart';
import 'package:app_firebase/widgets/rectangulo.dart';
import 'package:app_firebase/widgets/triangulo.dart';
import 'package:flutter/material.dart';

class DataProvider {
  static String idFirebase = '';
  static String descripcion = '';
  static String color = '';
  static String colorNombre = '';
  static String colorSeleccionado = '';
  static String formaSeleccionada = '';
  static String forma = '';

  static void limpiar() {
    colorSeleccionado = '';
    formaSeleccionada = '';
  }

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

  static void sincronizar() async {
    final db = new Dbase();
    List<CombinarModel> listCombinadoLocal = await db.obtieneCombinados();
    final combinaServicio = new CombinarService();
    for (var item in listCombinadoLocal) {
      if (item.idFirebase == '') {
        combinaServicio.createCombinaciones(item);
      }
    }
  }

  static void obtieneCombinadosProvider() async {
    final db = new Dbase();
    final listaCombinaciones = await db.obtieneCombinados();
    _streamCombinaController.add(listaCombinaciones);
  }

  static Widget obtenerWidget() {
    if (forma == 'Triangulo') {
      return TrianguloAnimadoPage();
    } else if (forma == 'Rectangulo') {
      return RectanguloAnimadoPage();
    } else if (forma == 'Cuadrado') {
      return CuadradoAnimado();
    } else if (forma == 'Circulo') {
      return CirculoAnimadoPage();
    } else if (forma == 'Pentagono') {
      return PentagonoAnimadoPage();
    } else {
      return TrianguloAnimadoPage();
    }
  }

  static double randomNumber() {
    var random = new Random();
    int min = 10;
    int max = 200;
    int result = min + random.nextInt(max - min);
    return result.toDouble();
  }

  /// ---------------- CIERRES DE LOS STREAMS ---------------------------*/
  static dispose() {
    _streamColorController.close();
    _streamCombinaController.close();
    _streamFromasController.close();
  }
}
