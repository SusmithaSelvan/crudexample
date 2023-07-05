import 'dart:io';

import 'package:dart_mysql_application/routes.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

void main(List<String> args) async {
  final router = createRouter();

  final ip = InternetAddress.anyIPv4;
  print(ip);
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(router);

  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}, ${server.address.host}');
}
