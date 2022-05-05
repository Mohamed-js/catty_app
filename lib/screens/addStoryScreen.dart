import 'package:datingapp/models/businessLayer/baseRoute.dart';
import 'package:datingapp/models/businessLayer/global.dart' as g;
import 'package:datingapp/screens/createStoryScreen.dart';
import 'package:datingapp/screens/filterOptionsScreen.dart';
import 'package:datingapp/screens/myAnimalProfileScreen.dart';
import 'package:datingapp/screens/myProfileDetailScreen.dart';
import 'package:datingapp/screens/notificationListScreen.dart';
import 'package:datingapp/screens/splashScreen.dart';
import 'package:datingapp/services/auth.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tcard/tcard.dart';

class AddStoryScreen extends BaseRoute {
  AddStoryScreen({a, o}) : super(a: a, o: o, r: 'AddStoryScreen');
  @override
  _AddStoryScreenState createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends BaseRouteState {
  TCardController _controller = new TCardController();
  int _leftDirection;
  int _rightDirection;
  int _upDirection;

  final List<String> _imgList = [
    'assets/images/animal.jpg',
    'assets/images/animal1.jpg',
    'assets/images/animal2.jpg',
    'assets/images/animal3.jpg',
    'assets/images/animal4.jpg',
    'assets/images/animal5.jpg',
    'assets/images/animal6.jpg',
    'assets/images/animal7.jpg',
  ];
  int _current = 0;

  _AddStoryScreenState() : super();

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
            appBar: _appBarWidget(),
            backgroundColor: g.isDarkModeEnable
                ? Color(0xFF03000C)
                : Theme.of(context).scaffoldBackgroundColor,
            body: Center(
              child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: 18, left: 10, right: 10),
                                height: MediaQuery.of(context).size.height *
                                    0.53, //MediaQuery.of(context).size.height * 0.54,
                                width: MediaQuery.of(context).size.width * 0.80,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(g.isDarkModeEnable
                                        ? 'assets/images/cards_dark.png'
                                        : 'assets/images/cards_light.png'),
                                  ),
                                ),
                              ),
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height * .7,
                                    width:
                                        MediaQuery.of(context).size.width * .85,
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Listener(
                                        onPointerMove:
                                            (PointerMoveEvent _event) {
                                          if (_event.delta.dy > 0) {
                                            setState(() {
                                              _leftDirection = 1;
                                              _rightDirection = null;
                                              _upDirection = null;
                                            });
                                          }
                                          if (_event.delta.dx > 0) {
                                            setState(() {
                                              _rightDirection = 2;
                                              _leftDirection = null;
                                              _upDirection = null;
                                            });
                                          }
                                        },
                                        child: TCard(
                                          cards: _widgets(),
                                          controller: _controller,
                                          size: Size(
                                              MediaQuery.of(context).size.width,
                                              MediaQuery.of(context)
                                                  .size
                                                  .height),
                                          onForward: (index, info) {
                                            if (info.direction ==
                                                SwipDirection.Left) {
                                              setState(() {
                                                _current = index;
                                                _leftDirection = 0;
                                                _rightDirection = 0;
                                                _upDirection = 0;
                                              });
                                            }
                                            if (info.direction ==
                                                SwipDirection.Right) {
                                              setState(() {
                                                _current = index;
                                                _leftDirection = 0;
                                                _rightDirection = 0;
                                                _upDirection = 0;
                                              });
                                            }
                                          },
                                          onEnd: () {
                                            _controller.reset();
                                            _current = 0;
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(18.0),
                                  //   child: CircleAvatar(
                                  //     backgroundColor: Color(0xFF230f4E),
                                  //     child: IconButton(
                                  //       icon: Icon(
                                  //         Icons.bug_report,
                                  //       ),
                                  //       color: Colors.white,
                                  //       onPressed: () {
                                  //         Navigator.of(context).pop();
                                  //       },
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 30),
                                alignment: Alignment.bottomLeft,
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 35,
                                            child: CircleAvatar(
                                              backgroundImage: AssetImage(
                                                _imgList[_current],
                                              ),
                                              radius: 32,
                                            ),
                                          ),
                                          Padding(
                                            padding: g.isRTL
                                                ? const EdgeInsets.only(
                                                    right: 6)
                                                : const EdgeInsets.only(
                                                    left: 6),
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Wolverine\n',
                                                    style: Theme.of(context)
                                                        .accentTextTheme
                                                        .headline3,
                                                  ),
                                                  TextSpan(
                                                    text: 'Salma\nAli\n',
                                                    style: Theme.of(context)
                                                        .accentTextTheme
                                                        .subtitle2,
                                                  ),
                                                  TextSpan(
                                                    text: '24 km away',
                                                    style: Theme.of(context)
                                                        .accentTextTheme
                                                        .subtitle1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          child: Container(
                                            height: 50,
                                            padding: EdgeInsets.only(left: 8),
                                            child: DotsIndicator(
                                              dotsCount: _imgList.length,
                                              position: _current.toDouble(),
                                              decorator: DotsDecorator(
                                                spacing: EdgeInsets.all(3),
                                                color: Colors.transparent,
                                                activeColor: Colors.white,
                                                activeShape:
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  side: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  side: BorderSide(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                              MdiIcons.messageReplyTextOutline),
                                          color: Colors.white,
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0, bottom: 30),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                _controller.forward(
                                    direction: SwipDirection.Left);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: CircleAvatar(
                                  backgroundColor: Color(0xFFF0384F),
                                  radius: 24,
                                  child: CircleAvatar(
                                    radius: 22,
                                    backgroundColor: _leftDirection == 1
                                        ? Color(0xFFF0384F)
                                        : Colors.white,
                                    child: Icon(
                                      Icons.close,
                                      color: _leftDirection == 1
                                          ? Colors.white
                                          : Color(0xFFF0384F),
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _controller.forward(
                                    direction: SwipDirection.None);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  radius: 20,
                                  child: CircleAvatar(
                                    radius: 18,
                                    backgroundColor: _upDirection == 3
                                        ? Colors.blue
                                        : Colors.white,
                                    child: Icon(
                                      Icons.star,
                                      color: _upDirection == 3
                                          ? Colors.white
                                          : Colors.blue,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _controller.forward(
                                    direction: SwipDirection.Right);
                              },
                              child: CircleAvatar(
                                backgroundColor: Color(0xFF34F07F),
                                radius: 24,
                                child: CircleAvatar(
                                  radius: 22,
                                  backgroundColor: _rightDirection == 2
                                      ? Color(0xFF34F07F)
                                      : Colors.white,
                                  child: Icon(
                                    Icons.favorite,
                                    color: _rightDirection == 2
                                        ? Colors.white
                                        : Color(0xFF34F07F),
                                    size: 22,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  _widgets() {
    List<Widget> _widgetList = [];
    for (int i = 0; i < _imgList.length; i++) {
      _widgetList.add(
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white,
                ),
                color: Colors.black,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  _imgList[i],
                  height: MediaQuery.of(context).size.height * 0.70,
                  width: MediaQuery.of(context).size.width * 0.75,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.70 - 1.5,
              width: MediaQuery.of(context).size.width * 0.75 - 1.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      );
    }
    return _widgetList;
  }

  PreferredSizeWidget _appBarWidget() {
    return PreferredSize(
      preferredSize: Size.fromHeight(60),
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
                              builder: (context) => MyProfileScreen(
                                    a: widget.analytics,
                                    o: widget.observer,
                                  )));
                        },
                        child: CircleAvatar(
                          radius: 18,
                          backgroundImage: auth.current_user['avatar'] == null
                              ? AssetImage('assets/images/holder.png')
                              : NetworkImage('http://localhost:8000/${auth.current_user['avatar']}'),
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
                            padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                            child: Text("I-Pet",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Color(0xFFF0384F),
                                )),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.logout),
                        color: Color.fromARGB(255, 82, 8, 255),
                        onPressed: () async {
                          final auth =
                              Provider.of<Auth>(context, listen: false);
                          auth.logout();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SplashScreen()));
                        },
                      ),
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
