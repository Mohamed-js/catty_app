import 'package:PetsMating/models/businessLayer/baseRoute.dart';
import 'package:PetsMating/screens/myProfileDetailScreen.dart';
import 'package:PetsMating/screens/ownerProfileScreen.dart';
import 'package:PetsMating/screens/reportsScreen.dart';
import 'package:PetsMating/services/app_state.dart';
import 'package:PetsMating/widgets/bottomNavigationBarWidgetLight.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:PetsMating/services/dio.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerMenuWidget extends StatefulWidget {
  final Map user;
  final int chatId;
  const DrawerMenuWidget(this.user, this.chatId);
  @override
  State<DrawerMenuWidget> createState() => _DrawerMenuWidgetState();
}

class _DrawerMenuWidgetState extends State<DrawerMenuWidget> {
  _DrawerMenuWidgetState() : super();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          alignment: Alignment.topRight,
          height: MediaQuery.of(context).size.height * 0.9,
          color: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
            ),
            child: Drawer(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 255, 255, 255),
                      Color.fromARGB(255, 255, 255, 255)
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
                child: ListView(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 0, 55, 138),
                      ),
                      title: Text(
                        'View Profile',
                        style: Theme.of(context).primaryTextTheme.subtitle1,
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                OwnerProfileScreen(widget.user['id'])));
                      },
                    ),
                    // Divider(
                    //   color: Colors.white54,
                    // ),
                    // ListTile(
                    //   leading: Icon(
                    //     MdiIcons.archiveOutline,
                    //     color: Colors.white,
                    //   ),
                    //   title: Text(
                    //     'Archive Conversation',
                    //     style: TextStyle(fontSize: 15, color: Colors.white),
                    //   ),
                    //   onTap: () {},
                    // ),
                    // Divider(
                    //   color: Colors.white54,
                    // ),
                    // ListTile(
                    //   leading: Icon(
                    //     Icons.delete_forever,
                    //     color: Colors.white,
                    //   ),
                    //   title: Text(
                    //     'Delete Chat',
                    //     style: TextStyle(fontSize: 15, color: Colors.white),
                    //   ),
                    //   onTap: () {},
                    // ),
                    // Divider(
                    //   color: Colors.white54,
                    // ),
                    // ListTile(
                    //   leading: Icon(
                    //     Icons.clear,
                    //     color: Colors.white,
                    //   ),
                    //   title: Text(
                    //     'Clear History',
                    //     style: TextStyle(fontSize: 15, color: Colors.white),
                    //   ),
                    //   onTap: () {},
                    // ),
                    // Divider(
                    //   color: Colors.white54,
                    // ),
                    // ListTile(
                    //   leading: Icon(
                    //     Icons.search,
                    //     color: Colors.white,
                    //   ),
                    //   title: Text(
                    //     'Search Chat',
                    //     style: TextStyle(fontSize: 15, color: Colors.white),
                    //   ),
                    //   onTap: () {},
                    // ),
                    // Divider(
                    //   color: Colors.white54,
                    // ),
                    // ListTile(
                    //   leading: Icon(
                    //     MdiIcons.viewArray,
                    //     color: Colors.white,
                    //   ),
                    //   title: Text(
                    //     'View Media',
                    //     style: TextStyle(fontSize: 15, color: Colors.white),
                    //   ),
                    //   onTap: () {},
                    // ),
                    Divider(
                      color: Color.fromARGB(137, 255, 145, 145),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.block,
                        color: Colors.red,
                      ),
                      title: Text(
                        'Block User',
                        style: TextStyle(color: Colors.red),
                      ),
                      onTap: () async {
                        try {
                          final prefs = await SharedPreferences.getInstance();
                          String token = prefs.getString('i-pet-kk');
                          Dio.Response response = await dio()
                              .put('/chat/${widget.chatId}?todo=block',
                                  options: Dio.Options(headers: {
                                    'Authorization': 'Bearer $token',
                                  }));
                          print(response);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BottomNavigationWidgetLight(
                                  currentIndex: 2)));
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                    Divider(
                      color: Color.fromARGB(137, 255, 145, 145),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.report,
                        color: Colors.grey,
                      ),
                      title: Text(
                        'Report User',
                        style: TextStyle(color: Colors.grey),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ReportsScreen(widget.user['id'])));
                      },
                    ),
                    Divider(
                      color: Color.fromARGB(137, 255, 145, 145),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
