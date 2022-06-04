import 'package:datingapp/models/businessLayer/baseRoute.dart';
import 'package:datingapp/models/businessLayer/global.dart' as g;
import 'package:datingapp/screens/videoCallingScreen.dart';
import 'package:datingapp/services/app_state.dart';
import 'package:datingapp/services/auth.dart';
import 'package:datingapp/widgets/bottomNavigationBarWidgetDark.dart';
import 'package:datingapp/widgets/bottomNavigationBarWidgetLight.dart';
import 'package:datingapp/widgets/drawerMenuWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:datingapp/services/dio.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final int chat_id;
  const ChatScreen(this.chat_id);
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController _tabController;
  int _currentIndex = 0;
  Map<String, dynamic> _chat = {};
  TextEditingController _cMessage = new TextEditingController();
  _ChatScreenState() : super();

  List<Widget> _messages = [];

  ScrollController _scrollController = new ScrollController();
  // This is what you're looking for!
  void _scrollDown() {
    _scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            key: _scaffoldKey,
            endDrawer: DrawerMenuWidget(),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: _chat.isEmpty || _chat['messages'].length < 1
                ? Text('loading...')
                : Center(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.bottomCenter,
                            clipBehavior: Clip.none,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    alignment: g.isRTL
                                        ? Alignment.topLeft
                                        : Alignment.topRight,
                                    width: MediaQuery.of(context).size.width,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.more_vert,
                                        size: 28,
                                      ),
                                      color: Theme.of(context).iconTheme.color,
                                      onPressed: () {
                                        _scaffoldKey.currentState
                                            .openEndDrawer();
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    alignment: g.isRTL
                                        ? Alignment.topRight
                                        : Alignment.topLeft,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xffD6376E),
                                          Color(0xFFAD45B3)
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                    width: 75,
                                    height: 65,
                                    child: IconButton(
                                      icon: Icon(
                                          FontAwesomeIcons.longArrowAltLeft),
                                      color: Colors.white,
                                      onPressed: () {
                                        // Navigator.of(context).pushAndRemoveUntil(
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             BottomNavigationWidgetLight(
                                        //               currentIndex: 2,
                                        //               a: widget.analytics,
                                        //               o: widget.observer,
                                        //             )));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 10,
                                child: CircleAvatar(
                                  radius: 57,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 55,
                                    backgroundImage: auth.current_user['id'] !=
                                            _chat['sender']['id']
                                        ? NetworkImage(
                                            'https://i-pet.herokuapp.com/${_chat['sender']['avatar']}',
                                          )
                                        : NetworkImage(
                                            'https://i-pet.herokuapp.com/${_chat['receiver']['avatar']}',
                                          ),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          // TODOOOOOOOOOOO
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              auth.current_user['id'] != _chat['sender']['id']
                                  ? Text(
                                      _chat['sender']['first_name'][0]
                                              .toUpperCase() +
                                          _chat['sender']['first_name']
                                              .substring(1) +
                                          " " +
                                          _chat['sender']['last_name'][0]
                                              .toUpperCase() +
                                          _chat['sender']['last_name']
                                              .substring(1),
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline3,
                                    )
                                  : Text(
                                      _chat['receiver']['first_name'][0]
                                              .toUpperCase() +
                                          _chat['receiver']['first_name']
                                              .substring(1) +
                                          " " +
                                          _chat['receiver']['last_name'][0]
                                              .toUpperCase() +
                                          _chat['receiver']['last_name']
                                              .substring(1),
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline3,
                                    ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4, bottom: 6),
                                child: CircleAvatar(
                                  radius: 4,
                                  backgroundColor: Colors.lightGreenAccent[400],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),

                          _renderMessages(),

                          // VIDEO CALLLLLLLLLLLLLLL
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 5),
                          //   child: Row(
                          //     mainAxisSize: MainAxisSize.min,
                          //     children: [
                          //       IconButton(
                          //         icon: Image.asset(
                          //           'assets/images/chat icon.png',
                          //           height: 30,
                          //         ),
                          //         color: Theme.of(context).iconTheme.color,
                          //         onPressed: () {},
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.only(left: 8),
                          //         child: IconButton(
                          //           icon: ShaderMask(
                          //               blendMode: BlendMode.srcIn,
                          //               shaderCallback: (Rect bounds) {
                          //                 return LinearGradient(
                          //                   colors: [Color(0xFFFA809D), Color(0xFFFB2205E)],
                          //                   begin: Alignment.centerLeft,
                          //                   end: Alignment.centerRight,
                          //                 ).createShader(bounds);
                          //               },
                          //               child: Icon(FontAwesomeIcons.video)),
                          //           color: Theme.of(context).iconTheme.color,
                          //           onPressed: () {
                          //             Navigator.of(context).push(MaterialPageRoute(
                          //                 builder: (context) => VideoCallingScreen(
                          //                       a: widget.analytics,
                          //                       o: widget.observer,
                          //                     )));
                          //           },
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // -============================================-
                          // Today
                          // Container(
                          //   margin: EdgeInsets.only(top: 10),
                          //   alignment: Alignment.center,
                          //   child: Chip(
                          //     backgroundColor: g.isDarkModeEnable
                          //         ? Color(0xFF1F1828)
                          //         : Color(0xFF7974AA),
                          //     label: Text(
                          //       'Today',
                          //       style:
                          //           Theme.of(context).accentTextTheme.subtitle1,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    // HEREEEEEEEEEE
                  ),
            bottomSheet: BottomAppBar(
              color: g.isDarkModeEnable
                  ? Color(0xFF14012F)
                  : Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: TextField(
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                      controller: _cMessage,
                      decoration: InputDecoration(
                        contentPadding: g.isRTL
                            ? EdgeInsets.only(right: 20)
                            : EdgeInsets.only(left: 20),
                        hintText:
                            AppLocalizations.of(context).lbl_hint_chat_type_msg,
                        hintStyle: Theme.of(context).primaryTextTheme.subtitle2,
                      ),
                    ),
                  ),
                  Container(
                    height: 65,
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: TabBar(
                      controller: _tabController,
                      indicatorWeight: 3,
                      indicatorColor: Theme.of(context).primaryColorLight,
                      labelColor: Theme.of(context).iconTheme.color,
                      unselectedLabelColor: Theme.of(context).primaryColorLight,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorPadding: EdgeInsets.only(bottom: 55),
                      labelPadding: EdgeInsets.all(0),
                      onTap: (int index) async {
                        _currentIndex = index;
                        setState(() {});
                      },
                      tabs: [
                        Tab(
                            child: IconButton(
                          iconSize: 20,
                          icon: Icon(Icons.send),
                          padding: EdgeInsets.all(0),
                          onPressed: () async {
                            dynamic msg = await _sendMessageTo(
                                chatId: widget.chat_id, body: _cMessage.text);

                            if (msg == "sent") {
                              _cMessage.clear();
                            }
                          },
                        )),
                        Tab(
                          child: Icon(
                            MdiIcons.emoticonHappy,
                            size: 20,
                          ),
                        ),
                        Tab(
                          child: Icon(
                            MdiIcons.attachment,
                            size: 20,
                          ),
                        ),
                        // Tab(
                        //   child: Icon(
                        //     MdiIcons.microphone,
                        //     size: 20,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _tabController =
        new TabController(length: 3, vsync: this, initialIndex: _currentIndex);
    _tabController.addListener(_tabControllerListener);
    void getChat() async {
      dynamic current_usr =
          await Provider.of<Auth>(context, listen: false).current_user;
      final prefs = await SharedPreferences.getInstance();
      try {
        String token = prefs.getString('i-pet-kk');
        Dio.Response response = await dio().get('/chat/${widget.chat_id}',
            options: Dio.Options(headers: {
              'Authorization': 'Bearer $token',
            }));
        setState(() {
          _chat = response.data;
          for (var msg in _chat['messages']) {
            if (current_usr['id'] == msg['sender_id']) {
              _messages.add(_myMessage(msg));
            } else {
              _messages.add(_hisMessage(msg, current_usr));
            }
          }
        });
      } catch (e) {
        print(e);
      }
    }

    getChat();
  }

  void dispose() {
    super.dispose();
    final appState = Provider.of<AppState>(context, listen: false);
    appState.getChats();
  }

  void _tabControllerListener() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  _myMessage(msg) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(right: 5, top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              // height: MediaQuery.of(context).size.height * 0.09,
              decoration: BoxDecoration(
                color: g.isDarkModeEnable ? Color(0xFF3B1159) : Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.35),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ListTile(
                  title: Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 5, right: 5, bottom: 5),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  'You',
                                  style: g.isDarkModeEnable
                                      ? Theme.of(context)
                                          .primaryTextTheme
                                          .subtitle1
                                      : Theme.of(context)
                                          .accentTextTheme
                                          .bodyText2,
                                ),
                              ),
                              Text(
                                msg['body'],
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText1,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      DateFormat('hh:mm a')
                          .format(DateTime.parse(msg['created_at'])),
                      style: Theme.of(context).primaryTextTheme.overline,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _hisMessage(msg, currentUser) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(left: 5, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              // height: MediaQuery.of(context).size.height * 0.09,
              decoration: BoxDecoration(
                color: g.isDarkModeEnable
                    ? Color(0xFF1C0726)
                    : Color.fromARGB(255, 253, 253, 255),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.35),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ListTile(
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 5, right: 5, bottom: 5),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: currentUser['id'] !=
                                        _chat['sender']['id']
                                    ? Text(
                                        _chat['sender']['first_name'][0]
                                                .toUpperCase() +
                                            _chat['sender']['first_name']
                                                .substring(1) +
                                            " " +
                                            _chat['sender']['last_name'][0]
                                                .toUpperCase() +
                                            _chat['sender']['last_name']
                                                .substring(1),
                                        style: Theme.of(context)
                                            .accentTextTheme
                                            .headline6,
                                      )
                                    : Text(
                                        _chat['receiver']['first_name'][0]
                                                .toUpperCase() +
                                            _chat['receiver']['first_name']
                                                .substring(1) +
                                            " " +
                                            _chat['receiver']['last_name'][0]
                                                .toUpperCase() +
                                            _chat['receiver']['last_name']
                                                .substring(1),
                                        style: Theme.of(context)
                                            .accentTextTheme
                                            .headline6,
                                      ),
                              ),
                              Text(
                                msg['body'],
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText1,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      DateFormat('hh:mm a')
                          .format(DateTime.parse(msg['created_at'])),
                      style: Theme.of(context).primaryTextTheme.overline,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _sendMessageTo({chatId, body}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('i-pet-kk');
      Dio.Response response = await dio().post('/messages',
          data: {'chat_id': chatId, 'body': body},
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $token',
          }));

      if (response.data != 'failed') {
        setState(() {
          _messages.add(_myMessage(response.data));
        });
        return 'sent';
      }
    } catch (e) {
      print(e);
    }
  }

  _renderMessages() {
    if (_messages.length > 0) {
      return Expanded(
        child: ListView(
            controller: _scrollController,
            shrinkWrap: true,
            children: <Widget>[
              ..._messages,
              SizedBox(
                height: 90,
              )
            ]),
      );
    }
  }
}
