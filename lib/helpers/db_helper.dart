// helpers/db_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/client.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();
  static Database? _database;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('hotel_clients.db');
    return _database!;
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    
CREATE TABLE clients (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nom TEXT NOT NULL,
  prenoms TEXT NOT NULL,
  naissance_date TEXT NOT NULL,
  naissance_lieu TEXT NOT NULL,
  pere TEXT NOT NULL,
  mere TEXT NOT NULL,
  profession TEXT NOT NULL,
  domicile TEXT NOT NULL,
  adresse TEXT NOT NULL,
  telephone TEXT NOT NULL,
  nationalite TEXT NOT NULL,
  piece_type TEXT NOT NULL,
  piece_numero TEXT NOT NULL,
  piece_delivrance_date TEXT NOT NULL,
  piece_delivrance_lieu TEXT NOT NULL,
  delivrance_by TEXT NOT NULL,
  photo_recto TEXT,
  photo_verso TEXT,
  numero_chambre TEXT NOT NULL,
  signature BLOB NOT NULL,
  destination TEXT NOT NULL,
  date_entree TEXT NOT NULL,
  date_sortie TEXT NOT NULL,
  user_id INTEGER NOT NULL,
  nb_mineur INTEGER DEFAULT 0
)
    ''');
  }

  Future<int> insertClient(Client client) async {
    final db = await instance.database;
    return await db.insert('clients', client.toMap());
  }

  Future<List<Client>> getAllClients() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('clients');
    return maps.map((map) => Client.fromMap(map)).toList();
  }
}
