import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/client.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('clients.db');
    return _database!;
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';

    await db.execute('''
    CREATE TABLE clients(
      id $idType,
      nom $textType,
      prenoms $textType,
      naissance_date $textType,
      naissance_lieu $textType,
      pere $textType,
      mere $textType,
      profession $textType,
      domicile $textType,
      adresse $textType,
      telephone $textType,
      nationalite $textType,
      piece_type $textType,
      piece_numero $textType,
      piece_delivrance_date $textType,
      piece_delivrance_lieu $textType,
      photo_recto $textType,
      photo_verso $textType,
      empreinte $textType,
      audio $textType,
      signature $textType,
      destination $textType,
      date_entree $textType,
      date_sortie $textType,
      date_enregistrement $textType,
      utilisateur_id $intType
    )
    ''');
  }

  Future<int> insertClient(Client client) async {
    final db = await instance.database;
    return db.insert('clients', client.toMap());
  }

  Future<List<Client>> getAllClients() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('clients');
    return List.generate(maps.length, (i) => Client.fromMap(maps[i]));
  }
}
