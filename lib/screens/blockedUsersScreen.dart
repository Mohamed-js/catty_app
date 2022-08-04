import 'package:PetsMating/services/dio.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:PetsMating/services/dio.dart';
import 'package:flutter/material.dart';
import 'package:PetsMating/models/businessLayer/global.dart' as g;
import 'package:shared_preferences/shared_preferences.dart';

class BlockedUsersScreen extends StatefulWidget {
  const BlockedUsersScreen();

  @override
  State<BlockedUsersScreen> createState() => _BlockedUsersScreenState();
}

class _BlockedUsersScreenState extends State<BlockedUsersScreen> {
  Map<String, dynamic> _blocks = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    'Blocks List',
                    style: Theme.of(context).primaryTextTheme.headline1,
                  ),
                ),
              ),
              _blocks.isNotEmpty && _blocks['users'].isNotEmpty
                  ? Expanded(
                      child: ListView(
                          children: List.generate(
                              _blocks['users'].length,
                              (i) => ListTile(
                                    leading: Icon(
                                      Icons.person,
                                      color: Color(0xFFDD3663),
                                    ),
                                    title: Text(
                                      "${_blocks['users'][i]['first_name']} ${_blocks['users'][i]['last_name']}"
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF33196B)),
                                    ),
                                    trailing: InkWell(
                                        onTap: () async {
                                          try {
                                            final prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            String token =
                                                prefs.getString('i-pet-kk');
                                            Dio.Response response = await dio().put(
                                                '/chat/${_blocks['chats_ids'][i]}?todo=unblock',
                                                options: Dio.Options(headers: {
                                                  'Authorization':
                                                      'Bearer $token',
                                                }));
                                            getBlockedUsers();
                                          } catch (e) {
                                            print(e);
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('Unblock'),
                                        )),
                                  ))),
                    )
                  : Text(
                      '...',
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void getBlockedUsers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('i-pet-kk');
      Dio.Response response = await dio().get('/blocked-users',
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      setState(() {
        _blocks = response.data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getBlockedUsers();
    super.initState();
  }
}
