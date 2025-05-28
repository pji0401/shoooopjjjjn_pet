import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  late final SharedPreferences sharedPreferences;

  static final SharedPreferencesHelper _instance = SharedPreferencesHelper._internal();

  factory SharedPreferencesHelper() => _instance;

  SharedPreferencesHelper._internal();

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> setMemberId(int id) async {
    await sharedPreferences.setInt("memberId", id);
  }

  int get memberId => sharedPreferences.getInt("memberId") ?? 1;
}