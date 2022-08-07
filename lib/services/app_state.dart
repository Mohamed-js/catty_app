// import 'dart:ffi';
import 'dart:io';
import 'package:PetsMating/services/auth.dart';
import 'package:PetsMating/services/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  Map _user;
  Map get current_user => _user;

  int _animalId;
  int get current_animal_id => _animalId;

  Map _filter_options = {
    'no_vaccination_needed': true,
    'min_age': 0,
    'max_age': 20,
    'same_breed': false,
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

  changeFilters(
    noVaccinationNeeded,
    sameBreed,
    minAge,
    maxAge,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    _filter_options = {
      'no_vaccination_needed': noVaccinationNeeded,
      'min_age': minAge,
      'max_age': maxAge,
      'same_breed': sameBreed,
    };

    print(noVaccinationNeeded.runtimeType);

    prefs.setBool('i-pet-filter-vaccinated', noVaccinationNeeded);
    prefs.setBool('i-pet-filter-same-breed', sameBreed);
    prefs.setDouble('i-pet-filter-min-age', minAge);
    prefs.setDouble('i-pet-filter-max-age', maxAge);
    notifyListeners();
  }

  Future getFilterOptions() async {
    final prefs = await SharedPreferences.getInstance();
    bool no_vaccination_needed = prefs.getBool('i-pet-filter-vaccinated');
    bool same_breed = prefs.getBool('i-pet-filter-same-breed');
    double min_age = prefs.getDouble('i-pet-filter-min-age');
    double max_age = prefs.getDouble('i-pet-filter-max-age');

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
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('i-pet-kk');
      Dio.Response response = await dio().get('/chats',
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      _chats = response.data;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  readChat(chatId) async {
    _chats[chatId]['unread_messages_count'] = 0;
    notifyListeners();
  }

  getNotifications() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('i-pet-kk');
      Dio.Response response = await dio().get('/notifications',
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      _notificationList = response.data;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  getSubscription() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('i-pet-kk');
      Dio.Response response = await dio().get('/subscription',
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      _subscription = response.data[0];

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  getQuota() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('i-pet-kk');
      Dio.Response response = await dio().get('/quota',
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      _quota = response.data[0];

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void setCurrentAnimal(user, idToChange) async {
    final prefs = await SharedPreferences.getInstance();
    if (idToChange != null) {
      print(idToChange);
      _animalId = idToChange;
      prefs.setInt('i-pet-current-animal-id', idToChange);
    } else {
      int id = prefs.getInt('i-pet-current-animal-id');

      if (id != null && user['animals'].isNotEmpty) {
        bool exists = false;
        for (var animal in user['animals']) {
          if (animal['id'] == id) {
            exists = true;
          }
        }
        if (exists) {
          _animalId = id;
        } else {
          prefs.setInt('i-pet-current-animal-id', user['animals'][0]['id']);
          _animalId = user['animals'][0]['id'];
        }
      }
    }
    notifyListeners();
  }

  void reduceLikesQuota() {
    _quota['likes'] = int.parse(_quota['likes']) - 1;

    notifyListeners();
  }

  void insertComingMessage(data, meInserting) {
    var now = new DateTime.now();
    print(new DateFormat("yyyy-MM-dd Hms").format(now));
    final chat = _chats.where((chat) {
      return chat['id'] == data['chat_id'];
    }).toList()[0];

    chat['last_message'] = {
      'sender_id': data['sender_id'],
      'body': data['body'],
      'seen': meInserting ? true : false,
      'chat_id': data['chat_id'],
      'created_at': new DateFormat("yyyy-MM-dd hh:mm").format(now)
    };

    chat['messages'].insert(0, {
      'sender_id': data['sender_id'],
      'body': data['body'],
      'seen': meInserting ? true : false,
      'chat_id': data['chat_id'],
      'created_at': new DateFormat("yyyy-MM-dd hh:mm").format(now)
    });

    chat['unread_messages_count']++;

    _chats = _chats.where((chat) {
      return chat['id'] != data['chat_id'];
    }).toList();

    _chats.insert(0, chat);

    notifyListeners();
  }

  setCurrenAnimalId(id) {
    _animalId = id;

    notifyListeners();
  }
}
