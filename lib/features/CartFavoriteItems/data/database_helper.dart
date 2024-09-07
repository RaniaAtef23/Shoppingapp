import 'package:shopping_app/features/Home/data/models/Products.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'cart.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE cart(
            id TEXT PRIMARY KEY,
            title TEXT,
            price REAL,
            quantity INTEGER
          )
        ''');
      },
    );
  }

  Future<void> insertProduct(Products product, int quantity) async {
    final db = await database;
    await db.insert(
      'cart',
      {
        'id': product.id,
        'title': product.title,
        'price': product.price,
        'quantity': quantity,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateProductQuantity(Products product, int quantity) async {
    final db = await database;
    await db.update(
      'cart',
      {'quantity': quantity},
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<void> removeProduct(Products product) async {
    final db = await database;
    await db.delete(
      'cart',
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<List<Products>> getCartProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cart');

    return List.generate(maps.length, (i) {
      return Products(
        id: maps[i]['id'],
        title: maps[i]['title'],
        price: maps[i]['price'],
        // You might need to handle images and ratings if required
      );
    });
  }

  Future<void> clearCart() async {
    final db = await database;
    await db.delete('cart');
  }
}
