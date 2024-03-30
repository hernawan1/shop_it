// import 'package:path_provider/path_provider.dart';
import 'dart:async';

import 'package:shop_it/src/cart/model/cart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class CartProvider {
  CartProvider._();

  static final CartProvider db = CartProvider._();

  Future<Database> init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'cart.db');
    // ignore: unused_local_variable
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE keranjang(id INTEGER PRIMARY KEY, title TEXT, image Text, price INTEGER, sum INTEGER)',
      );
    });
  }

  Future<int> addItem(Item item) async {
    final db = await init();
    return db.insert('keranjang', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Item>> fetchCart() async {
    final db = await init();
    final List<Map<String, dynamic>> maps = await db.query('keranjang');
    return List.generate(maps.length, (i) {
      return Item(
        id: maps[i]['id'],
        title: maps[i]['title'],
        image: maps[i]['image'],
        price: maps[i]['price'],
        sum: maps[i]['sum'],
      );
    });
  }

  getalldata() async {
    final db = await init();
    final maps = await db.query('keranjang');
    return List.generate(
        maps.length,
        (i) => {
              'id': maps[i]['id'],
              'title': maps[i]['title'],
              'image': maps[i]['image'],
              'price': maps[i]['price'],
              'sum': maps[i]['sum'],
            });
  }

  getcashdata() async {
    final db = await init();
    final maps = await db.query('keranjang');
    return List.generate(
        maps.length,
        (i) => {
              'id': maps[i]['id'],
              'title': maps[i]['title'],
              'image': maps[i]['image'],
              'price': maps[i]['price'],
              'sum': maps[i]['sum'],
            });
  }

  Future<void> updateCart(int id, int sum) async {
    final db = await init();
    await db.update(
      'keranjang',
      {'sum': sum},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteCart(int id) async {
    final db = await init();
    await db.delete(
      'keranjang',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteCartAll() async {
    final db = await init();
    await db.delete('keranjang');
  }

  Future countCart() async {
    final dbClient = await init();
    final result = await dbClient.rawQuery('SELECT COUNT(*) FROM keranjang');
    Object? value = result[0]['COUNT(*)'];
    return value;
  }

  Future calculateTotal() async {
    final dbClient = await init();
    final result =
        await dbClient.rawQuery('SELECT SUM(price*sum) FROM keranjang');
    Object? value = result[0]['SUM(price*sum)'];
    return value;
  }
}
