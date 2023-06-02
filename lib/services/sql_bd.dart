import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sqflite;

class DatabaseHelper {
  static Future<bool> databaseExists() async {
    final String databasesPath = await sqflite.getDatabasesPath();
    final String dbPath = path.join(databasesPath, 'images.db');
    return await sqflite.databaseExists(dbPath);
  }

  static Future<void> createDatabase() async {
    final String databasesPath = await sqflite.getDatabasesPath();
    final String dbPath = path.join(databasesPath, 'images.db');
    await sqflite.openDatabase(dbPath, version: 1,
        onCreate: (sqflite.Database db, int version) async {
          await db.execute(
            'CREATE TABLE Images (id INTEGER PRIMARY KEY AUTOINCREMENT, imageUrl TEXT)',
          );
        });
  }

  static Future<void> addImageUrl(String imageUrl) async {
    final String databasesPath = await sqflite.getDatabasesPath();
    final String dbPath = path.join(databasesPath, 'images.db');
    final sqflite.Database database =
    await sqflite.openDatabase(dbPath, version: 1);

    await database.insert(
      'Images',
      {'imageUrl': imageUrl},
      conflictAlgorithm: sqflite.ConflictAlgorithm.ignore,
    );
  }

  static Future<void> removeImageUrl(String imageUrl) async {
    final String databasesPath = await sqflite.getDatabasesPath();
    final String dbPath = path.join(databasesPath, 'images.db');
    final sqflite.Database database =
    await sqflite.openDatabase(dbPath, version: 1);

    await database.delete(
      'Images',
      where: 'imageUrl = ?',
      whereArgs: [imageUrl],
    );
  }

  static Future<List<String>> getImageUrls() async {
    final String databasesPath = await sqflite.getDatabasesPath();
    final String dbPath = path.join(databasesPath, 'images.db');
    final sqflite.Database database =
    await sqflite.openDatabase(dbPath, version: 1);

    final List<Map<String, dynamic>> maps = await database.query('Images');
    return List<String>.from(maps.map((map) => map['imageUrl']));
  }
}
