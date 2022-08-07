import 'package:PetsMating/models/businessLayer/baseRoute.dart';
import 'package:PetsMating/models/businessLayer/global.dart' as g;
import 'package:PetsMating/screens/videoCallingScreen.dart';
import 'package:PetsMating/services/app_state.dart';
import 'package:PetsMating/services/auth.dart';
import 'package:PetsMating/services/sender_socket.dart';
import 'package:PetsMating/widgets/bottomNavigationBarWidgetDark.dart';
import 'package:PetsMating/widgets/bottomNavigationBarWidgetLight.dart';
import 'package:PetsMating/widgets/drawerMenuWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:PetsMating/services/dio.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class ChatScreen extends StatefulWidget {
  final int chat_id;
  const ChatScreen(this.chat_id);
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic socket;
  Map usr;
  TabController _tabController;
  int _currentIndex = 0;
  Map<String, dynamic> _chat = {};
  TextEditingController _cMessage = new TextEditingController();
  _ChatScreenState() : super();
  bool emojiShowing = false;
  TextStyle fSize = TextStyle(
      fontSize: 13, color: Color(0xFF33196B), fontWeight: FontWeight.w500);

  final TextEditingController controller = TextEditingController();

  List<Widget> _messages = [];

  bool btnIsDisabled = false;

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
    return WillPopScope(
      onWillPop: () {
        if (emojiShowing) {
          setState(() {
            emojiShowing = false;
          });
        } else {
          return Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomNavigationWidgetLight(
                        currentIndex: 2,
                      )),
              ModalRoute.withName('/'));
        }
      },
      child: SafeArea(
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
              endDrawer: DrawerMenuWidget(usr, widget.chat_id),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: _chat.isEmpty || _chat['messages'].length < 1
                  ? Center(
                      child: Container(
                        height: 50,
                        child: LoadingIndicator(
                            indicatorType: Indicator.lineScalePulseOut,

                            /// Required, The loading type of the widget
                            colors: const [Color.fromARGB(255, 214, 27, 27)],

                            /// Optional, The color collections
                            strokeWidth: 2,

                            /// Optional, The stroke of the line, only applicable to widget which contains line
                            backgroundColor: Colors.transparent,

                            /// Optional, Background of the widget
                            pathBackgroundColor: Colors.black

                            /// Optional, the stroke backgroundColor
                            ),
                      ),
                    )
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
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.more_vert,
                                          size: 28,
                                        ),
                                        color:
                                            Theme.of(context).iconTheme.color,
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
                                          Navigator.of(context).pop();
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
                                      backgroundImage:
                                          auth.current_user['id'] !=
                                                  _chat['sender']['id']
                                              ? NetworkImage(
                                                  '${_chat['sender']['avatar']}',
                                                )
                                              : NetworkImage(
                                                  '${_chat['receiver']['avatar']}',
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
                                // Padding(
                                //   padding:
                                //       const EdgeInsets.only(left: 4, bottom: 6),
                                //   child: CircleAvatar(
                                //     radius: 4,
                                //     backgroundColor:
                                //         Colors.lightGreenAccent[400],
                                //   ),
                                // )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),

                            _renderMessages(),

                            // emojiShowing
                            //     ? Column(
                            //         children: [
                            //           SizedBox(
                            //             height: 255,
                            //             child: EmojiKeyboard(
                            //                 emotionController: controller,
                            //                 emojiKeyboardHeight: 255,
                            //                 showEmojiKeyboard: true,
                            //                 darkMode: true),
                            //           ),
                            //           SizedBox(
                            //             height: 50,
                            //           )
                            //         ],
                            //       )
                            //     : SizedBox(
                            //         height: 0,
                            //       )

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
                notchMargin: 0,
                color: g.isDarkModeEnable
                    ? Color(0xFF14012F)
                    : Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                child: Container(
                  // height: emojiShowing ? 315 : 65,
                  height: 60,
                  child: Column(
                    children: [
                      _chat['blocker_id'] != null
                          ? _chat['blocker_id'] == auth.current_user['id']
                              ? Container(
                                  decoration: BoxDecoration(color: Colors.red),
                                  width: MediaQuery.of(context).size.width,
                                  child: TextButton(
                                      onPressed: () async {
                                        try {
                                          final prefs = await SharedPreferences
                                              .getInstance();
                                          String token =
                                              prefs.getString('i-pet-kk');
                                          Dio.Response response = await dio().put(
                                              '/chat/${widget.chat_id}?todo=unblock',
                                              options: Dio.Options(headers: {
                                                'Authorization':
                                                    'Bearer $token',
                                              }));
                                          print(response);
                                          await auth.tryLogin(true);
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BottomNavigationWidgetLight(
                                                          currentIndex: 2)));
                                        } catch (e) {
                                          print(e);
                                        }
                                      },
                                      child: Text(
                                        'Unblock ${usr["first_name"][0].toUpperCase()}${usr["first_name"].substring(1)}',
                                        style: TextStyle(color: Colors.white),
                                      )))
                              : Container(
                                  decoration: BoxDecoration(color: Colors.red),
                                  width: MediaQuery.of(context).size.width,
                                  child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Blocked',
                                        style: TextStyle(color: Colors.white),
                                      )))
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  child: TextField(
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .subtitle2,
                                    controller: _cMessage,
                                    decoration: InputDecoration(
                                      contentPadding: g.isRTL
                                          ? EdgeInsets.only(right: 20)
                                          : EdgeInsets.only(left: 20),
                                      hintText: AppLocalizations.of(context)
                                          .lbl_hint_chat_type_msg,
                                      hintStyle: Theme.of(context)
                                          .primaryTextTheme
                                          .subtitle2,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 60,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: TabBar(
                                    controller: _tabController,
                                    indicatorWeight: 2,
                                    indicatorColor:
                                        Theme.of(context).primaryColorLight,
                                    labelColor:
                                        Theme.of(context).iconTheme.color,
                                    unselectedLabelColor:
                                        Theme.of(context).primaryColorLight,
                                    indicatorSize: TabBarIndicatorSize.label,
                                    indicatorPadding:
                                        EdgeInsets.only(bottom: 55),
                                    labelPadding: EdgeInsets.all(0),
                                    onTap: (int index) async {
                                      _currentIndex = index;
                                    },
                                    tabs: [
                                      !btnIsDisabled
                                          ? Tab(
                                              child: IconButton(
                                              iconSize: 20,
                                              icon: Icon(Icons.send),
                                              padding: EdgeInsets.all(0),
                                              onPressed: btnIsDisabled
                                                  ? null
                                                  : () async {
                                                      if (_cMessage
                                                          .text.isNotEmpty) {
                                                        setState(() {
                                                          btnIsDisabled = true;
                                                        });

                                                        dynamic msg =
                                                            await _sendMessageTo(
                                                                chatId: widget
                                                                    .chat_id,
                                                                body: _cMessage
                                                                    .text);

                                                        if (msg == "sent") {
                                                          _cMessage.clear();
                                                        }
                                                        setState(() {
                                                          btnIsDisabled = false;
                                                        });
                                                      }
                                                    },
                                            ))
                                          : Tab(
                                              child: IconButton(
                                              iconSize: 20,
                                              icon: Icon(Icons.circle_outlined),
                                              padding: EdgeInsets.all(0),
                                              onPressed: btnIsDisabled
                                                  ? null
                                                  : () async {
                                                      if (_cMessage
                                                          .text.isNotEmpty) {
                                                        setState(() {
                                                          btnIsDisabled = true;
                                                        });

                                                        dynamic msg =
                                                            await _sendMessageTo(
                                                                chatId: widget
                                                                    .chat_id,
                                                                body: _cMessage
                                                                    .text);

                                                        if (msg == "sent") {
                                                          _cMessage.clear();
                                                        }
                                                        setState(() {
                                                          btnIsDisabled = false;
                                                        });
                                                      }
                                                    },
                                            )),
                                      // Tab(
                                      //   child: IconButton(
                                      //     iconSize: 20,
                                      //     icon: Icon(MdiIcons.emoticonHappy),
                                      //     padding: EdgeInsets.all(0),
                                      //     onPressed: () async {
                                      //       setState(() {
                                      //         emojiShowing =
                                      //             emojiShowing ? false : true;
                                      //       });
                                      //       if (emojiShowing) {
                                      //         _scrollController.animateTo(
                                      //           0.0,
                                      //           curve: Curves.easeOut,
                                      //           duration: const Duration(
                                      //               milliseconds: 300),
                                      //         );
                                      //       }
                                      //     },
                                      //   ),
                                      // ),
                                      // Tab(
                                      //   child: Icon(
                                      //     MdiIcons.attachment,
                                      //     size: 20,
                                      //   ),
                                      // ),
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
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  void _updateChatFromSocket() {
    final auth = Provider.of<Auth>(context, listen: false);
    setState(() {
      _updateChat(auth);
    });
  }

  void initSock() async {
    final auth = Provider.of<Auth>(context, listen: false);
    socket = senderSocketInit(
        userId: auth.current_user['id'],
        context: context,
        refreshChat: _updateChatFromSocket);
  }

  @override
  void initState() {
    super.initState();
    initSock();
    _tabController =
        new TabController(length: 1, vsync: this, initialIndex: _currentIndex);
    _tabController.addListener(_tabControllerListener);
    Future getChat() async {
      dynamic auth = Provider.of<Auth>(context, listen: false);
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('i-pet-kk');
      await dio().get('/chat/${widget.chat_id}',
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      try {
        setState(() {
          _updateChat(auth);
        });
      } catch (e) {
        print(e);
      }
    }

    void getUsr() {
      try {
        final auth = Provider.of<Auth>(context, listen: false);
        setState(() {
          usr = auth.current_user['id'] == _chat['sender_id']
              ? _chat['receiver']
              : _chat['sender'];
        });
      } catch (e) {
        print(e);
      }
    }

    Future getChatUsr() async {
      await getChat();
      getUsr();
    }

    void getFontSize() async {
      final prefs = await SharedPreferences.getInstance();
      String fontSize = prefs.getString('i-pet-kk-fontsize');
      if (fontSize == null || fontSize == 'Small') {
        setState(() {
          fSize = TextStyle(
              fontSize: 11,
              color: Color(0xFF33196B),
              fontWeight: FontWeight.w400);
        });
      }
      if (fontSize == 'Medium') {
        setState(() {
          fSize = TextStyle(
              fontSize: 13,
              color: Color(0xFF33196B),
              fontWeight: FontWeight.w500);
        });
      }
      if (fontSize == 'Large') {
        setState(() {
          fSize = TextStyle(
              fontSize: 15,
              color: Color(0xFF33196B),
              fontWeight: FontWeight.w500);
        });
      }
    }

    getFontSize();
    getChatUsr();
  }

  void dispose() {
    socket.dispose();
    socket.disconnect();

    super.dispose();
    socket.disconnect();
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
                                style: fSize,
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
    // print(currentUser['id'] != msg['sender_id']);

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
                                child: currentUser['id'] != msg['sender_id']
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
                                style: fSize,
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

  sendMessage(String message, senderId) {
    socket.emit(
      "message",
      {
        "chat_id": widget.chat_id,
        "body": message,
        "sender_id": senderId,
        "receiver_id": usr['id']
      },
    );
  }

  _sendMessageTo({chatId, body}) async {
    final appState = Provider.of<AppState>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    try {
      sendMessage(body, auth.current_user['id']);
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('i-pet-kk');
      Dio.Response response = await dio().post('/messages',
          data: {'chat_id': chatId, 'body': body},
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $token',
          }));

      if (response.data != 'failed') {
        _scrollController.animateTo(
          0.0,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
        setState(() {
          emojiShowing = false;
          appState.insertComingMessage(response.data, true);
          _updateChat(auth);
        });
        return 'sent';
      }
    } catch (e) {
      print(e);
    }
  }

  _updateChat(auth) {
    _chat = Provider.of<AppState>(context, listen: false)
        .chats
        .where((chat) => chat['id'] == widget.chat_id)
        .toList()[0];
    setState(() {
      _messages = [];

      for (var msg in _chat['messages']) {
        if (auth.current_user['id'].toString() == msg['sender_id'].toString()) {
          _messages.add(_myMessage(msg));
        } else {
          _messages.add(_hisMessage(msg, auth.current_user));
        }
      }
    });
  }

  _renderMessages() {
    if (_messages.length > 0) {
      return Expanded(
        child: ListView(
            reverse: true,
            controller: _scrollController,
            shrinkWrap: true,
            children: <Widget>[
              // emojiShowing
              //     ? SizedBox(height: 10)
              //     :
              SizedBox(
                height: 70,
              ),
              ..._messages,
            ]),
      );
    } else {
      return Text('data');
    }
  }
}
