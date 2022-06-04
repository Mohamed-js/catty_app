import 'package:PetsMating/screens/addMessageScreen.dart';
import 'package:PetsMating/screens/addStoryScreen1.dart';
import 'package:PetsMating/screens/myProfileDetailScreen.dart';
import 'package:PetsMating/screens/notificationListScreen.dart';
import 'package:flutter/material.dart';
import 'package:PetsMating/models/businessLayer/global.dart' as g;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:laravel_echo/laravel_echo.dart';
import 'package:flutter_pusher_client/flutter_pusher.dart';

class BottomNavigationWidgetLight extends StatefulWidget {
  final int currentIndex;
  const BottomNavigationWidgetLight({this.currentIndex});
  @override
  State<BottomNavigationWidgetLight> createState() =>
      new _BottomNavigationWidgetLightState(this.currentIndex);
}

class _BottomNavigationWidgetLightState
    extends State<BottomNavigationWidgetLight> with TickerProviderStateMixin {
  int currentIndex;
  int _currentIndex = 0;
  TabController _tabController;
  _BottomNavigationWidgetLightState(this.currentIndex) : super();

  @override
  void dispose() {
    super.dispose();
  }

  Channel _channel;
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
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            elevation: 0,
            child: Container(
              height: 65,
              decoration: BoxDecoration(color: Colors.white),
              child: TabBar(
                controller: _tabController,
                indicatorWeight: 3,
                indicatorColor: Theme.of(context).primaryColorLight,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.only(bottom: 65),
                onTap: (int index) async {
                  _currentIndex = index;
                  setState(() {});
                },
                tabs: [
                  _tabController.index != 0
                      ? Tab(
                          icon: Icon(MdiIcons.cards, color: Colors.grey[800]),
                        )
                      : Tab(
                          icon: ShaderMask(
                              blendMode: BlendMode.srcIn,
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  colors: g.gradientColors,
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ).createShader(bounds);
                              },
                              child: Icon(MdiIcons.cards)),
                        ),
                  _tabController.index != 1
                      ? Tab(
                          icon: Icon(Icons.notifications_rounded,
                              color: Colors.grey[800]),
                        )
                      : Tab(
                          icon: ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: g.gradientColors,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ).createShader(bounds);
                          },
                          child: Icon(
                            Icons.notifications_rounded,
                          ),
                        )),
                  _tabController.index != 2
                      ? Tab(
                          icon: Icon(MdiIcons.messageReplyTextOutline,
                              color: Colors.grey[800]),
                        )
                      : Tab(
                          icon: ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: g.gradientColors,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ).createShader(bounds);
                          },
                          child: Icon(MdiIcons.messageReplyTextOutline),
                        )),
                  _tabController.index != 3
                      ? Tab(
                          icon: Icon(MdiIcons.account, color: Colors.grey[800]),
                        )
                      : Tab(
                          icon: ShaderMask(
                              blendMode: BlendMode.srcIn,
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  colors: g.gradientColors,
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ).createShader(bounds);
                              },
                              child: Icon(MdiIcons.account)),
                        ),
                ],
              ),
            ),
          ),
          body: _screens().elementAt(_currentIndex),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // START CONNECTION WITH CHANNELS
    // START CONNECTION WITH CHANNELS

    Future<void> _initPusher() async {
      PusherOptions options = PusherOptions(
        host: 'https://i-pet.herokuapp.com/',
        port: 6001,
        encrypted: false,
      );
      FlutterPusher pusher = FlutterPusher('app', options, enableLogging: true,
          onConnectionStateChange: (e) {
        print(e.currentState);
      }, onError: (e) {
        print('error happened');
        print(e.message);
        print(e.exception);
        print(e.code);
        print('error happened');
      });

      pusher.subscribe('home').bind('NewMessage', (event) => {});

      Echo echo = new Echo({
        'broadcaster': 'pusher',
        'client': pusher,
      });

      echo.listen('home', 'NewMessage', (e) {
        print(e);
      });

      // echo.disconnect();

      // Echo.socket.on('connect', (_) => print('connect'));
      // socket.on('disconnect', (_) => print('disconnect'));
    }

    // _initPusher();

    // END
    // END
    if (currentIndex != null) {
      setState(() {
        _currentIndex = currentIndex;
      });
    }
    _tabController =
        new TabController(length: 4, vsync: this, initialIndex: _currentIndex);
    _tabController.addListener(_tabControllerListener);
  }

  void _tabControllerListener() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  List<Widget> _screens() => [
        AddStoryScreen(),
        NotificationListScreen(),
        AddMessageScreen(),
        MyProfileScreen(),
      ];
}
