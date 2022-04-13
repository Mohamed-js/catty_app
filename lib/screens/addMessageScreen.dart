import 'package:datingapp/models/addNewMessageModel.dart';
import 'package:datingapp/models/businessLayer/baseRoute.dart';
import 'package:datingapp/models/businessLayer/global.dart' as g;
import 'package:datingapp/screens/chatScreen.dart';
import 'package:datingapp/screens/createStoryScreen.dart';
import 'package:datingapp/screens/startConversionScreen.dart';
import 'package:datingapp/screens/viewStoryScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddMessageScreen extends BaseRoute {
  AddMessageScreen({a, o}) : super(a: a, o: o, r: 'AddMessageScreen');
  @override
  _AddMessageScreenState createState() => _AddMessageScreenState();
}

class _AddMessageScreenState extends BaseRouteState {
  TextEditingController _cSearch = new TextEditingController();

  final List<String> circleImageList = [
    'assets/images/img_circle_0.png',
    'assets/images/img_circle_1.png',
    'assets/images/img_circle_2.png',
    'assets/images/img_circle_0.png',
    'assets/images/img_circle_1.png',
    'assets/images/img_circle_2.png',
  ];

  List<AddNewMessage> _addNewMsgList = [
    new AddNewMessage(name: 'Salma Ali', time: '03:45 PM', imgPath: 'assets/images/card_img_0.png', messageCount: 2, lastMessage: 'Hi, How are you? Is that your dog?'),
    new AddNewMessage(name: 'Mohammed Saleh', time: '11:49 AM', imgPath: 'assets/images/sample1.jpg', messageCount: 3, lastMessage: 'كيف الحال يا صديقي؟!'),
  ];

  _AddMessageScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          return exitAppDialog();
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
            appBar: _appBarWidget2(),
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
                          color: g.isDarkModeEnable ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        height: 55,
                        child: TextFormField(
                          controller: _cSearch,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            contentPadding: g.isRTL ? EdgeInsets.only(right: 22, top: 15) : EdgeInsets.only(left: 22, top: 15),
                            hintText: AppLocalizations.of(context).hint_Searchlbl_Search_Message_match,
                            hintStyle: Theme.of(context).primaryTextTheme.subtitle2,
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          AppLocalizations.of(context).lbl_Add_your_Story,
                          style: Theme.of(context).primaryTextTheme.subtitle1,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: g.isRTL ? const EdgeInsets.only(right: 15) : EdgeInsets.only(left: 10),
                            child: Image.asset(
                              g.isDarkModeEnable ? 'assets/images/swirl arrow.png' : 'assets/images/swirl arrow_light.png',
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: circleImageList.length,
                                itemBuilder: (ctx, index) {
                                  return InkWell(
                                    onTap: () {
                                      index == 0
                                          ? Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => CreateStoryScreen(
                                                    a: widget.analytics,
                                                    o: widget.observer,
                                                  )))
                                          : Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => ViewStoryScreen(
                                                    a: widget.analytics,
                                                    o: widget.observer,
                                                  )));
                                    },
                                    child: Padding(
                                      padding: g.isRTL ? const EdgeInsets.only(left: 10) : const EdgeInsets.only(right: 10),
                                      child: index == 0
                                          ? CircleAvatar(
                                              radius: 25,
                                              backgroundColor: Color(0xFFF1405B),
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                            )
                                          : CircleAvatar(
                                              radius: 26,
                                              backgroundColor: Colors.white,
                                              child: CircleAvatar(
                                                radius: 25,
                                                backgroundColor: Color(0xFFF1405B),
                                                backgroundImage: AssetImage(
                                                  circleImageList[index],
                                                ),
                                              ),
                                            ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          ]
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        AppLocalizations.of(context).lbl_All_Messages,
                        style: Theme.of(context).primaryTextTheme.headline3,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: _addNewMsgList.length,
                          itemBuilder: (ctx, index) {
                            return Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: g.isDarkModeEnable ? Color(0xFF1D0529) : Colors.white54,
                              ),
                              height: 90,
                              width: MediaQuery.of(context).size.width,
                              child: ListTile(
                                title: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(1.5),
                                      margin: g.isRTL ? EdgeInsets.only(left: 10) : EdgeInsets.only(right: 10),
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.white,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(11),
                                          color: Colors.purple,
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Image.asset(
                                            _addNewMsgList[index].imgPath,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 10),
                                                child: Text(
                                                  '${_addNewMsgList[index].name}',
                                                  style: Theme.of(context).primaryTextTheme.subtitle1,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 4, bottom: 10),
                                                child: CircleAvatar(
                                                  radius: 4,
                                                  backgroundColor: Colors.lightGreenAccent[400],
                                                ),
                                              )
                                            ],
                                          ),
                                          Text(
                                            '${_addNewMsgList[index].lastMessage}',
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context).primaryTextTheme.bodyText2,
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
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${_addNewMsgList[index].time}',
                                          style: Theme.of(context).primaryTextTheme.caption,
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: CircleAvatar(
                                            radius: 9,
                                            backgroundColor: Color(0xFFD6386F),
                                            child: Text(
                                              '${_addNewMsgList[index].messageCount}',
                                              style: Theme.of(context).primaryTextTheme.headline6,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                            a: widget.analytics,
                                            o: widget.observer,
                                          )));
                                },
                              ),
                            );
                          }),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  PreferredSizeWidget _appBarWidget() {
    return PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListTile(
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Theme.of(context).primaryColorLight,
                    child: IconButton(
                      icon: Icon(MdiIcons.messageReplyTextOutline),
                      color: Colors.white,
                      iconSize: 20,
                      onPressed: () {},
                    ),
                  ),
                  Padding(
                    padding: g.isRTL ? const EdgeInsets.only(right: 8) : const EdgeInsets.only(left: 8),
                    child: Text(
                      AppLocalizations.of(context).lbl_Add_new_message,
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                    ),
                  ),
                ],
              ),
              trailing: Icon(
                Icons.delete,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _appBarWidget2() {
    return PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                      highlightColor: Colors.transparent,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CreateStoryScreen(
                                  a: widget.analytics,
                                  o: widget.observer,
                                )));
                      },
                      child: CircleAvatar(
                        radius: 18,
                        backgroundImage: AssetImage('assets/images/profile_img_0.png'),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.android,
                          color: Color(0xFFF0384F),
                          size: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4,0,0,0),
                          child: Text(
                            "Catty",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Color(0xFFF0384F),
                            )
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 28)
                  ],
                ),
            ),
          ),
        ],
      ),
    );
  }
}
