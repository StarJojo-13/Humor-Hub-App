import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/chiste_model.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
    
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'chistes.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE chistes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            texto TEXT NOT NULL,
            categoria TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> insertarChiste(Chiste chiste) async {
    final db = await database;
    await db.insert(
      'chistes',
      chiste.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Chiste>> obtenerChistesPorCategoria(String categoria) async {
    final db = await database;
    final maps = await db.query(
      'chistes',
      where: 'categoria = ?',
      whereArgs: [categoria],
    );
    return List.generate(maps.length, (i) => Chiste.fromMap(maps[i]));
    
  }

  Future<void> eliminarTodosLosChistes() async {
  final db = await database;
  await db.delete('chistes');
}

}
