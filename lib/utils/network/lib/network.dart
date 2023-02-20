library network;

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:network/objects/data.dart';
import 'package:network/objects/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _serverAddress = 'http://10.0.2.2:8080';

class NetworkManager {
  static NetworkManager get instance => _instance;
  // static Stream<User?> get authStream =>
  //     instance._authStatusStreamController.stream;

  static final NetworkManager _instance = NetworkManager._privateConstructor();

  //Todo: implement navigation from stream
  // // final StreamController<User?> _authStatusStreamController =
  //     StreamController<User?>(
  //         onListen: () => print('subscriber added'),
  //         onPause: () => print('pause'),
  //         onResume: () => print('resume'),
  //         onCancel: () => print('stream subscription canceled'));

  Future<Data?> getDataFromServer() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      Response? response = await _intercept(
        _client.get(Uri.parse('$_baseUrl/data'),
            headers: {'token': preferences.getString('token') ?? ''}),
      );
      if (response?.body != null) {
        return Data.fromJson(
          jsonDecode(response?.body ?? ''),
        );
      } else {
        throw Exception('Request returned null');
      }
    } on Exception catch (e) {
      rethrow;
    }
  }

  Future<User?> signUp(String login, String password) async {
    Response? response = await _intercept(
      _client.get(
        Uri.parse('$_baseUrl/sign_up'),
        headers: {'login': login, 'password': password},
      ),
    );
    if (response?.body != null) {
      User user = User.fromJson(
        jsonDecode(response!.body),
      );
      _setTokenToCache(user.token);
      return user;
      // _authStatusStreamController.add(user);
    } else {
      throw Exception('request returned null');
    }
  }

  Future<User?> signIn(String login, String password) async {
    Response? response = await _intercept(
      _client.get(
        Uri.parse('$_baseUrl/auth'),
        headers: {'login': login, 'password': password},
      ),
    );
    if (response?.body != null) {
      User user = User.fromJson(
        jsonDecode(response!.body),
      );
      _setTokenToCache(user.token);
      return user;
      // _authStatusStreamController.add(user);
    } else {
      throw Exception('request returned null');
    }
  }

  Future<void> logOut() async {
    try {
      await _intercept(
        instance._client.get(
          Uri.parse('$_baseUrl/logOut'),
        ),
      );
    } catch (e) {
      throw Exception('logout failed');
    }
  }

  //Private part
  NetworkManager._privateConstructor();

  static const _baseUrl = _serverAddress;
  final Client _client = Client();

  static Future<void> _setTokenToCache(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('token', token);
  }

  static Future<Response?> _intercept<T extends Future<Response>>(
      T response) async {
    return await response.then((value) {
      switch (value.statusCode) {
        case 401:
          //TODO: implement token refresh
          throw UnimplementedError('Unimplemented token refresh');
        case 403:
          // instance._authStatusStreamController.add(null);
          throw Exception('403 exception');
        default:
          return value;
      }
    });
  }
}
