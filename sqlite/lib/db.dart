import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqlite/animal.dart';

class DB {
  static Future<Database> _openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'animales.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE animales (id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT, especie TEXT)",
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(Animal animal) async {
    Database database = await _openDB();
    await database.insert("animales", animal.toMap());
  }

  static Future<void> delete(Animal animal) async {
    Database database = await _openDB();
    await database.delete("animales", where: "id = ?", whereArgs: [animal.id]);
  }

  static Future<void> update(Animal animal) async {
    Database database = await _openDB();
    await database.update("animales", animal.toMap(), where: "id = ?", whereArgs: [animal.id]);
  }

  static Future<List<Animal>> animales() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> animalesMap = await database.query("animales");
    return List.generate(
      animalesMap.length,
      (i) => Animal(
        id: animalesMap[i]['id'],
        nombre: animalesMap[i]['nombre'],
        especie: animalesMap[i]['especie'],
      ),
    );
  }
}