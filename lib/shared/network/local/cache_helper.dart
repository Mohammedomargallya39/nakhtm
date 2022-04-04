import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;
  static Future<bool> putBoolean({required String key, required bool value ,})async {
    return await sharedPreferences.setBool(key, value);
  }
  static init()async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
  static Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    return await sharedPreferences.setDouble(key, value);
  }
  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }
  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }
}
//
// import 'dart:convert' hide utf8;
// import 'package:nakhtm/error/exceptions.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// abstract class CacheHelper {
//   Future get(String key);
//
//   Future<bool> has(String key);
//
//   Future<bool> put(String key, dynamic value);
//
//   Future<bool> clear(String key);
// }
//
// class CacheImpl extends CacheHelper {
//   final SharedPreferences _sharedPreferences;
//
//   CacheImpl(this._sharedPreferences);
//
//   @override
//   Future<bool> has(String key) async {
//     final bool f = await _basicErrorHandling(() async {
//       return _sharedPreferences.containsKey(key) &&
//           _sharedPreferences.getString(key)!.isNotEmpty;
//     });
//     return f;
//   }
//
//   @override
//   Future<bool> clear(String key) async {
//     final bool f = await _basicErrorHandling(() async {
//       return await _sharedPreferences.remove(key);
//     });
//     return f;
//   }
//
//   @override
//   Future get(String key) async {
//     final f = await _basicErrorHandling(() async {
//       if (await has(key)) {
//         return await jsonDecode(_sharedPreferences.getString(key)!);
//       }
//       return null;
//     });
//     return f;
//   }
//
//   @override
//   Future<bool> put(String key, dynamic value) async {
//     final bool f = await _basicErrorHandling(() async {
//       return await _sharedPreferences.setString(key, jsonEncode(value));
//     });
//     return f;
//   }
// }
//
// extension on CacheHelper {
//   Future<T> _basicErrorHandling<T>(Future<T> Function() onSuccess) async {
//     try {
//       final f = await onSuccess.call();
//       return f;
//     } catch (e) {
//       throw CacheException(e);
//     }
//   }
// }