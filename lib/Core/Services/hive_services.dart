import 'package:hive/hive.dart';

class HiveServices {
  static changeIsLoginValue({required bool isLogin}) async {
    final loginBox = await Hive.openBox('isLogin');
    await loginBox.put('is_login', isLogin);
    loginBox.close();
  }

  static Future<bool> getIsLoginValue() async {
    final loginBox = await Hive.openBox('isLogin');
    final isLogin = loginBox.get('is_login');
    loginBox.close();
    return isLogin;
  }

  static saveUserData({required String token}) async {
    final userBox = await Hive.openBox('user_box');
    await userBox.put('user_data', token);
    userBox.close();
  }

  static Future<String> getUserData() async {
    final userBox = await Hive.openBox('user_box');
    final userData = userBox.get('user_data');
    userBox.close();
    return userData;
  }
  static clearUserData() async {
    final userBox = await Hive.openBox('user_box');
    await userBox.clear();
    userBox.close();
  }

}
