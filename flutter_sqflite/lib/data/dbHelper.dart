import 'dart:async';
import 'package:flutter_sqflite/models/product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  Database? _db;
  Future<Database?> get db async {
    _db ??= await initializeDb();
    return _db;
  }

  // yol oluşturma -- telefon dosyaları içinde errade.db dosyası oluşturmak için
  Future<Database?> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), 'etrade.db');
    var eTradeDb = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return eTradeDb;
  }

  // oluşturulan yolun içindeki veritabanı oluşturmak için
  void createDb(Database db, int version) async {
    await db.execute(
        'Create table products(id integer primary key, name text, description text, unitPrice  integer)');
  }

  // oluşturulan veritabanındaki verilerin tamamını listelemek için
  Future<List<Product>> getProducts() async {
    Database? db = await this.db;
    var result = await db?.query("products");
    return List.generate(result!.length, (index) {
      return Product.fromObject(result[index]);
    });
  }

  // kayıt ekleme (insert) fonksiyonu. int dönüş olcak çünkü kayıt eklenirse 1 eklenemezse 0 dönderecek
  Future<int?> insert(Product product) async {
    Database? db = await this.db;
    var result = await db?.insert("products", product.toMap());
  }

  // silme (delete) fonksiyonu
  Future<int?> delete(int id) async {
    Database? db = await this.db;
    var result = await db?.rawDelete("delete from products where id = $id");
    return result;
  }

  // güncelleme (updata) fonksiyonu
  Future<int?> updata(Product product) async {
    Database? db = await this.db;
    var result = await db?.update("products", product.toMap(),
        where: "id=?", whereArgs: [product.id]);
    return result;
  }
}
