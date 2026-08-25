import 'package:shared_preferences/shared_preferences.dart';


class RemoteWorkStorage {

  static const String _startTimeKey =
      'remote_work_start_time';



  /// Save remote work start time
  static Future<void> saveStartTime(
      DateTime time,
      ) async {

    final prefs =
    await SharedPreferences.getInstance();


    await prefs.setString(
      _startTimeKey,
      time.toIso8601String(),
    );
  }



  /// Get saved remote work start time
  static Future<DateTime?> getStartTime() async {

    final prefs =
    await SharedPreferences.getInstance();


    final value =
    prefs.getString(
      _startTimeKey,
    );


    if (value == null) {
      return null;
    }


    return DateTime.tryParse(
      value,
    );
  }




  /// Clear remote work start time
  static Future<void> clearStartTime() async {

    final prefs =
    await SharedPreferences.getInstance();


    await prefs.remove(
      _startTimeKey,
    );
  }

}