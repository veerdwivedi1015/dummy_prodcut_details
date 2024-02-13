import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefSingleton {
  static final SharedPrefSingleton _instance = SharedPrefSingleton._internal();
  factory SharedPrefSingleton() => _instance;
  SharedPrefSingleton._internal();
  SharedPreferences? _pref;
  Future<void> initialize() async {
    _pref = await SharedPreferences.getInstance();
  }

  Future<SharedPreferences> getInstance() async {
    if (_pref == null) {
      await initialize();
    }
    return _pref!;
  }
}
