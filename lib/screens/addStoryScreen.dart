import 'package:datingapp/models/businessLayer/baseRoute.dart';
import 'package:datingapp/models/businessLayer/global.dart' as g;
import 'package:datingapp/screens/createStoryScreen.dart';
import 'package:datingapp/screens/filterOptionsScreen.dart';
import 'package:datingapp/screens/myAnimalProfileScreen.dart';
import 'package:datingapp/screens/myProfileDetailScreen.dart';
import 'package:datingapp/screens/notificationListScreen.dart';
import 'package:datingapp/screens/splashScreen.dart';
import 'package:datingapp/screens/startConversionScreen.dart';
import 'package:datingapp/services/auth.dart';
import 'package:datingapp/widgets/bottomNavigationBarWidgetLight.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcard/tcard.dart';
import 'package:datingapp/services/dio.dart';
import 'package:dio/dio.dart' as Dio;

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
  bool _openDialog = false;
  bool _showMatch = false;

  List<dynamic> _recommendations = [];


  int _current = 0;

  _AddStoryScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(builder: (context, auth, child) {
      final auth = Provider.of<Auth>(context, listen: false);
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
              body: _recommendations.length == 0
                  ? Center(
                      child: Padding(
                        padding: g.isRTL
                            ? const EdgeInsets.only(right: 20, top: 10)
                            : const EdgeInsets.only(left: 20, top: 10),
                        child: const Text('No results to show...',
                            style: TextStyle(
                                color: Color.fromARGB(183, 73, 73, 73),
                                fontWeight: FontWeight.normal)),
                      ),
                    )
                  : Center(
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
                                      _openDialog
                                          ? Text('No results to show...')
                                          : AlertDialog(
                                              title: Text('Reset settings?'),
                                              content: Text(
                                                  'This will reset your device to its default factory settings.'),
                                              actions: [
                                                FlatButton(
                                                  textColor: Color(0xFF6200EE),
                                                  onPressed: () {},
                                                  child: Text('CANCEL'),
                                                ),
                                                FlatButton(
                                                  textColor: Color(0xFF6200EE),
                                                  onPressed: () {},
                                                  child: Text('ACCEPT'),
                                                ),
                                              ],
                                            ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom: 18, left: 10, right: 10),
                                        height: MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.6, //MediaQuery.of(context).size.height * 0.54,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
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
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .6,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .85,
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
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width,
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height),
                                                  onForward:
                                                      (index, info) async {
                                                    if (info.direction ==
                                                        SwipDirection.Left) {
                                                      if (_current ==
                                                          _recommendations
                                                              .length) {
                                                        print(
                                                            'we are doneeeee');
                                                      } else {
                                                        // DIIIIIIIIIIIIIIIIIISLIKEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
                                                        final prefs =
                                                            await SharedPreferences
                                                                .getInstance();
                                                        String token =
                                                            prefs.getString(
                                                                'i-pet-kk');
                                                        print(token);
                                                        print(auth.current_user[
                                                                'animals'][0]
                                                            ['id']);
                                                        print(_recommendations[
                                                            _current]['id']);
                                                        Dio.Response response =
                                                            await dio().post(
                                                                '/dislikes',
                                                                data: {
                                                                  'disliker_user_id':
                                                                      auth.current_user[
                                                                          'id'],
                                                                  'disliker_animal_id':
                                                                      auth.current_user['animals']
                                                                              [
                                                                              0]
                                                                          [
                                                                          'id'],
                                                                  'disliked_animal_id':
                                                                      _recommendations[
                                                                              _current]
                                                                          [
                                                                          'id'],
                                                                },
                                                                options:
                                                                    Dio.Options(
                                                                        headers: {
                                                                      'Authorization':
                                                                          'Bearer $token',
                                                                    }));
                                                        print(response.data);
                                                      }
                                                    }
                                                    if (info.direction ==
                                                        SwipDirection.Right) {
                                                      if (_current ==
                                                          _recommendations
                                                              .length) {
                                                        print(
                                                            'we are doneeeee');
                                                      } else {
                                                        // LIKEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
                                                        final prefs =
                                                            await SharedPreferences
                                                                .getInstance();
                                                        String token =
                                                            prefs.getString(
                                                                'i-pet-kk');

                                                        print(auth.current_user[
                                                            'id']);
                                                        print(_recommendations[
                                                                _current]
                                                            ['user']['id']);
                                                        print(auth.current_user[
                                                                'animals'][0]
                                                            ['id']);
                                                        print(_recommendations[
                                                            _current]['id']);
                                                        print(token);
                                                        Dio.Response response =
                                                            await dio().post(
                                                                '/likes',
                                                                data: {
                                                                  'liker_user_id':
                                                                      auth.current_user[
                                                                          'id'],
                                                                  'liked_user_id':
                                                                      _recommendations[_current]
                                                                              [
                                                                              'user']
                                                                          [
                                                                          'id'],
                                                                  'liker_animal_id':
                                                                      auth.current_user['animals']
                                                                              [
                                                                              0]
                                                                          [
                                                                          'id'],
                                                                  'liked_animal_id':
                                                                      _recommendations[
                                                                              _current]
                                                                          [
                                                                          'id'],
                                                                },
                                                                options:
                                                                    Dio.Options(
                                                                        headers: {
                                                                      'Authorization':
                                                                          'Bearer $token',
                                                                    }));
                                                        print(response.data);
                                                        if (response.data !=
                                                            "failed to like") {
                                                          if (response
                                                              .data['match']) {
                                                            setState(() {
                                                              _showMatch = true;
                                                              Navigator.of(
                                                                      context)
                                                                  .push(MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          StartConversionScreen(
                                                                              _recommendations[_current])));
                                                            });
                                                          }
                                                        } else {
                                                          setState(() {
                                                            _openDialog = true;
                                                          });
                                                        }
                                                        print(_current);
                                                        print(_recommendations
                                                            .length);
                                                        print(_openDialog);
                                                      }
                                                    }

                                                    setState(() {
                                                      if (_current !=
                                                          _recommendations
                                                                  .length -
                                                              1) {
                                                        _current = index;
                                                      }
                                                      _leftDirection = 0;
                                                      _rightDirection = 0;
                                                      _upDirection = 0;
                                                    });
                                                  },
                                                  onEnd: () {
                                                    // _controller.reset();
                                                    // _current = 0;
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    radius: 35,
                                                    child: CircleAvatar(
                                                      backgroundImage: _recommendations
                                                                      .length <=
                                                                  0 &&
                                                              _current >=
                                                                  _recommendations
                                                                      .length
                                                          ? AssetImage(
                                                              'assets/images/holder.png')
                                                          : NetworkImage(
                                                              'http://localhost:8000/${_recommendations[_current]['user']['avatar']}',
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
                                                      text: _recommendations
                                                                  .length ==
                                                              0
                                                          ? TextSpan(text: '-')
                                                          : TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      '${_recommendations[_current]['name'][0].toUpperCase()}${_recommendations[_current]['name'].substring(1).toLowerCase()}\n',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .accentTextTheme
                                                                      .headline3,
                                                                ),
                                                                TextSpan(
                                                                  text:
                                                                      "${_recommendations[_current]['user']['first_name'][0].toUpperCase()}${_recommendations[_current]['user']['first_name'].substring(1).toLowerCase()}\n${_recommendations[_current]['user']['last_name'][0].toUpperCase()}${_recommendations[_current]['user']['last_name'].substring(1).toLowerCase()}\n",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .accentTextTheme
                                                                      .subtitle2,
                                                                ),
                                                                // TextSpan(
                                                                //   text: '24 km away',
                                                                //   style: Theme.of(context)
                                                                //       .accentTextTheme
                                                                //       .subtitle1,
                                                                // ),
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Align(
                                                  child: Container(
                                                    height: 50,
                                                    padding: EdgeInsets.only(
                                                        left: 8),
                                                    child: DotsIndicator(
                                                      dotsCount:
                                                          _recommendations
                                                              .length,
                                                      position:
                                                          _current.toDouble(),
                                                      decorator: DotsDecorator(
                                                        spacing:
                                                            EdgeInsets.all(3),
                                                        color:
                                                            Colors.transparent,
                                                        activeColor:
                                                            Colors.white,
                                                        activeShape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          side: BorderSide(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          side: BorderSide(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // IconButton(
                                                //   icon: Icon(MdiIcons
                                                //       .messageReplyTextOutline),
                                                //   color: Colors.white,
                                                //   onPressed: () {
                                                //     Navigator.of(context).pop();
                                                //   },
                                                // )
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
                                padding:
                                    const EdgeInsets.only(top: 0, bottom: 30),
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
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
    });
  }

  @override
  void initState() {
    final auth = Provider.of<Auth>(context, listen: false);

    // TODO -- if no animal redirect to profile page!
    if (auth.current_user['animals'].length == 0) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => BottomNavigationWidgetLight(
                      currentIndex: 3,
                      
                    )),
            ModalRoute.withName('/'));
      });
    }
    super.initState();
    void getRecommendations() async {
      if (auth.current_user['animals'].length > 0) {
        Dio.Response response = await dio().get(
            '/recommendations?id=${auth.current_user['animals'][0]['id']}&first_load=true');
        setState(() {
          _recommendations = response.data;
        });
      }
    }

    getRecommendations();
  }

  _widgets() {
    List<Widget> _widgetList = [];

    for (int i = 0; i < _recommendations.length; i++) {
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
                child: Image.network(
                  'http://localhost:8000/${_recommendations[i]['avatars'][0]['url']}',
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
                              : NetworkImage(
                                  'http://localhost:8000/${auth.current_user['avatar']}'),
                        ),
                      ),
                      Container(
                          child: Image.asset('assets/images/pets_logo2.png'),
                          width: MediaQuery.of(context).size.width * 0.5),
                      IconButton(
                        icon: Icon(Icons.logout),
                        color: Color.fromARGB(510, 46, 49, 146),
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
