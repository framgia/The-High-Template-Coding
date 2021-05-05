import 'package:dio/dio.dart';
import 'package:{{cookiecutter.flutter_package_name}}/models/user.dart';
import 'package:{{cookiecutter.flutter_package_name}}/resources/constants.dart';
import 'package:{{cookiecutter.flutter_package_name}}/utils/utils.dart';

class AuthenticationRepository {
  SharedPreManager _preferences = SharedPreManager();

  Future<void> saveUser(User user) async {
    await _preferences.write<Map>(PreferencesKey.KEY_USER, user.toJson());
  }

  Future getUser() async {
    final jsonUser = await _preferences.read<Map>(PreferencesKey.KEY_USER);
    if (jsonUser == null) return null;
    return User.fromJson(jsonUser);
  }

  Future<void> clearUser() async {
    await _preferences.remove(PreferencesKey.KEY_USER);
  }

  Future<Response> login(Map<String, dynamic> request) async {
    //dummy response
    await Future.delayed(Duration(seconds: 3));
    return Response(data: request, requestOptions: RequestOptions(path: ""));
  }

  Future<Response> register(Map<String, dynamic> request) async {
    //dummy response
    await Future.delayed(Duration(seconds: 3));
    return Response(data: request, requestOptions: RequestOptions(path: ""));
  }

  Future<Response> forgetPassword(String? email) async {
    //dummy response
    await Future.delayed(Duration(seconds: 3));
    return Response(data: true, requestOptions: RequestOptions(path: ""));
  }
}
