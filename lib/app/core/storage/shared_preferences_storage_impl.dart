import 'dart:convert';

import 'package:project_management_app/app/core/failures/exceptions/app_exception.dart';
import 'package:project_management_app/app/core/storage/storage_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStorageImpl implements IStorage{
  final SharedPreferences storage;

  SharedPreferencesStorageImpl({required this.storage});
  @override
  dynamic get({required String key}) {
    try {
      final dataString = storage.getString(key) ?? '{}';
      final data = json.decode(dataString);
      return data;
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  void remove({required String key}) {
    try {
      storage.remove(key);
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  void set({required String key, required Object value}) {
    try {
      final dataString = json.encode(value);
      storage.setString(key, dataString);
    } catch (e) {
      throw AppException(e.toString());
    }
  }

}