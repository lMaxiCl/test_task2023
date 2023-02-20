import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart' as shelf_router;

import 'user.dart';

List<User> _existedUsers = [];
List<String> _forbiddenDomains = const ['example.com', 'test.com'];

void main() async {
  final cascade = Cascade().add(_router);
  final handler =
      const Pipeline().addMiddleware(logRequests()).addHandler(cascade.handler);

  var server = await shelf_io.serve(handler, 'localhost', 8080);

  server.autoCompress = true;

  print('Serving at http://${server.address.host}:${server.port}');
}

final _router = shelf_router.Router()
  ..get('/data', _readData)
  ..get('/auth', _auth)
  ..get('/sign_up', _signUp)
  ..get('/sign_out', _signOut);

Response _readData(Request request) {
  print('DataReadrequest');
  try {
    if (_existedUsers
        .any((element) => element.token == request.headers['token'])) {
      return Response.ok(jsonEncode({
        'data': _existedUsers
            .firstWhere((element) => element.token == request.headers['token'])
            .login
      }));
    } else {
      return Response.forbidden('');
    }
  } catch (e) {
    print('DataReadrequest error');
    return Response.internalServerError();
  }
}

Response _auth(Request request) {
  print('Auth request ${request.headers}');
  try {
    User user = User(
      request.headers['login']!,
      request.headers['password']!,
      _generateToken(),
    );
    if (_existedUsers.any(
      (element) =>
          (element.password == user.password && element.login == user.login),
    )) {
      _existedUsers.insert(
          _existedUsers.indexWhere((element) => element.login == user.login),
          user);
      return Response.ok(jsonEncode(user.toJson()));
    } else {
      return Response.unauthorized(jsonEncode({}));
    }
  } catch (e) {
    return Response.internalServerError();
  }
}

Response _signUp(Request request) {
  try {
    User user = User(
      request.headers['login']!,
      request.headers['password']!,
      _generateToken(),
    );
    if (_forbiddenDomains.any((element) => user.login.endsWith(element))) {
      return Response.badRequest();
    }
    _existedUsers.add(user);
    return Response.ok(jsonEncode(user.toJson()));
  } catch (e) {
    return Response.internalServerError();
  }
}

Response _signOut(Request request) {
  try {
    User user = User.fromJson(request.params);
    _existedUsers.firstWhere((element) => element.login == user.login).token =
        null;
    return Response.ok({});
  } catch (e) {
    return Response.internalServerError();
  }
}

String _generateToken() {
  return '123';
}
