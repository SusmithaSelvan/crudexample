import 'package:mysql1/mysql1.dart';

late MySqlConnection connection;

class ProductDbController{
Future<void> connect() async {
    final settings = ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      password: 'Sairam@123',
      db: 'productdatabase',
    );

    connection = await MySqlConnection.connect(settings);
  }
}