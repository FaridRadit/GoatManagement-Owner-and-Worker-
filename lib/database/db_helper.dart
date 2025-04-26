import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DBHelper {
  static Database? _db;

  static Future<void> deleteDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'kambing.db');

    // Tutup koneksi sebelum menghapus
    if (_db != null) {
      await _db!.close();
      _db = null;
    }

    await deleteDatabase(path);
    print("Database deleted.");
  }

  static Future<Database> get db async {
    if (_db != null) return _db!;
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'kambing.db');

    _db = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE mitra (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT,
            desa TEXT,
            nama_pengecek TEXT,
            nama_pendamping TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE kambing (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nomorKambing INTEGER,
            kondisi TEXT,
            keterangan TEXT,
            foto TEXT,
            mitraId INTEGER,
            FOREIGN KEY (mitraId) REFERENCES mitra(id) ON DELETE CASCADE
          )
        ''');

        await db.execute('''
          CREATE TABLE foto_kambing (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            path TEXT,
            kambingId INTEGER,
            FOREIGN KEY(kambingId) REFERENCES kambing(id) ON DELETE CASCADE
          )
        ''');
      },
    );

    return _db!;
  }
}
