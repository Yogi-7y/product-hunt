import 'dart:convert';

import 'package:product_hunt/core/api/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/utils/logger.dart';

final _logger = getLogger('LocalState');

class LocalState {
  LocalState._();
  static final LocalState _instance = LocalState._();
  static LocalState get instance => _instance;

  late SharedPreferences _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> storeInt(String key, int value) async =>
      _sharedPreferences.setInt(key, value);

  int? getInt(String key) => _sharedPreferences.getInt(key);

  Future<void> storeObject(String key, Object data) async {
    final jsonEncoded = json.encode(data);
    await _sharedPreferences.setString(key, jsonEncoded);
  }

  dynamic getObject(String key) {
    final result = _sharedPreferences.getString(key);
    return json.decode(result!);
  }

  Future<void> storeSessionId(String id) async {
    await _sharedPreferences.setString(kSessionId, id);
    _logger.i('Session id updated: $sessionId');
    DioClient.instance.refresh();
  }

  Future<void> setUserLoggedInStatus({bool isLoggedIn = true}) async {
    await _sharedPreferences.setBool(kLoggedInId, isLoggedIn);
    _logger.i('User logged in: $sessionId');
    DioClient.instance.refresh();
  }

  String? get sessionId => _sharedPreferences.getString(kSessionId);
  bool get isUserLoggedIn => _sharedPreferences.getBool(kLoggedInId) ?? false;
}

const kSessionId = 'session_id';
const kLoggedInId = 'logged_in';
