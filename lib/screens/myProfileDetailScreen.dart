import 'package:PetsMating/models/businessLayer/baseRoute.dart';
import 'package:PetsMating/models/businessLayer/global.dart' as g;
import 'package:PetsMating/screens/editProfileScreen.dart';
import 'package:PetsMating/screens/myAnimalProfileScreen.dart';
import 'package:PetsMating/screens/newAnimalScreen.dart';
import 'package:PetsMating/screens/settingScreen.dart';
import 'package:PetsMating/services/app_state.dart';
import 'package:PetsMating/services/auth.dart';
import 'package:PetsMating/widgets/bottomNavigationBarWidgetLight.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:PetsMating/services/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfileScreen extends BaseRoute {
  MyProfileScreen({a, o}) : super(a: a, o: o, r: 'MyProfileScreen');
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends BaseRouteState {
  int _currentIndex = 0;
  TabController _tabController;

  _MyProfileScreenState() : super();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final appState = Provider.of<AppState>(context, listen: false);

    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          return Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomNavigationWidgetLight(
                        currentIndex: 0,
                      )),
              ModalRoute.withName('/'));
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: g.scaffoldBackgroundGradientColors,
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Scaffold(
            appBar: _appBarWidget(),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: auth.current_user['avatar'] == null || appState.quota == null
                ? LoadingIndicator(
                    indicatorType: Indicator.ballPulse,

                    /// Required, The loading type of the widget
                    colors: const [Colors.white],

                    /// Optional, The color collections
                    strokeWidth: 2,

                    /// Optional, The stroke of the line, only applicable to widget which contains line
                    backgroundColor: Colors.transparent,

                    /// Optional, Background of the widget
                    pathBackgroundColor: Colors.black

                    /// Optional, the stroke backgroundColor
                    )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(alignment: Alignment.center, children: [
                            Container(
                              height: MediaQuery.of(context).size.width * .75,
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                child: Image.network(
                                  "${auth.current_user['avatar']}",
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                ),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(19, 1, 51, 1),
                                ),
                              ),
                            ),
                          ]),
                          // Container(
                          //   color: g.isDarkModeEnable ? Color(0xFF130032) : Colors.white,
                          //   height: MediaQuery.of(context).size.height * 0.30,
                          //   width: MediaQuery.of(context).size.width * 0.25,
                          //   child: Column(
                          //     children: [
                          //       Expanded(
                          //         child: Row(
                          //           mainAxisSize: MainAxisSize.min,
                          //           children: [
                          //             Icon(
                          //               Icons.favorite_border,
                          //               color: g.isDarkModeEnable ? Theme.of(context).iconTheme.color : Theme.of(context).primaryColorLight,
                          //               size: 18,
                          //             ),
                          //             Padding(
                          //               padding: const EdgeInsets.only(left: 4),
                          //               child: Text(
                          //                 '2.7k',
                          //                 style: Theme.of(context).primaryTextTheme.bodyText1,
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //       Divider(
                          //         color: g.isDarkModeEnable ? Color(0xFF230f4E) : Colors.purple[100],
                          //       ),
                          //       Expanded(
                          //         child: Row(
                          //           mainAxisSize: MainAxisSize.min,
                          //           children: [
                          //             Icon(
                          //               Icons.thumb_up,
                          //               color: g.isDarkModeEnable ? Theme.of(context).iconTheme.color : Theme.of(context).primaryColorLight,
                          //               size: 18,
                          //             ),
                          //             Padding(
                          //               padding: const EdgeInsets.only(left: 4),
                          //               child: Text(
                          //                 '3.5k',
                          //                 style: Theme.of(context).primaryTextTheme.bodyText1,
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //       Divider(
                          //         color: g.isDarkModeEnable ? Color(0xFF230f4E) : Colors.purple[100],
                          //       ),
                          //       Expanded(
                          //         child: Row(
                          //           mainAxisSize: MainAxisSize.min,
                          //           children: [
                          //             Icon(
                          //               Icons.comment_outlined,
                          //               color: g.isDarkModeEnable ? Theme.of(context).iconTheme.color : Theme.of(context).primaryColorLight,
                          //               size: 18,
                          //             ),
                          //             Padding(
                          //               padding: const EdgeInsets.only(left: 4),
                          //               child: Text(
                          //                 '2.3k',
                          //                 style: Theme.of(context).primaryTextTheme.bodyText1,
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //       Divider(
                          //         color: g.isDarkModeEnable ? Color(0xFF230f4E) : Colors.purple[100],
                          //       ),
                          //       Container(
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(22),
                          //           gradient: LinearGradient(
                          //             colors: [Colors.blue[900], Colors.blueAccent[700]],
                          //             begin: Alignment.topLeft,
                          //             end: Alignment.bottomRight,
                          //           ),
                          //         ),
                          //         child: CircleAvatar(
                          //           backgroundColor: Colors.transparent,
                          //           radius: 20,
                          //           child: Icon(
                          //             Icons.border_color_outlined,
                          //             size: 18,
                          //             color: Colors.white,
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                      // Stack(
                      //   children: [
                      //     Container(
                      //       padding: EdgeInsets.only(right: 8),
                      //       alignment: Alignment.centerRight,
                      //       width: MediaQuery.of(context).size.width,
                      //       color: g.isDarkModeEnable ? Color(0xFF130032) : Theme.of(context).scaffoldBackgroundColor,
                      //       height: 15,
                      //     ),
                      //     Container(
                      //       padding: EdgeInsets.only(left: 8),
                      //       alignment: Alignment.centerLeft,
                      //       color: Color(0xFFAD45B3),
                      //       width: MediaQuery.of(context).size.width / 2 - 35,
                      //       height: 15,
                      //     ),
                      //   ],
                      // ),

                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: Icon(
                                    Icons.thumb_up,
                                    color: Colors.white,
                                  ),
                                  radius: 25,
                                ),
                                SizedBox(height: 3),
                                Text(
                                  appState.quota['likes'] == null
                                      ? '-'
                                      : "${appState.quota['likes']}",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle2,
                                )
                              ],
                            ),
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 255, 123, 0),
                                  child: Icon(
                                    Icons.flash_on,
                                    color: Colors.white,
                                  ),
                                  radius: 25,
                                ),
                                SizedBox(height: 3),
                                Text(
                                  appState.quota['boosts'] == null
                                      ? '-'
                                      : "${appState.quota['boosts']}",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle2,
                                )
                              ],
                            ),
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 109, 109, 109),
                                  child: Icon(
                                    Icons.undo,
                                    color: Colors.white,
                                  ),
                                  radius: 25,
                                ),
                                SizedBox(height: 3),
                                Text(
                                  appState.quota['undos'] == null
                                      ? '-'
                                      : "${appState.quota['undos']}",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle2,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),

                      Divider(
                        color: Colors.deepPurple[100],
                        height: 15,
                      ),

                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, top: 15),
                                      child: Text(
                                        auth.current_user['first_name']
                                                .toUpperCase() +
                                            " " +
                                            auth.current_user['last_name']
                                                .toUpperCase(),
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .subtitle1,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: g.isRTL
                                        ? const EdgeInsets.only(right: 5)
                                        : const EdgeInsets.only(left: 5),
                                    child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                            textStyle:
                                                const TextStyle(fontSize: 12),
                                            backgroundColor: Color.fromARGB(
                                                255, 36, 2, 100)),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditProfileDetailScreen(
                                                        a: widget.analytics,
                                                        o: widget.observer,
                                                      )));
                                        },
                                        child: Icon(Icons.edit,
                                            color: Colors.white, size: 12),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: g.isRTL
                                    ? const EdgeInsets.only(right: 20)
                                    : const EdgeInsets.only(left: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Container(
                                    //   height: 30,
                                    //   child: Row(
                                    //     children: [
                                    //       Icon(
                                    //         Icons.call,
                                    //         color: Theme.of(context).iconTheme.color,
                                    //         size: 16,
                                    //       ),
                                    //       Padding(
                                    //         padding: const EdgeInsets.only(left: 4),
                                    //         child: Text(
                                    //           '+01 234 567 8910',
                                    //           style: Theme.of(context).primaryTextTheme.bodyText1,
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    Container(
                                      height: 30,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.mail,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color,
                                            size: 16,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 4),
                                            child: Text(
                                              auth.current_user['email'],
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .bodyText1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Padding(
                              //   padding: g.isRTL
                              //       ? const EdgeInsets.only(right: 20, top: 20)
                              //       : const EdgeInsets.only(left: 20, top: 20),
                              //   child: Text(
                              //     AppLocalizations.of(context).lbl_short_bio,
                              //     style: Theme.of(context)
                              //         .primaryTextTheme
                              //         .headline3,
                              //   ),
                              // ),
                              // Padding(
                              //   padding: g.isRTL
                              //       ? const EdgeInsets.only(right: 20, top: 5)
                              //       : const EdgeInsets.only(left: 20, top: 5),
                              //   child: Text(
                              //     '-',
                              //     style: Theme.of(context)
                              //         .primaryTextTheme
                              //         .subtitle2,
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.only(top: 20),
                              //   child: TabBar(
                              //     controller: _tabController,
                              //     indicatorColor: Theme.of(context).iconTheme.color,
                              //     onTap: (int index) async {
                              //       _currentIndex = index;
                              //       setState(() {});
                              //     },
                              //     tabs: [
                              //       _tabController.index == 0
                              //           ? Tab(
                              //               child: ShaderMask(
                              //                 blendMode: BlendMode.srcIn,
                              //                 shaderCallback: (Rect bounds) {
                              //                   return LinearGradient(
                              //                     colors: g.gradientColors,
                              //                     begin: Alignment.centerLeft,
                              //                     end: Alignment.centerRight,
                              //                   ).createShader(bounds);
                              //                 },
                              //                 child: Text(
                              //                   AppLocalizations.of(context).lbl_tab_pictures,
                              //                   style: TextStyle(fontSize: 16),
                              //                 ),
                              //               ),
                              //             )
                              //           : Text(
                              //               AppLocalizations.of(context).lbl_tab_pictures,
                              //               style: TextStyle(fontSize: 16),
                              //             ),
                              //       _tabController.index == 1
                              //           ? Tab(
                              //               child: ShaderMask(
                              //                 blendMode: BlendMode.srcIn,
                              //                 shaderCallback: (Rect bounds) {
                              //                   return LinearGradient(
                              //                     colors: g.gradientColors,
                              //                     begin: Alignment.centerLeft,
                              //                     end: Alignment.centerRight,
                              //                   ).createShader(bounds);
                              //                 },
                              //                 child: Text(
                              //                   AppLocalizations.of(context).lbl_tab_videos,
                              //                   style: TextStyle(fontSize: 16),
                              //                 ),
                              //               ),
                              //             )
                              //           : Text(
                              //               AppLocalizations.of(context).lbl_tab_videos,
                              //               style: TextStyle(fontSize: 16),
                              //             ),
                              //       _tabController.index == 2
                              //           ? Tab(
                              //               child: ShaderMask(
                              //                 blendMode: BlendMode.srcIn,
                              //                 shaderCallback: (Rect bounds) {
                              //                   return LinearGradient(
                              //                     colors: g.gradientColors,
                              //                     begin: Alignment.centerLeft,
                              //                     end: Alignment.centerRight,
                              //                   ).createShader(bounds);
                              //                 },
                              //                 child: Text(
                              //                   AppLocalizations.of(context).lbl_tab_mybio,
                              //                   style: TextStyle(fontSize: 16),
                              //                 ),
                              //               ),
                              //             )
                              //           : Text(
                              //               AppLocalizations.of(context).lbl_tab_mybio,
                              //               style: TextStyle(fontSize: 16),
                              //             ),
                              //       _tabController.index == 3
                              //           ? Tab(
                              //               child: ShaderMask(
                              //                 blendMode: BlendMode.srcIn,
                              //                 shaderCallback: (Rect bounds) {
                              //                   return LinearGradient(
                              //                     colors: g.gradientColors,
                              //                     begin: Alignment.centerLeft,
                              //                     end: Alignment.centerRight,
                              //                   ).createShader(bounds);
                              //                 },
                              //                 child: Text(
                              //                   AppLocalizations.of(context).lbl_tab_more,
                              //                   style: TextStyle(fontSize: 16),
                              //                 ),
                              //               ),
                              //             )
                              //           : Text(
                              //               AppLocalizations.of(context).lbl_tab_more,
                              //               style: TextStyle(fontSize: 16),
                              //             ),
                              //     ],
                              //   ),
                              // ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: g.isRTL
                                        ? const EdgeInsets.only(right: 20)
                                        : const EdgeInsets.only(left: 20),
                                    child: Text(
                                      "Pets",
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline3,
                                    ),
                                  ),
                                  auth.current_user['animals'].length < 3 &&
                                          auth.current_user['animals']
                                              .isNotEmpty
                                      ? Container(
                                          padding: g.isRTL
                                              ? const EdgeInsets.only(right: 5)
                                              : const EdgeInsets.only(left: 5),
                                          width: 35,
                                          height: 30,
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                                textStyle: const TextStyle(
                                                    fontSize: 12),
                                                backgroundColor: Color.fromARGB(
                                                    255, 36, 2, 100)),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          NewAnimalScreen(
                                                            a: widget.analytics,
                                                            o: widget.observer,
                                                          )));
                                            },
                                            child: const Text('+',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        )
                                      : SizedBox(height: 0, width: 0),
                                ],
                              ),
                              auth.current_user['animals'].isEmpty
                                  ? Padding(
                                      padding: g.isRTL
                                          ? const EdgeInsets.only(right: 20)
                                          : const EdgeInsets.only(left: 20),
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                            textStyle:
                                                const TextStyle(fontSize: 12),
                                            backgroundColor: Color.fromARGB(
                                                255, 36, 2, 100)),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NewAnimalScreen(
                                                        a: widget.analytics,
                                                        o: widget.observer,
                                                      )));
                                        },
                                        child: const Text('Add +',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    )
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 5.0),
                                      child: Container(
                                        height: (MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.12),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: TabBarView(
                                          controller: _tabController,
                                          children: [
                                            GridView.builder(
                                              scrollDirection: Axis.horizontal,
                                              gridDelegate:
                                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                mainAxisSpacing: 2.0,
                                                crossAxisSpacing: 2.0,
                                              ),
                                              itemCount: auth
                                                  .current_user['animals']
                                                  .length,
                                              itemBuilder: (ctx, index) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  23)),
                                                      border: Border.all(
                                                          width: 5,
                                                          color: auth.current_user['animals']
                                                                          [index]
                                                                      ['id'] ==
                                                                  appState
                                                                      .current_animal_id
                                                              ? Color.fromARGB(
                                                                  213,
                                                                  61,
                                                                  2,
                                                                  109)
                                                              : Color(
                                                                  0xFFEEFCFF))),
                                                  child: PopupMenuButton(
                                                    itemBuilder: (context) => [
                                                      PopupMenuItem(
                                                        child: TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .push(MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        MyAnimalProfileScreen(auth.current_user['animals'][index]
                                                                            [
                                                                            'id'])));
                                                          },
                                                          child: Text(
                                                            "View animal",
                                                            style: Theme.of(
                                                                    context)
                                                                .primaryTextTheme
                                                                .subtitle2,
                                                          ),
                                                        ),
                                                        onTap: () => {},
                                                      ),
                                                      PopupMenuItem(
                                                        child: TextButton(
                                                          onPressed: () {
                                                            appState.setCurrentAnimal(
                                                                auth
                                                                    .current_user,
                                                                auth.current_user[
                                                                        'animals']
                                                                    [
                                                                    index]['id']);
                                                            Navigator.of(
                                                                    context)
                                                                .push(MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        BottomNavigationWidgetLight(
                                                                            currentIndex:
                                                                                0)));
                                                          },
                                                          child: Text(
                                                            "Set as active animal",
                                                            style: Theme.of(
                                                                    context)
                                                                .primaryTextTheme
                                                                .subtitle2,
                                                          ),
                                                        ),
                                                        onTap: () {},
                                                      ),
                                                      PopupMenuItem(
                                                        child: TextButton(
                                                          onPressed: () =>
                                                              showDeleteDialog(auth
                                                                          .current_user[
                                                                      'animals']
                                                                  [
                                                                  index]['id']),
                                                          child: Text(
                                                            "Delete animal",
                                                            style: Theme.of(
                                                                    context)
                                                                .primaryTextTheme
                                                                .subtitle2,
                                                          ),
                                                        ),
                                                        onTap: () {},
                                                      )
                                                    ],
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        border: Border.all(
                                                            color:
                                                                Colors.white),
                                                        color:
                                                            g.isDarkModeEnable
                                                                ? Color(
                                                                    0xFF1D0529)
                                                                : Colors
                                                                    .white54,
                                                      ),
                                                      child: GridTile(
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          child: auth
                                                                      .current_user[
                                                                          'animals']
                                                                          [
                                                                          index]
                                                                          [
                                                                          'avatars']
                                                                      .length >
                                                                  0
                                                              ? Image.network(
                                                                  '${auth.current_user['animals'][index]['avatars'][0]['url']}',
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  height: 100,
                                                                )
                                                              : Image.asset(
                                                                  'assets/images/animal.jpg',
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                            Container(),
                                            Container(),
                                            Container()
                                          ],
                                        ),
                                      ),
                                    ),

                              // Padding(
                              //     padding: const EdgeInsets.only(bottom: 20),
                              //     child: Row(
                              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //       children: [
                              //         Expanded(
                              //           child: Padding(
                              //             padding: g.isRTL ? EdgeInsets.only(right: 20, top: 20) : EdgeInsets.only(left: 20, top: 20),
                              //             child: Row(
                              //               mainAxisSize: MainAxisSize.min,
                              //               children: [
                              //                 Icon(
                              //                   MdiIcons.music,
                              //                   color: Color(0xFFB783EB),
                              //                   size: 20,
                              //                 ),
                              //                 Padding(
                              //                   padding: const EdgeInsets.only(left: 4),
                              //                   child: Text(
                              //                     'Music',
                              //                     style: Theme.of(context).accentTextTheme.subtitle2,
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //         ),
                              //         Expanded(
                              //           child: Padding(
                              //             padding: EdgeInsets.only(top: 20),
                              //             child: Row(
                              //               mainAxisSize: MainAxisSize.min,
                              //               children: [
                              //                 Icon(
                              //                   MdiIcons.cookie,
                              //                   color: Color(0xFFB783EB),
                              //                   size: 20,
                              //                 ),
                              //                 Padding(
                              //                   padding: const EdgeInsets.only(left: 4),
                              //                   child: Text(
                              //                     'Cooking',
                              //                     style: Theme.of(context).accentTextTheme.subtitle2,
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //         ),
                              //         Expanded(
                              //           child: Padding(
                              //             padding: EdgeInsets.only(top: 20),
                              //             child: Row(
                              //               mainAxisSize: MainAxisSize.min,
                              //               children: [
                              //                 Icon(
                              //                   MdiIcons.swim,
                              //                   color: Color(0xFFB783EB),
                              //                   size: 20,
                              //                 ),
                              //                 Padding(
                              //                   padding: const EdgeInsets.only(left: 4),
                              //                   child: Text(
                              //                     'Swimming',
                              //                     style: Theme.of(context).accentTextTheme.subtitle2,
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //         ),
                              //         Expanded(
                              //           child: Padding(
                              //             padding: EdgeInsets.only(top: 20),
                              //             child: Row(
                              //               mainAxisSize: MainAxisSize.min,
                              //               children: [
                              //                 Icon(
                              //                   Icons.travel_explore,
                              //                   color: Color(0xFFB783EB),
                              //                   size: 20,
                              //                 ),
                              //                 Padding(
                              //                   padding: const EdgeInsets.only(left: 4),
                              //                   child: Text(
                              //                     'Travelling',
                              //                     style: Theme.of(context).accentTextTheme.subtitle2,
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //         ),
                              //       ],
                              //     ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Allow Notifications'),
                  content:
                      Text('PetsMating would like to send you notifications..'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Don't allow",
                          style: Theme.of(context).primaryTextTheme.subtitle2,
                        )),
                    TextButton(
                        onPressed: () {
                          AwesomeNotifications()
                              .requestPermissionToSendNotifications()
                              .then((_) => Navigator.pop(context));
                        },
                        child: Text(
                          "Allow",
                          style: Theme.of(context).primaryTextTheme.subtitle1,
                        ))
                  ],
                ));
      }
    });

    final auth = Provider.of<Auth>(context, listen: false);

    _tabController =
        new TabController(length: 4, vsync: this, initialIndex: _currentIndex);
    _tabController.addListener(_tabControllerListener);
    final appState = Provider.of<AppState>(context, listen: false);
    appState.getSubscription();
    appState.getQuota();
    auth.tryLogin(true);
  }

  void _tabControllerListener() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  showDeleteDialog(animal_id) {
    final auth = Provider.of<Auth>(context, listen: false);
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Delete Your Animal?',
                  style: Theme.of(context).primaryTextTheme.subtitle1),
              content: Text(
                'Are you sure you want to delete this animal?',
                style: Theme.of(context).primaryTextTheme.subtitle2,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "No",
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                    )),
                TextButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      String token = prefs.getString('i-pet-kk');
                      await dio().delete('/animal/$animal_id',
                          options: Dio.Options(headers: {
                            'Authorization': 'Bearer $token',
                          }));
                      await auth.tryLogin(true);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BottomNavigationWidgetLight(
                                currentIndex: 3,
                              )));
                    },
                    child: Text(
                      "Yes",
                      style: Theme.of(context).primaryTextTheme.subtitle1,
                    ))
              ],
            ));
  }

  PreferredSizeWidget _appBarWidget() {
    return PreferredSize(
      preferredSize: Size.fromHeight(65),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(right: 8),
            alignment: g.isRTL ? Alignment.centerLeft : Alignment.centerRight,
            width: MediaQuery.of(context).size.width,
            color: g.isDarkModeEnable
                ? Color(0xFF130032)
                : Theme.of(context).scaffoldBackgroundColor,
            height: 65,
            child: IconButton(
              icon: Icon(Icons.settings_outlined),
              color: Theme.of(context).iconTheme.color,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SettingScreen(
                          a: widget.analytics,
                          o: widget.observer,
                        )));
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 8),
            alignment: g.isRTL ? Alignment.centerRight : Alignment.centerLeft,
            color: Color(0xFFDC3664),
            width: 70,
            height: 65,
            child: IconButton(
              icon: Icon(FontAwesomeIcons.longArrowAltLeft),
              color: Colors.white,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BottomNavigationWidgetLight(
                              currentIndex: 0,
                            )),
                    ModalRoute.withName('/'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
