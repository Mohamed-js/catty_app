import 'package:PetsMating/screens/blockedUsersScreen.dart';
import 'package:flutter/material.dart';
import 'package:PetsMating/models/businessLayer/global.dart' as g;

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen();

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Privacy Settings",
                style: Theme.of(context).primaryTextTheme.headline1,
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => BlockedUsersScreen()),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.person_off,
                  color: Color(0xFFDD3663),
                ),
                title: Text(
                  'Blocked Contacts',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xFF33196B)),
                ),
              ),
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
            //       color: Color.fromARGB(255, 75, 5, 206),
            //     ),
            //     title: Text(
            //       'Blocked Contacts',
            //       style: TextStyle(
            //           fontWeight: FontWeight.bold,
            //           color: Color.fromARGB(255, 75, 5, 206)),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
