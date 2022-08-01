import 'dart:io';
import 'package:PetsMating/services/dio.dart';
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
        try {
          Dio.Response response = await dio().get('/user',
              options: Dio.Options(
                  headers: {'Authorization': 'Bearer ${res['token']}'}));
          _user = response.data;
          print('------------');
          print(_user);
          print('------------');
          _isLoggedIn = true;
        } catch (e) {
          print(e);
        }

        notifyListeners();
        return res;
      }
    } catch (e) {
      return e;
    }
  }

  Future tryLogin(refreshing) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('i-pet-kk');
    print(token);
    if (token != null) {
      try {
        Dio.Response response = await dio().get('/user',
            options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));

        if (refreshing) {
          print('Refreshing ==========================================');
          _user = response.data;
          notifyListeners();
        } else if (response.data['verified']) {
          _isLoggedIn = true;
          _user = response.data;
          notifyListeners();
          print(_user);
        }
      } catch (e) {
        print(e);
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

      if (response.data.toString() == 'Approved') {
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
    if (dat['img'].isNotEmpty) {
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
      print(data.fields);
      Dio.Response response = await dio(multipart: true).post('/profile',
          data: data,
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $token',
          }));

      return response;
    } catch (e) {
      print(e);
    }
  }

  Future editProfile(dat) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('i-pet-kk');

    Dio.FormData data = Dio.FormData.fromMap({
      "first_name": dat['first_name'],
      "last_name": dat['last_name'],
    });

    try {
      Dio.Response response = await dio(multipart: true).post('/edit-profile',
          data: data,
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $token',
          }));

      return response;
    } catch (e) {
      print(e);
    }
  }

  Future editProfileImage(dat) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('i-pet-kk');
    dynamic av = '';
    if (dat['img'].isNotEmpty) {
      av = await Dio.MultipartFile.fromFile(
        dat['img'],
        filename: dat['img'].split('/').last,
      );
    }

    Dio.FormData data = Dio.FormData.fromMap({
      "avatar": av,
    });

    try {
      print(data.fields);
      Dio.Response response =
          await dio(multipart: true).post('/edit-profile-image',
              data: data,
              options: Dio.Options(headers: {
                'Authorization': 'Bearer $token',
              }));

      return response;
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
      "vaccinated": dat['vaccinated'],
      "dob": dat['dob'],
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

  Future updateAnimal(dat) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('i-pet-kk');

    Dio.FormData data = Dio.FormData.fromMap({
      'id': dat['id'],
      "name": dat['name'],
      "info": dat['info'],
      "vaccinated": dat['vaccinated'],
    });

    try {
      Dio.Response response = await dio().post('/edit-animal-profile',
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

  Future addLocation(dat) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('i-pet-kk');

    Dio.FormData data = Dio.FormData.fromMap({
      "country": dat['country'],
      "city": dat['city'],
      "longitude": dat['longitude'],
      "latitude": dat['latitude'],
    });

    try {
      print(data.fields);
      print('Bearer $token');
      Dio.Response response = await dio().post('/location',
          data: data,
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $token',
          }));

      return response;
    } catch (e) {
      print(e);
    }
  }

  Future reportUser(data) async {
    try {
      Dio.Response response = await dio().post(
        '/reports',
        data: data,
      );
      return response;
    } catch (e) {
      print(e);
    }
  }
}
