import 'package:flutter_bloc_base/src/data/local/pref/pref_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs extends PrefHelper {
  static const String FIRST_RUN = "first_run";

  @override
  Future<bool> firstRun() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return _preferences.getBool(FIRST_RUN) ?? true;
  }
}