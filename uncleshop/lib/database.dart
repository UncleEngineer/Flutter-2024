import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uncleshop/product.dart';

class DatabaseSQL {
  // Attribute
  String DB_NAME = 'shop.sqlite3';
  String TABLE = 'Product';
  String ID = 'id';
  String NAME = 'name';
  String QUANTITY = 'quantity';
  String PRICE = 'price';
  String TOTAL = 'total';
  String STATUS = 'status';

  Future initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), DB_NAME),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE $TABLE(
          $ID INTEGER PRIMARY KEY AUTOINCREMENT,
          $NAME TEXT,
          $QUANTITY INTEGER,
          $PRICE REAL,
          $TOTAL REAL,
          $STATUS INTEGER
        )
        ''');
      },
    );
  }

  // CRUD method
  Future createProduct(Product product) async {
    final database = await initDatabase();
    return await database.insert(TABLE, product.toMap());
  }

  Future<List<Product>> readProducts() async {
    final database = await initDatabase();
    final List<Map<String, dynamic>> maps = await database.query(TABLE);
    return List.generate(
        maps.length,
        (index) => Product(
            id: maps[index][ID],
            name: maps[index][NAME],
            quantity: maps[index][QUANTITY],
            price: maps[index][PRICE],
            total: maps[index][TOTAL],
            status: maps[index][STATUS] == 1));
  }

  Future updateProduct(Product product) async {
    final database = await initDatabase();
    return await database.update(TABLE, product.toMap(),
        where: 'id = ?', whereArgs: [product.id]);
  }

  Future deleteProduct(int id) async {
    final database = await initDatabase();
    return await database.delete(TABLE, where: 'id = ?', whereArgs: [id]);
  }
}
