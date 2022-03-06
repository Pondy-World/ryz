import 'dart:async';

import 'package:localstorage/localstorage.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CartController {
  static late Future<Database> database;

  Future<void> mainDBLocation() async {
    print("Data base initiated");
    database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'product_database.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE products(id TEXT, name TEXT,  amount TEXT, count INTEGER, imgurlval TEXT, price TEXT, offer TEXT, offerprice TEXT, weight TEXT)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  Future<void> insertProduct(CrtPds product) async {
    // print(product.toMap());
    // Get a reference to the database.
    final Database db = await database;

    // Insert the Dog into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'products',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertProductEdited(CrtPds product) async {
    // Get a reference to the database.
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: "id = ?",
      whereArgs: [product.id],
    );

    print("_________");
    print(maps.length);
    print("----------");

    if (maps.length > 0) {
      await db.update(
        'products',
        product.toMap(),
        where: "id = ?",
        whereArgs: [product.id],
      );
    } else {
      await db.insert(
        'products',
        product.toMap(),
      );
    }
  }

  Future<List<CrtPds>> productsList() async {
    // Get a reference to the database.
    print("hi");

    Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('products');

    print(maps.toString());

    return List.generate(maps.length, (i) {
      return CrtPds(
          id: maps[i]['id'],
          name: maps[i]['name'],
          amount: maps[i]['amount'],
          count: maps[i]['count'],
          imageURLValue: maps[i]['imgurlval'],
          price: maps[i]['price'],
          offer: maps[i]['offer'],
          offerPrice: maps[i]['offerprice'],
          weight: maps[i]['weight']);
    });
  }

  Future<void> updateCartProduct(CrtPds product) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db.update(
      'products',
      product.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [product.id],
    );
  }

  Future<void> deleteCrtProduct(
    String id,
  ) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'products',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  Future<void> deleteAllProduct() async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete('products');
  }
}

class CartControllerSelf {
  final LocalStorage storage = new LocalStorage('ryxstorage');

  insertProduct(CrtPds2 productDetails) async {
    print(productDetails.toMap());

    List cartData = [];

    try {
      final ready = await storage.ready;

      if (ready) {
        if (storage.getItem('cartelements') == null) {
          print("cart has no data");
          cartData.add(productDetails.toMap());
          print(cartData);

          storage.setItem('cartelements', cartData);
        } else {
          print("cart have data");

          cartData = storage.getItem('cartelements');

          print(cartData);

          var flag = false;
          var itr = 0;
          for (var pds in cartData) {
            if (pds['id'] == productDetails.id) {
              print('product exists in cart');
              flag = true;
              cartData[itr]['count'] = productDetails.count;
            }
            itr++;
          }

          if (flag == false) {
            print('New Prod to cart');
            cartData.add(productDetails.toMap());
          }

          storage.setItem('cartelements', cartData);
        }
      }
    } catch (err) {
      print("error: : " + err.toString());
    }
  }

  List viewProduct() {
    print("View card data");
    print(storage.getItem('cartelements'));
    print("View card data");
    List data = [];
    try {
      data = storage.getItem('cartelements');
      print("View card data");
    } catch (e) {
      print(e);
    }

    return data;
  }

  updateProduct() {}

  deleteProduct(var proddelid) async {
    List cartData = [];

    try {
      final ready = await storage.ready;

      if (ready) {
        print("cart have data");

        cartData = storage.getItem('cartelements');

        print(cartData);

        var itr = 0;
        for (var pds in cartData) {
          if (pds['id'] == proddelid) {
            print('product exists in cart');

            cartData.removeAt(itr);
          }
          itr++;
        }
        storage.setItem('cartelements', cartData);
      }
    } catch (err) {
      print("error: : " + err.toString());
    }
  }
}

class CrtPds {
  final String id;
  final String name;
  final String amount;
  final int count;
  final String imageURLValue;
  final String price;
  final String offer;
  final String offerPrice;
  final String weight;

  CrtPds(
      {required this.id,
      required this.name,
      required this.amount,
      required this.count,
      required this.imageURLValue,
      required this.price,
      required this.offer,
      required this.offerPrice,
      required this.weight});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'count': count,
      'imgurlval': imageURLValue,
      'price': price,
      'offer': offer,
      'offerprice': offerPrice,
      'weight': weight,
    };
  }

  @override
  String toString() {
    return '{sno: $id, '
        'name: $name, '
        'amount: $amount, '
        'count: $count, '
        'imgurlval: $imageURLValue, '
        'price: $price, '
        'offer: $offer, '
        'offerprice: $offerPrice,'
        'weight: $weight}';
  }
}

class CrtPds2 {
  final String id;
  final String name;
  final String amount;
  final int count;
  final String imageURLValue;
  final String price;
  final String offer;
  final String offerPrice;
  final String weight;

  CrtPds2(
      {required this.id,
      required this.name,
      required this.amount,
      required this.count,
      required this.imageURLValue,
      required this.price,
      required this.offer,
      required this.offerPrice,
      required this.weight});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'count': count,
      'imgurlval': imageURLValue,
      'price': price,
      'offer': offer,
      'offerprice': offerPrice,
      'weight': weight,
    };
  }

  @override
  String toString() {
    return '{id: $id, '
        'name: $name, '
        'amount: $amount, '
        'count: $count, '
        'imgurlval: $imageURLValue, '
        'price: $price, '
        'offer: $offer, '
        'offerprice: $offerPrice,'
        'weight: $weight}';
  }

  factory CrtPds2.fromJson(Map<String, dynamic> json) => CrtPds2(
        id: json["id"],
        name: json["name"],
        amount: json["amount"],
        count: json["count"],
        imageURLValue: json["imgurlval"],
        price: json["price"],
        offer: json["offer"],
        offerPrice: json["offerprice"],
        weight: json["weight"],
      );

  void toJSON() {}
}
