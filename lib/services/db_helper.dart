// lib/services/db_helper.dart
import 'package:flutter_task_essam_elmetwally/models/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  DBHelper._();
  static final DBHelper instance = DBHelper._();

  static const _dbName = 'products_app.db';
  static const _dbVersion = 1;
  static const tableProducts = 'products';

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);
    _db = await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    return _db!;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableProducts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        imagePath TEXT NOT NULL,
        price TEXT NOT NULL,
        oldPrice TEXT,
        soldCount TEXT,
        category TEXT
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldV, int newV) async {
    // handle migrations if needed in future
  }

  // CRUD
  Future<int> insertProduct(Product p) async {
    final db = await database;
    return await db.insert(tableProducts, p.toMap());
  }

  Future<List<Product>> getAllProducts() async {
    final db = await database;
    final rows = await db.query(tableProducts, orderBy: 'id DESC');
    return rows.map((r) => Product.fromMap(r)).toList();
  }

  // Future<Product?> getProductById(int id) async {
  //   final db = await database;
  //   final rows = await db.query(
  //     tableProducts,
  //     where: 'id = ?',
  //     whereArgs: [id],
  //   );
  //   if (rows.isEmpty) return null;
  //   return Product.fromMap(rows.first);
  // }

  Future<List<Product>> getProductsByCategory(String category) async {
    final db = await database;
    final rows = await db.query(
      tableProducts,
      where: 'category = ?',
      whereArgs: [category],
      orderBy: 'id DESC',
    );
    return rows.map((r) => Product.fromMap(r)).toList();
  }

  Future<int> updateProduct(Product p) async {
    final db = await database;
    return db.update(
      tableProducts,
      p.toMap(),
      where: 'id = ?',
      whereArgs: [p.id],
    );
  }

  Future<int> deleteProduct(int id) async {
    final db = await database;
    return db.delete(tableProducts, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearAll() async {
    final db = await database;
    await db.delete(tableProducts);
  }
}
