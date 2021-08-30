import 'dart:io';

import 'package:app_firebase/models/combinar_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Dbase {
  static Database? _database;
  static final Dbase _db = new Dbase._();

  Dbase._();

  factory Dbase() {
    return _db;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await iniDB();
    return _database!;
  }

  Future<Database> iniDB() async {
    //Path donde esta la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'base6.db');
    print('=======================Base===================================');
    print(path);
    return await openDatabase(path, version: 1, onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute('''CREATE TABLE combinar (
            id INTEGER PRIMARY KEY autoincrement,
            color TEXT, 
            forma TEXT,
            descripcion TEXT,
            idFirebase TEXT
            )''');
    });
  }

  Future<List<CombinarModel>> obtieneCombinados() async {
    List<CombinarModel> lstCombinados = [];
    try {
      final db = await database;
      final res = await db.query('combinar', orderBy: 'color');
      lstCombinados = (res.isNotEmpty) ? res.map((item) => CombinarModel.fromJson(item)).toList() : [];
    } catch (errorsql) {
      print(errorsql.toString());
    } finally {}
    return lstCombinados;
  }

  Future<int> agregaCombinacion(CombinarModel combinar) async {
    int res = 0;
    try {
      final db = await database;
      res = await db.insert('combinar', combinar.toJson());
    } catch (errorsql) {
      print(errorsql.toString());
    } finally {}
    return res;
  }

  Future<List<CombinarModel>> obtienePlatos() async {
    List<CombinarModel> ltsCombinaciones = [];
    try {
      final db = await database;
      final res = await db.query('combinar', orderBy: 'Color');
      ltsCombinaciones = (res.isNotEmpty) ? res.map((item) => CombinarModel.fromJson(item)).toList() : [];
    } catch (errorsql) {
      print(errorsql.toString());
    } finally {}
    return ltsCombinaciones;
  }
}
