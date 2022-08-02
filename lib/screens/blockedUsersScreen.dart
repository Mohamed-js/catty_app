import 'package:PetsMating/services/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:PetsMating/models/businessLayer/global.dart' as g;
import 'package:shared_preferences/shared_preferences.dart';

class BlockedUsersScreen extends StatefulWidget {
  const BlockedUsersScreen();

  @override
  State<BlockedUsersScreen> createState() => _BlockedUsersScreenState();
}

class _BlockedUsersScreenState extends State<BlockedUsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
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
            ListTile(
              leading: Icon(
                Icons.person,
                color: Color(0xFFDD3663),
              ),
              title: Text(
                'Mohammed Atef',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xFF33196B)),
              ),
              trailing: InkWell(
                  onTap: () => null,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Unblock'),
                  )),
            ),

            // Container(
            //   height: 0.5,
            //   decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //       begin: Alignment.topLeft,
            //       end: Alignment.bottomRight,
            //       colors: [
            //         Color.fromARGB(255, 61, 2, 172),
            //         Color.fromARGB(190, 75, 5, 206)
            //       ],
            //     ),
            //   ),
            //   child: Divider(),
            // ),
            // InkWell(
            //   onTap: () => null,
            //   child: ListTile(
            //     leading: Icon(
            //       Icons.block,
            //       color: Color(0xFF33196B),
            //     ),
            //     title: Text(
            //       'Blocked Contacts',
            //       style: TextStyle(
            //           fontWeight: FontWeight.bold,
            //           color: Color(0xFF33196B)),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    void getBlockedUsers() async {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('i-pet-kk');
      dio().get('/blocked-users',
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data'
          }));
      super.initState();
    }
  }
}
