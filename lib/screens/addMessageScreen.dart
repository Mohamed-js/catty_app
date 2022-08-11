import 'package:PetsMating/models/addNewMessageModel.dart';
import 'package:PetsMating/models/businessLayer/baseRoute.dart';
import 'package:PetsMating/models/businessLayer/global.dart' as g;
import 'package:PetsMating/screens/chatScreen.dart';
import 'package:PetsMating/screens/createStoryScreen.dart';
import 'package:PetsMating/screens/myProfileDetailScreen.dart';
import 'package:PetsMating/screens/splashScreen.dart';
import 'package:PetsMating/screens/startConversionScreen.dart';
import 'package:PetsMating/screens/viewStoryScreen.dart';
import 'package:PetsMating/services/app_state.dart';
import 'package:PetsMating/services/auth.dart';
import 'package:PetsMating/widgets/bottomNavigationBarWidgetLight.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:PetsMating/services/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class AddMessageScreen extends BaseRoute {
  AddMessageScreen({a, o}) : super(a: a, o: o, r: 'AddMessageScreen');
  @override
  _AddMessageScreenState createState() => _AddMessageScreenState();
}

class _AddMessageScreenState extends BaseRouteState {
  bool loading = false;
  TextEditingController _filter = new TextEditingController();

  List<dynamic> _chatsToShow = [];
  _AddMessageScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, appState, child) {
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
              child: Consumer<Auth>(builder: (context, auth, child) {
                return Scaffold(
                  appBar: _appBarWidget(),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  body: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            padding: EdgeInsets.all(2),
                            height: 55,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: g.gradientColors,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: g.isDarkModeEnable
                                    ? Colors.black
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(35),
                              ),
                              height: 55,
                              child: TextFormField(
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .subtitle2,
                                controller: _filter,
                                cursorColor: Color.fromARGB(255, 10, 10, 10),
                                decoration: InputDecoration(
                                  contentPadding: g.isRTL
                                      ? EdgeInsets.only(right: 22, top: 15)
                                      : EdgeInsets.only(left: 22, top: 15),
                                  hintText: 'Search',
                                  hintStyle: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle2,
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: IconButton(
                                      icon: Icon(FontAwesomeIcons.search),
                                      color: Theme.of(context).iconTheme.color,
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Align(
                          //   alignment: Alignment.centerLeft,
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(top: 20),
                          //     child: Text(
                          //       AppLocalizations.of(context).lbl_Add_your_Story,
                          //       style: Theme.of(context).primaryTextTheme.subtitle1,
                          //     ),
                          //   ),
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.only(top: 5),
                          //   child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Padding(
                          //         padding: g.isRTL ? const EdgeInsets.only(right: 15) : EdgeInsets.only(left: 10),
                          //         child: Image.asset(
                          //           g.isDarkModeEnable ? 'assets/images/swirl arrow.png' : 'assets/images/swirl arrow_light.png',
                          //         ),
                          //       ),
                          //       Padding(
                          //         padding: EdgeInsets.only(top: 4),
                          //         child: SizedBox(
                          //           width: MediaQuery.of(context).size.width,
                          //           height: 50,
                          //           child: ListView.builder(
                          //             scrollDirection: Axis.horizontal,
                          //             itemCount: circleImageList.length,
                          //             itemBuilder: (ctx, index) {
                          //               return InkWell(
                          //                 onTap: () {
                          //                   index == 0
                          //                       ? Navigator.of(context).push(MaterialPageRoute(
                          //                           builder: (context) => CreateStoryScreen(
                          //                                 a: widget.analytics,
                          //                                 o: widget.observer,
                          //                               )))
                          //                       : Navigator.of(context).push(MaterialPageRoute(
                          //                           builder: (context) => ViewStoryScreen(
                          //                                 a: widget.analytics,
                          //                                 o: widget.observer,
                          //                               )));
                          //                 },
                          //                 child: Padding(
                          //                   padding: g.isRTL ? const EdgeInsets.only(left: 10) : const EdgeInsets.only(right: 10),
                          //                   child: index == 0
                          //                       ? CircleAvatar(
                          //                           radius: 25,
                          //                           backgroundColor: Color(0xFFF1405B),
                          //                           child: Icon(
                          //                             Icons.add,
                          //                             color: Colors.white,
                          //                           ),
                          //                         )
                          //                       : CircleAvatar(
                          //                           radius: 26,
                          //                           backgroundColor: Colors.white,
                          //                           child: CircleAvatar(
                          //                             radius: 25,
                          //                             backgroundColor: Color(0xFFF1405B),
                          //                             backgroundImage: AssetImage(
                          //                               circleImageList[index],
                          //                             ),
                          //                           ),
                          //                         ),
                          //                 ),
                          //               );
                          //             },
                          //           ),
                          //         ),
                          //       ),
                          //       ]
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              AppLocalizations.of(context).lbl_All_Messages,
                              style:
                                  Theme.of(context).primaryTextTheme.headline3,
                            ),
                          ),
                          loading
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Center(
                                      child: Text('loading...',
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .bodyText1)),
                                )
                              : appState.chats.isEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: Center(
                                          child: Text('No current messages...',
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .bodyText1)),
                                    )
                                  : _filter.text.isEmpty
                                      ? Expanded(
                                          child: ListView.builder(
                                              itemCount: appState.chats.length,
                                              itemBuilder: (ctx, index) {
                                                dynamic _user =
                                                    auth.current_user['id'].toString() !=
                                                            appState.chats[
                                                                    index]
                                                                ['sender_id'].toString()
                                                        ? appState.chats[index]
                                                            ['sender']
                                                        : appState.chats[index]
                                                            ['receiver'];
                                                return Container(
                                                  alignment: Alignment.center,
                                                  margin:
                                                      EdgeInsets.only(top: 15),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: g.isDarkModeEnable
                                                        ? Color(0xFF1D0529)
                                                        : Colors.white54,
                                                  ),
                                                  height: 90,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: ListTile(
                                                    title: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  1.5),
                                                          margin: g.isRTL
                                                              ? EdgeInsets.only(
                                                                  left: 10)
                                                              : EdgeInsets.only(
                                                                  right: 10),
                                                          height: 60,
                                                          width: 60,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            color: Colors.white,
                                                          ),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          11),
                                                              color:
                                                                  Colors.purple,
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                              child:
                                                                  Image.network(
                                                                "${_user['avatar']}",
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            10),
                                                                    child: Text(
                                                                      '${_user['first_name'][0].toUpperCase()}${_user['first_name'].substring(1)} ${_user['last_name'][0].toUpperCase()}${_user['last_name'].substring(1)}',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .primaryTextTheme
                                                                          .subtitle2,
                                                                    ),
                                                                  ),
                                                                  // Padding(
                                                                  //   padding:
                                                                  //       const EdgeInsets
                                                                  //               .only(
                                                                  //           left: 4,
                                                                  //           bottom:
                                                                  //               10),
                                                                  //   child:
                                                                  //       CircleAvatar(
                                                                  //     radius: 4,
                                                                  //     backgroundColor:
                                                                  //         Colors.lightGreenAccent[
                                                                  //             400],
                                                                  //   ),
                                                                  // )
                                                                ],
                                                              ),
                                                              appState.chats[index]
                                                                          [
                                                                          'last_message'] ==
                                                                      null
                                                                  ? Text("-")
                                                                  : Text(
                                                                      '${appState.chats[index]['last_message']['body']}',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .primaryTextTheme
                                                                          .bodyText2,
                                                                    )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    trailing: Container(
                                                      height: 60,
                                                      width: 53,
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Expanded(
                                                            child: appState.chats[
                                                                            index]
                                                                        [
                                                                        'last_message'] ==
                                                                    null
                                                                ? Text(
                                                                    DateFormat
                                                                            .yMd()
                                                                        .format(DateTime.parse(appState.chats[index]
                                                                            [
                                                                            'created_at'])),
                                                                    style: Theme.of(
                                                                            context)
                                                                        .primaryTextTheme
                                                                        .caption,
                                                                  )
                                                                : DateFormat.yMd().format(DateTime.parse(appState.chats[index]['last_message']['created_at'])) ==
                                                                        DateFormat.yMd()
                                                                            .format(new DateTime.now())
                                                                    ? Text(
                                                                        'Today',
                                                                        style: Theme.of(context)
                                                                            .primaryTextTheme
                                                                            .caption,
                                                                      )
                                                                    : Text(
                                                                        DateFormat.yMd().format(DateTime.parse(appState.chats[index]['last_message']
                                                                            [
                                                                            'created_at'])),
                                                                        style: Theme.of(context)
                                                                            .primaryTextTheme
                                                                            .caption,
                                                                      ),
                                                          ),
                                                          appState.chats[index][
                                                                      'unread_messages_count'] ==
                                                                  '0'
                                                              ? appState.chats[index]
                                                                              [
                                                                              'last_message']
                                                                          [
                                                                          'sender_id'].toString() !=
                                                                      auth.current_user[
                                                                          'id'].toString()
                                                                  ? Expanded(
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.bottomRight,
                                                                        child:
                                                                            CircleAvatar(
                                                                          radius:
                                                                              9,
                                                                          backgroundColor:
                                                                              Color(0xFFD6386F),
                                                                          child:
                                                                              Text(
                                                                            '${appState.chats[index]['unread_messages_count']}',
                                                                            style:
                                                                                Theme.of(context).primaryTextTheme.headline6,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : Text('')
                                                              : Text(''),
                                                        ],
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      appState.readChat(index);
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ChatScreen(appState
                                                                              .chats[
                                                                          index]
                                                                      ['id'])));
                                                    },
                                                  ),
                                                );
                                              }),
                                        )
                                      : Expanded(
                                          child: ListView.builder(
                                              itemCount: _chatsToShow.length,
                                              itemBuilder: (ctx, index) {
                                                dynamic _user =
                                                    auth.current_user['id'].toString() !=
                                                            _chatsToShow[index]
                                                                ['sender_id'].toString()
                                                        ? _chatsToShow[index]
                                                            ['sender']
                                                        : _chatsToShow[index]
                                                            ['receiver'];
                                                return Container(
                                                  alignment: Alignment.center,
                                                  margin:
                                                      EdgeInsets.only(top: 15),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: g.isDarkModeEnable
                                                        ? Color(0xFF1D0529)
                                                        : Colors.white54,
                                                  ),
                                                  height: 90,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: ListTile(
                                                    title: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  1.5),
                                                          margin: g.isRTL
                                                              ? EdgeInsets.only(
                                                                  left: 10)
                                                              : EdgeInsets.only(
                                                                  right: 10),
                                                          height: 60,
                                                          width: 60,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            color: Colors.white,
                                                          ),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          11),
                                                              color:
                                                                  Colors.purple,
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                              child:
                                                                  Image.network(
                                                                "${_user['avatar']}",
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            10),
                                                                    child: Text(
                                                                      '${_user['first_name'][0].toUpperCase()}${_user['first_name'].substring(1)} ${_user['last_name'][0].toUpperCase()}${_user['last_name'].substring(1)}',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .primaryTextTheme
                                                                          .subtitle2,
                                                                    ),
                                                                  ),
                                                                  // Padding(
                                                                  //   padding:
                                                                  //       const EdgeInsets
                                                                  //               .only(
                                                                  //           left: 4,
                                                                  //           bottom:
                                                                  //               10),
                                                                  //   child:
                                                                  //       CircleAvatar(
                                                                  //     radius: 4,
                                                                  //     backgroundColor:
                                                                  //         Colors.lightGreenAccent[
                                                                  //             400],
                                                                  //   ),
                                                                  // )
                                                                ],
                                                              ),
                                                              _chatsToShow[index]
                                                                          [
                                                                          'last_message'] ==
                                                                      null
                                                                  ? Text("-")
                                                                  : Text(
                                                                      '${_chatsToShow[index]['last_message']['body']}',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .primaryTextTheme
                                                                          .bodyText2,
                                                                    )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    trailing: Container(
                                                      height: 60,
                                                      width: 53,
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Expanded(
                                                            child: _chatsToShow[
                                                                            index]
                                                                        [
                                                                        'last_message'] ==
                                                                    null
                                                                ? Text(
                                                                    DateFormat
                                                                            .yMd()
                                                                        .format(DateTime.parse(_chatsToShow[index]
                                                                            [
                                                                            'created_at'])),
                                                                    style: Theme.of(
                                                                            context)
                                                                        .primaryTextTheme
                                                                        .caption,
                                                                  )
                                                                : DateFormat.yMd().format(DateTime.parse(_chatsToShow[index]['last_message']
                                                                            [
                                                                            'created_at'])) ==
                                                                        DateFormat.yMd()
                                                                            .format(new DateTime.now())
                                                                    ? Text(
                                                                        'Today',
                                                                        style: Theme.of(context)
                                                                            .primaryTextTheme
                                                                            .caption,
                                                                      )
                                                                    : Text(
                                                                        DateFormat.yMd().format(DateTime.parse(_chatsToShow[index]['last_message']
                                                                            [
                                                                            'created_at'])),
                                                                        style: Theme.of(context)
                                                                            .primaryTextTheme
                                                                            .caption,
                                                                      ),
                                                          ),
                                                          _chatsToShow[index][
                                                                      'unread_messages_count'] ==
                                                                  '0'
                                                              ? _chatsToShow[index]
                                                                              [
                                                                              'last_message']
                                                                          [
                                                                          'sender_id'].toString() !=
                                                                      auth.current_user[
                                                                          'id'].toString()
                                                                  ? Expanded(
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.bottomRight,
                                                                        child:
                                                                            CircleAvatar(
                                                                          radius:
                                                                              9,
                                                                          backgroundColor:
                                                                              Color(0xFFD6386F),
                                                                          child:
                                                                              Text(
                                                                            '${_chatsToShow[index]['unread_messages_count']}',
                                                                            style:
                                                                                Theme.of(context).primaryTextTheme.headline6,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : Text('')
                                                              : Text(''),
                                                        ],
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      appState.readChat(index);
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ChatScreen(appState
                                                                              .chats[
                                                                          index]
                                                                      ['id'])));
                                                    },
                                                  ),
                                                );
                                              }),
                                        )
                        ],
                      )),
                );
              })),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();

    final appState = Provider.of<AppState>(context, listen: false);
    if (appState.chats.isEmpty) {
      appState.getChats();
    }
    void _changeFilter() {
      setState(() {
        _chatsToShow = appState.chats
            .where((chat) =>
                chat['sender']['first_name'].contains(_filter.text) ||
                chat['sender']['last_name'].contains(_filter.text) ||
                chat['receiver']['first_name'].contains(_filter.text) ||
                chat['receiver']['last_name'].contains(_filter.text))
            .toList();
      });
    }

    _filter.addListener(_changeFilter);
  }

  PreferredSizeWidget _appBarWidget() {
    return PreferredSize(
      preferredSize: Size.fromHeight(70),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Consumer<Auth>(
              builder: (context, auth, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        highlightColor: Colors.transparent,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BottomNavigationWidgetLight(
                                    currentIndex: 3,
                                  )));
                        },
                        child: CircleAvatar(
                          radius: 22,
                          backgroundImage: auth.current_user['avatar'] == null
                              ? AssetImage('assets/images/holder.png')
                              : NetworkImage('${auth.current_user['avatar']}'),
                        ),
                      ),
                      Container(
                          child: Image.asset('assets/images/pets_logo2.png'),
                          width: MediaQuery.of(context).size.width * 0.5),
                      SizedBox(
                        width: 50,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
