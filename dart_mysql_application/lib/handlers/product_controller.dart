import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:dart_mysql_application/model/product_details.dart';

import '../database/product_details_db.dart';

class ProductController {
 // late MySqlConnection connection;

  ProductController() {
    final productDbHandler = ProductDbController();
    //_connect();
    productDbHandler.connect();
  }

  

  Future<Response> saveProductDetails(Request request) async {
    final requestBody = await request.readAsString();
    final productJson = jsonDecode(requestBody);
    final result = await connection.query(
        'INSERT INTO product (id, name, price) VALUES (?, ?, ?)',
        [productJson['id'], productJson['name'], productJson['price']]);

    if (result.affectedRows == 1) {
      return Response.ok('Product added');
    }
    return Response.internalServerError();
  }

  Future<Response> updateProductDetails(Request request,String id) async{
  final requestBody = await request.readAsString();
    final productJson = jsonDecode(requestBody);
    final result = await connection.query(
        'UPDATE product SET name = ?, price = ? WHERE id = ?',
        [productJson['name'], productJson['price'], id]);
    if (result.affectedRows == 1) {
      return Response.ok('Product updated');
    }
    return Response.notFound('Product id not found');
  }

  Future<Response> deleteProductDetails(Request request,String id) async{
  final result =
        await connection.query('DELETE FROM product WHERE id = ?', [id]);
    if (result.affectedRows == 1) {
      return Response.ok('Product deleted');
    }
    return Response.notFound('Product id not found');
}

Future<Response> fetchProductDetails(Request request) async {
final results = await connection.query('SELECT * FROM product');
//print(results);
    final listOfproducts = results
        .map((row) => Product(
              id: row['id'],
              name: row['name'],
              price: row['price'],
            ))
        .toList();
    return Response.ok(jsonEncode(listOfproducts.map((e) => e.toJson()).toList()));
 
  }
}

