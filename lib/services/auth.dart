import 'dart:io';
import 'package:datingapp/services/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class Auth extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get authenticated => _isLoggedIn;

  bool _isVerified = false;
  bool get verified => _isVerified;

  Map _user;
  Map get current_user => _user;

  Future login(Map creds) async {
    Map res;
    try {
      Dio.Response response = await dio().post('/sanctum/token', data: creds);
      res = response.data;

      if (res['message'] != null && res['token'] != null) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('i-pet-kk', res['token']);
        Dio.Response response = await dio().get('/user',
            options: Dio.Options(
                headers: {'Authorization': 'Bearer ${res['token']}'}));

        _user = response.data;
        print('================');
        print(_user);
        print('================');
        notifyListeners();
        return res;
      }
      // ERROR
      if (res['message'] != null) {
        return res;
      }
      // TOKEN
      if (res['token'] != null) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('i-pet-kk', res['token']);
        Dio.Response response = await dio().get('/user',
            options: Dio.Options(
                headers: {'Authorization': 'Bearer ${res['token']}'}));
        _user = response.data;
        print('------------');
        print(_user);
        print('------------');
        _isLoggedIn = true;
        notifyListeners();
        return true;
      }
    } catch (e) {
      return e;
    }
  }

  Future tryLogin() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('i-pet-kk');
    if (token != null) {
      Dio.Response response = await dio().get('/user',
          options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));

      print(response.data['verified']);
      if (response.data['verified']) {
        _isLoggedIn = true;
        _user = response.data;
        notifyListeners();
        print(_user);
      }
    } else {
      print("No token.");
    }
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('i-pet-kk');
    _isLoggedIn = false;

    notifyListeners();
  }

  Future verifyUser(String otp) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('i-pet-kk');
    print('token');
    print(token);
    print('token');
    try {
      Dio.Response response = await dio().post('/verify_otp?otp=$otp',
          options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.data.toString() == 'approved') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  Future updateProfile(dat) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('i-pet-kk');
    dynamic av = '';
    if (!dat['img'].isEmpty) {
      av = await Dio.MultipartFile.fromFile(
        dat['img'],
        filename: dat['img'].split('/').last,
      );
    }
    Dio.FormData data = Dio.FormData.fromMap({
      "avatar": av,
      "first_name": dat['first_name'],
      "last_name": dat['last_name'],
      "gender": dat['gender'],
    });

    try {
      Dio.Response response = await dio().post('/profile',
          data: data,
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data'
          }));

      return response.data.toString();
    } catch (e) {
      print(e);
    }
  }

  Future addAnimal(dat) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('i-pet-kk');
    dynamic av = '';
    if (!dat['avatar'].isEmpty) {
      av = await Dio.MultipartFile.fromFile(
        dat['avatar'],
        filename: dat['avatar'].split('/').last,
      );
    }
    Dio.FormData data = Dio.FormData.fromMap({
      "avatar": av,
      "name": dat['name'],
      "info": dat['info'],
      "gender": dat['gender'],
      "breed_id": dat['breed_id'],
    });

    try {
      Dio.Response response = await dio().post('/animals',
          data: data,
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data'
          }));
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
    }
  }
}
