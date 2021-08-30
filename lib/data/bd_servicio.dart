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
    final path = join(documentsDirectory.path, 'base.db');
    print('=======================Base===================================');
    print(path);
    return await openDatabase(path, version: 1, onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute('''CREATE TABLE combinar (
            Codigo TEXT,
            Color TEXT, 
            Forma TEXT, PRIMARY KEY(Codigo)
            )''');
    });
  }

  Future<List<CombinarModel>> obtieneCombinados() async {
    List<CombinarModel> lstCombinados = [];
    try {
      final db = await database;
      final res = await db.query('combinar', orderBy: 'Color');
      lstCombinados = (res.isNotEmpty) ? res.map((item) => CombinarModel.fromJson(item)).toList() : [];
    } catch (errorsql) {
      print(errorsql.toString());
    } finally {}
    return lstCombinados;
  }
}
