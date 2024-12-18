import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../dto/user/user.dto.dart';

final class SharedPrefs {
  static const String prefsVersion = '2.1';
  static const String _employeeKey = 'employee';

  final String _version = '0.0.2';

  String get version => _version;

  set employee(UserDto? employeeDto) {
    saveEmployee(employeeDto);
  }

  set isChange(bool value) {
    saveChange(value);
  }

  set accessToken(String? value) {
    saveToken(value);
  }

  set hallId(int? value) {
    saveHallId(value);
  }

  set tableClothId(int? value) {
    saveTableClothId(value);
  }

  ///token
  Future<void> saveToken(String? token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token ?? '');
  }

  // Get token from SharedPreferences
  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  ///hallId
  Future<void> saveHallId(int? hallId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('access_hallId', hallId ?? 0);
  }

  // Get hallId from SharedPreferences
  Future<int?> getHallId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('access_hallId');
  }

  ///tableClothId
  Future<void> saveTableClothId(int? tableClothId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('access_tableClothId', tableClothId ?? 0);
  }

  // Get tableClothId from SharedPreferences
  Future<int?> getTableClothId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('access_tableClothId');
  }

  ///isChange
  Future<void> saveChange(bool? change) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('access_change', change ?? false);
  }

  // Get change from SharedPreferences
  Future<bool?> getChange() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('access_change');
  }

  Future<void> removeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
  }

  ///employee
  Future<void> saveEmployee(UserDto? employee) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String employeeJson = jsonEncode(employee?.toJson());
    await prefs.setString(_employeeKey, employeeJson);
  }

  // Get Employee object from SharedPreferences
  Future<UserDto?> getEmployee() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? employeeJson = prefs.getString(_employeeKey);
    if (employeeJson != null) {
      Map<String, dynamic> json = jsonDecode(employeeJson);
      return UserDto.fromJson(json);
    }
    return null;
  }

  // Remove Employee object from SharedPreferences
  Future<void> removeEmployee() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_employeeKey);
  }
}
