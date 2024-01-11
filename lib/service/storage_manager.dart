import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static void saveData( String key, dynamic value ) async {
    final prefs = await SharedPreferences.getInstance();

    if( value is String ) {
      prefs.setString(key, value);
    }
    else if( value is int ) {
      prefs.setInt(key, value);
    }
    else if( value is double ) {
      prefs.setDouble(key, value);
    }
    else if( value is bool ) {
      prefs.setBool(key, value);
    }
    else if( value is List<String> ) {
      prefs.setStringList(key, value);
    }
    else {
      throw Exception("Unsupported type");
    }
  }

  static Future<dynamic> getData( String key ) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.get( key );
  }
}