import 'dart:ffi';
import 'dart:io';
import 'package:datingapp/services/auth.dart';
import 'package:datingapp/services/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  Map _user;
  Map get current_user => _user;

  Map _filter_options = {
    'no_vaccination_needed': true,
    'min_age': 0,
    'max_age': 6,
    'same_breed': true,
  };
  Map get filter_options => _filter_options;

  List<dynamic> _recommendations = [];
  List<dynamic> get recommendations => _recommendations;

  List<dynamic> _notificationList = [];
  List<dynamic> get notificationList => _notificationList;

  List<dynamic> _chats = [];
  List<dynamic> get chats => _chats;

  Map<dynamic, dynamic> _subscription = {};
  Map<dynamic, dynamic> get subscription => _subscription;

  Map<dynamic, dynamic> _quota = {};
  Map<dynamic, dynamic> get quota => _quota;

  Future getFilterOptions() async {
    final prefs = await SharedPreferences.getInstance();

    bool no_vaccination_needed = prefs.getBool('i-pet-filter-vaccinated');
    bool same_breed = prefs.getBool('i-pet-filter-same-breed');
    int min_age = prefs.getInt('i-pet-filter-min-age');
    int max_age = prefs.getInt('i-pet-filter-max-age');

    if (same_breed != null) {
      _filter_options['same_breed'] = same_breed;
    }
    if (no_vaccination_needed != null) {
      _filter_options['no_vaccination_needed'] = no_vaccination_needed;
    }
    if (min_age != null) {
      _filter_options['min_age'] = min_age;
    }
    if (max_age != null) {
      _filter_options['max_age'] = max_age;
    }
    notifyListeners();
  }

  getChats() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('i-pet-kk');
    Dio.Response response = await dio().get('/chats',
        options: Dio.Options(headers: {
          'Authorization': 'Bearer $token',
        }));
    _chats = response.data;
    notifyListeners();
  }

  getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('i-pet-kk');
    Dio.Response response = await dio().get('/notifications',
        options: Dio.Options(headers: {
          'Authorization': 'Bearer $token',
        }));
    _notificationList = response.data;
    notifyListeners();
  }

  getSubscription() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('i-pet-kk');
    Dio.Response response = await dio().get('/subscription',
        options: Dio.Options(headers: {
          'Authorization': 'Bearer $token',
        }));
    _subscription = response.data[0];
    print(response.data[0]);
    notifyListeners();
  }

  getQuota() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('i-pet-kk');
    Dio.Response response = await dio().get('/quota',
        options: Dio.Options(headers: {
          'Authorization': 'Bearer $token',
        }));
    _quota = response.data[0];
    print(response.data[0]);
    notifyListeners();
  }
}
