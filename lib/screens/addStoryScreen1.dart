import 'package:PetsMating/models/businessLayer/baseRoute.dart';
import 'package:PetsMating/models/businessLayer/global.dart' as g;
import 'package:PetsMating/screens/createStoryScreen.dart';
import 'package:PetsMating/screens/filterOptionsScreen.dart';
import 'package:PetsMating/screens/myAnimalProfileScreen.dart';
import 'package:PetsMating/screens/myProfileDetailScreen.dart';
import 'package:PetsMating/screens/notificationListScreen.dart';
import 'package:PetsMating/screens/splashScreen.dart';
import 'package:PetsMating/screens/startConversionScreen.dart';
import 'package:PetsMating/services/app_state.dart';
import 'package:PetsMating/services/auth.dart';
import 'package:PetsMating/widgets/bottomNavigationBarWidgetLight.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:PetsMating/services/dio.dart';
import 'package:dio/dio.dart' as Dio;
import 'dart:developer';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class AddStoryScreen extends BaseRoute {
  AddStoryScreen({a, o}) : super(a: a, o: o, r: 'AddStoryScreen');
  @override
  _AddStoryScreenState createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends BaseRouteState {
  double _leftDirection = 0;
  double _rightDirection = 0;
  int _upDirection;
  bool _openDialog = false;
  bool _showMatch = false;

  String token = '';

  List<String> welcomeImages = [
    'assets/images/animal1.jpg',
    'assets/images/animal2.jpg',
    'assets/images/animal3.jpg',
    'assets/images/animal4.jpg',
    'assets/images/animal5.jpg',
  ];

  Widget tCardy;

  dynamic authy;
  dynamic appStaty;

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
                body: _openDialog
                    ? Center(
                        child: Padding(
                          padding: g.isRTL
                              ? const EdgeInsets.only(right: 20, top: 10)
                              : const EdgeInsets.only(left: 20, top: 10),
                          child: const Text(
                              'Cannot like more!\n Your quota is finished!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromARGB(183, 24, 5, 5),
                                  fontWeight: FontWeight.normal)),
                        ),
                      )
                    : _recommendations.length == 0 ||
                            _current >= _recommendations.length
                        ? Center(
                            child: Padding(
                              padding: g.isRTL
                                  ? const EdgeInsets.only(right: 20, top: 10)
                                  : const EdgeInsets.only(left: 20, top: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 100,
                                    child: LoadingIndicator(
                                        indicatorType: Indicator.orbit,

                                        /// Required, The loading type of the widget
                                        colors: const [
                                          Color.fromARGB(255, 214, 27, 27)
                                        ],

                                        /// Optional, The color collections
                                        strokeWidth: 2,

                                        /// Optional, The stroke of the line, only applicable to widget which contains line
                                        backgroundColor: Colors.transparent,

                                        /// Optional, Background of the widget
                                        pathBackgroundColor: Colors.black

                                        /// Optional, the stroke backgroundColor
                                        ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Trying to',
                                      style: TextStyle(
                                          color: Color.fromARGB(183, 24, 5, 5),
                                          fontWeight: FontWeight.normal)),
                                  Text('find more matches!',
                                      style: TextStyle(
                                          color: Color.fromARGB(183, 24, 5, 5),
                                          fontWeight: FontWeight.normal)),
                                ],
                              ),
                            ),
                          )
                        : AnimatedOpacity(
                            // If the widget is visible, animate to 0.0 (invisible).
                            // If the widget is hidden, animate to 1.0 (fully visible).
                            opacity: _recommendations.length != 0 ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 500),
                            // The green box must be a child of the AnimatedOpacity widget.
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          // Container(
                                          //   margin: EdgeInsets.only(
                                          //       bottom: 18, left: 10, right: 10),
                                          //   height: MediaQuery.of(context)
                                          //           .size
                                          //           .height *
                                          //       0.7, //MediaQuery.of(context).size.height * 0.54,
                                          //   width:
                                          //       MediaQuery.of(context).size.width *
                                          //           0.85,
                                          //   decoration: BoxDecoration(
                                          //     image: DecorationImage(
                                          //       image: AssetImage(g.isDarkModeEnable
                                          //           ? 'assets/images/cards_dark.png'
                                          //           : 'assets/images/cards_light.png'),
                                          //     ),
                                          //   ),
                                          // ),
                                          // TINDERRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR === start
                                          Container(
                                            child: _recommendations.length > 0
                                                ? new TinderSwapCard(
                                                    swipeUp: false,
                                                    swipeDown: false,
                                                    orientation:
                                                        AmassOrientation.BOTTOM,
                                                    totalNum:
                                                        _recommendations.length,
                                                    stackNum: 3,
                                                    minWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.75,
                                                    maxWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.85,
                                                    minHeight:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.5,
                                                    maxHeight:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .55,
                                                    cardBuilder:
                                                        (context, index) =>
                                                            Card(
                                                      elevation: 0,
                                                      borderOnForeground: false,
                                                      color: Colors.transparent,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        child: Image.network(
                                                          '${_recommendations[index]['avatars'][0]['url']}',
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    )
                                                    // )
                                                    ,
                                                    cardController:
                                                        CardController(),
                                                    swipeUpdateCallback:
                                                        (DragUpdateDetails
                                                                details,
                                                            Alignment align) {
                                                      /// Get swiping card's alignment
                                                      if (align.x < 0) {
                                                        _rightDirection = 0;
                                                        setState(() {
                                                          _leftDirection =
                                                              align.x;
                                                        });
                                                      } else if (align.x > 0) {
                                                        _leftDirection = 0;
                                                        setState(() {
                                                          _rightDirection =
                                                              align.x;
                                                        });
                                                      }
                                                    },
                                                    swipeCompleteCallback:
                                                        (CardSwipeOrientation
                                                                orientation,
                                                            int index) async {
                                                      if (orientation ==
                                                          CardSwipeOrientation
                                                              .LEFT) {
                                                        // REQEUST ===========
                                                        try {
                                                          Dio.Response
                                                              response =
                                                              await dio().post(
                                                                  '/dislikes',
                                                                  data: {
                                                                    'disliker_user_id':
                                                                        authy.current_user[
                                                                            'id'],
                                                                    'disliker_animal_id':
                                                                        authy.current_user['animals'][0]
                                                                            [
                                                                            'id'],
                                                                    'disliked_animal_id':
                                                                        _recommendations[_current]
                                                                            [
                                                                            'id'],
                                                                  },
                                                                  options: Dio
                                                                      .Options(
                                                                          headers: {
                                                                        'Authorization':
                                                                            'Bearer $token',
                                                                      }));
                                                          setState(() {
                                                            _leftDirection = 0;
                                                            _rightDirection = 0;
                                                            _current =
                                                                _current + 1;
                                                          });
                                                          print(
                                                              'lefteddddddddddddddddddddd');
                                                        } catch (e) {
                                                          print(e);
                                                        }
                                                      } else {
                                                        try {
                                                          Dio.Response
                                                              response =
                                                              await dio().post(
                                                                  '/likes',
                                                                  data: {
                                                                    'liker_user_id':
                                                                        auth.current_user[
                                                                            'id'],
                                                                    'liked_user_id':
                                                                        _recommendations[_current]
                                                                            [
                                                                            'user_id'],
                                                                    'liker_animal_id':
                                                                        auth.current_user['animals'][0]
                                                                            [
                                                                            'id'],
                                                                    'liked_animal_id':
                                                                        _recommendations[_current]
                                                                            [
                                                                            'id'],
                                                                  },
                                                                  options: Dio
                                                                      .Options(
                                                                          headers: {
                                                                        'Authorization':
                                                                            'Bearer $token',
                                                                      }));
                                                          setState(() {
                                                            _leftDirection = 0;
                                                            _rightDirection = 0;
                                                            _current =
                                                                _current + 1;
                                                          });
                                                          print(
                                                              'righteddddddddddddddd');

                                                          if (response.data !=
                                                              "failed to like") {
                                                            if (response.data[
                                                                'match']) {
                                                              setState(() {
                                                                _showMatch =
                                                                    true;
                                                                Navigator.of(
                                                                        context)
                                                                    .push(MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                StartConversionScreen(_recommendations[index])));
                                                              });
                                                            }
                                                          } else {
                                                            setState(() {
                                                              _openDialog =
                                                                  true;
                                                            });
                                                          }
                                                        } catch (e) {
                                                          print(e);
                                                        }
                                                      }

                                                      if ((_current) ==
                                                          (_recommendations
                                                              .length)) {
                                                        getRecommendations(true,
                                                            appStaty, auth);
                                                      }
                                                    },
                                                  )
                                                : Center(
                                                    child: Padding(
                                                      padding: g.isRTL
                                                          ? const EdgeInsets
                                                                  .only(
                                                              right: 20,
                                                              top: 10)
                                                          : const EdgeInsets
                                                                  .only(
                                                              left: 20,
                                                              top: 10),
                                                      child: const Text(
                                                          'No more matches for now!',
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(183,
                                                                      24, 5, 5),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal)),
                                                    ),
                                                  ),
                                          ),
                                          // TINDERRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR === end
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0, bottom: 30),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  Color(0xFFF0384F),
                                              radius: 24,
                                              child: CircleAvatar(
                                                radius: 22,
                                                backgroundColor:
                                                    _leftDirection < 0
                                                        ? Color(0xFFF0384F)
                                                        : Colors.white,
                                                child: Icon(
                                                  Icons.close,
                                                  color: _leftDirection < 0
                                                      ? Colors.white
                                                      : Color(0xFFF0384F),
                                                  size: 22,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: CircleAvatar(
                                              backgroundColor: Colors.blue,
                                              radius: 20,
                                              child: CircleAvatar(
                                                radius: 18,
                                                backgroundColor:
                                                    _upDirection == 3
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
                                          onTap: () {},
                                          child: CircleAvatar(
                                            backgroundColor: Color(0xFF34F07F),
                                            radius: 24,
                                            child: CircleAvatar(
                                              radius: 22,
                                              backgroundColor:
                                                  _rightDirection > 0
                                                      ? Color(0xFF34F07F)
                                                      : Colors.white,
                                              child: Icon(
                                                Icons.favorite,
                                                color: _rightDirection > 0
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
                              ),
                            ),
                          )),
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    final auth = Provider.of<Auth>(context, listen: false);
    final appState = Provider.of<AppState>(context, listen: false);

    setState(() {
      authy = auth;
      appStaty = appState;
    });

    // if no animal redirect to profile page!
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

    getRecommendations(true, appState, auth);
    super.initState();
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
                      // IconButton(
                      //   icon: Icon(Icons.logout),
                      //   color: Color.fromARGB(510, 46, 49, 146),
                      //   onPressed: () async {
                      //     final auth =
                      //         Provider.of<Auth>(context, listen: false);
                      //     auth.logout();
                      //     Navigator.of(context).push(MaterialPageRoute(
                      //         builder: (context) => SplashScreen()));
                      //   },
                      // ),
                      SizedBox(
                        width: 35,
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

  void getRecommendations(firstLoad, appState, auth) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('i-pet-kk');
    });
    await appState.getFilterOptions();
    final options = appState.filter_options;

    try {
      Dio.Response response;
      if (auth.current_user['animals'].length > 0) {
        int animalId = prefs.getInt('i-pet-current-animal-id');
        try {
          if (animalId != null) {
            // TODO -- make sure the existing one is one of the current user's animals!
            response = await dio().get(
                '/recommendations?id=${auth.current_user['animals'][0]['id']}&first_load=$firstLoad&same_breed=${options['same_breed']}&no_vaccination_needed=${options['no_vaccination_needed']}&min=${options['min_age']}&max=${options['max_age']}');
          } else {
            response = await dio().get(
                '/recommendations?id=${auth.current_user['animals'][0]['id']}&first_load=$firstLoad&same_breed=${options['same_breed']}&no_vaccination_needed=${options['no_vaccination_needed']}&min=${options['min_age']}&max=${options['max_age']}');
            prefs.setInt('i-pet-current-animal-id',
                auth.current_user['animals'][0]['id']);
          }
          print('starttttttttttttttttttttttttttt recs');
          print(_recommendations);
          print('recs111111111111');
          int toStart = _recommendations.length;
          setState(() {
            _recommendations = response.data;
            _current = 0;
          });

          print('recs2222222222222222');
          print(response.data);
        } catch (e) {
          print(e);
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
